From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: GSoC 2016
Date: Fri, 19 Feb 2016 12:40:04 +0530
Message-ID: <CA+DCAeSjBWrnnfzsM+u9ZQ7Z4swNU_dWiG+UemF+Z2QKqnU8qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 08:10:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWfCq-0000E9-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 08:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbcBSHKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 02:10:12 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34022 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbcBSHKG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 02:10:06 -0500
Received: by mail-qk0-f177.google.com with SMTP id x1so27860988qkc.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 23:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=K1SZfz2SqS/gC/tdwdnJeheAzB6ySetSEToT8XENP7k=;
        b=wTauk+QwI8pb4VBwevsL6CvsyVFr7UHm3VInZRZHFvnDkWO99IEV4ZngHlNKBprSY7
         qKXVjmQhky0wt4tO7mU9MgMkbD1+JZA320BiLSSuVr+jrOSls9GAQ4QD654PPQrWiOwA
         LUHFt5pemhzwlHE7F95Io9JdovMS2UY9qztzkgt22J/duxTHzWbDefFWHHkVjTDAnTOI
         6l/iOefxymkec4TInXB1m2mUMNViwHrhi4CIDUUXqzVtkxG7ueV1CWpLY+ZIn2R4s74F
         ZZOjXVuPwv7zrAJcpZBdxKfdfetF9kd1rbL8xOT8ezaMhyVd9KhICgOuZwHlJgtQvSnH
         I62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=K1SZfz2SqS/gC/tdwdnJeheAzB6ySetSEToT8XENP7k=;
        b=E1VJ4U5U3va6jzp8pKoDje0XwUO7F/qtBRuX08hudhGL3ie2pdV2Cz0vXyrxRnFtxy
         0H08j0c1x3FunP/Qc33A7pBESgz2FXO5oAwPHaxoBDHLaQ2GhOCXw2WzyhTi/uCmKHkl
         VfzaOFOVjDYkSI6ph6dDkcFSJ/mr1Q2BM4Y1qrffX0nuiF9pAnxBbWzW/LOLVieQHCkA
         SpZ6n9o/QV5L5daxJ3pTgGntwjbdUn/aJo4p9E4jD4MsCJBDzlechP14uAOU4ikuZmMU
         u15DcV8bNWGjwF5XquE/NrY3ISKsV65aoPR3qpclivb9Hlby/fTxnbbKmdcDvE8lU538
         PYdA==
X-Gm-Message-State: AG10YOTuaw6Ata6UdAs6vkcyd774A+SVC3eVMRa4K9GZYAQ7XaMRhjF9yzdZluhu1YNiSvmYN89vAcJz8NkDPQ==
X-Received: by 10.55.54.201 with SMTP id d192mr13734999qka.23.1455865804455;
 Thu, 18 Feb 2016 23:10:04 -0800 (PST)
Received: by 10.55.166.10 with HTTP; Thu, 18 Feb 2016 23:10:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286660>

Hello everyone,

I'm Mehul Jain. I'm looking for participating in GSoC 2016.

I've started work on a Microproject" Teach git pull --rebase the
--no-autostash" option. While looking at Git's source code I have made
following observation: In the pull.c file
1.  git_config_get_bool( , ) search in the configuration key for the
value of rebase.autostash, if found true then modify autostash's value
to a non-zero number and thus making a stash to encounter the problem
of dirty tree.
2. Here if in command line a flag "--no-autostash" is given then we
can easily set the value of autostash = 0 and thus killing the process
by die_on_unclean_work_tree(prefix).
Is my observation is right?

I'm new to open source projects and not much experienced at it. So
please correct/comment on any mistake that I made while trying to put
my point. I will also appreciate any comment/suggestion/criticism on
my observation.

Thanks
