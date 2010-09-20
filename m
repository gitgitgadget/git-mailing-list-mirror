From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Newbie question
Date: Mon, 20 Sep 2010 01:31:50 -0700 (PDT)
Message-ID: <m31v8pl11m.fsf@localhost.localdomain>
References: <1284940287810-5548737.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kinley <arjuncode@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 10:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxbn5-0007Pi-Hf
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab0ITIbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:31:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56620 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab0ITIbx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:31:53 -0400
Received: by bwz11 with SMTP id 11so4071175bwz.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=6vaDxV31uMEMDWm92ILL1rGT5Wq77BJusxkeINVGczU=;
        b=AIWcAfItg4WkLi6Xs6s8HD+OojA74xHE5IHHPWejN26NnQieHSbL+S7Ufts7Zga8sQ
         2hTiyQ5rR2jH7X3P6GQlsmB13XwyvQeSSFCQQHjk7m/WX+4g+8yNMpgW1qBCFyL7CpSi
         iNxbMk1vwWPQwA9kZlI37g9KPmVUc2cfZzIbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=sG6Q4wD4M0qEm7Om/rbWisYrraVW2RbxFK2kiKjKFaC2FLil71+hkwImnrBqGGjdPD
         CXOYXUzETLYFD3jwdpLs04ET9q8qvubzF/kZH2xosXTZOXfigdDHjJaWGozZ8ooaug+X
         5WzQmByAvjdNMfDo8l9Z0qPNQKmOMci527QQ0=
Received: by 10.204.75.81 with SMTP id x17mr6601303bkj.72.1284971511756;
        Mon, 20 Sep 2010 01:31:51 -0700 (PDT)
Received: from localhost.localdomain (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id f10sm6258745bkl.17.2010.09.20.01.31.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:31:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8K0JCwg001270;
	Mon, 20 Sep 2010 02:19:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8K0J2cd001266;
	Mon, 20 Sep 2010 02:19:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1284940287810-5548737.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156597>

kinley <arjuncode@gmail.com> writes:

> I am new to question. Please help me with this.
> I copied an already existing project from a remote server using scp to my
> local directory.

In the future use "git clone <scp-location>" instead of 'scp'.

> The contents of this directory are
>    branches
>    config
>    description
>    HEAD
>    hooks
>    info
>    objects
>    ref
> 
> I checked all the directories and sub-directories but could not find a
> single source code file (in C language).
> All I can see at the leaf level appear to be MD5 hash code.
> 
> Is there any command to retrieve the source files ? 
> As per manual, only then I guess I can add them to git.

You have the repository itself (the object database containg all
version info plus other info).  Put those files and directories into
<project>/.git subdirectory, and use "git checkout" from within it.
You should have checked out files in <project>/ directory.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
