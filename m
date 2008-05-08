From: "Geoffrey Irving" <irving@naml.us>
Subject: automatically removing missing files beneath a directory
Date: Thu, 8 May 2008 09:39:22 -0700
Message-ID: <7f9d599f0805080939j3ef5e145w9bc2ac94f559b036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 18:40:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9AH-0004H7-NK
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 18:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYEHQj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 12:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbYEHQj0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 12:39:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:58574 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbYEHQjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 12:39:25 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1043132rvb.1
        for <git@vger.kernel.org>; Thu, 08 May 2008 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=cg+CYwGCVtu/He6Efs7gxWyTH6hxfovAT/9Psu/0Ru4=;
        b=KukTjKVa4BYjvshAkcbHM3oifQXIRM3RRiQ092NeTer2YkKW42qQ2TNKaNiVTlTA9Jr150HMvdyH1IWVeydxzktKl4YhxC/FaQ3XsysZf+wJx7MUfIvgE2M+vfrgDIl1ky2beGuA0B1WbwONykI151NU/q+bedjcOcmcGRPAsFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Yb0X1nCgWU31+Vb2gMYe95KF3d09goJm1TvZurAkGehmJ0LkjXLnkvlxjWn+hNmXDb7QujanJxJmAtbbhHcRNvLxOmqZqwm44J2e5ohaOq+vyzEwgzJMb8A4uwnNKsU06uxX/zTYYfeJIGYtm/ZKj7KVu+sYas9JTrBm6Z66z1Y=
Received: by 10.141.18.14 with SMTP id v14mr1610625rvi.236.1210264762655;
        Thu, 08 May 2008 09:39:22 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Thu, 8 May 2008 09:39:22 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 57573cc4e9b17cf1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81536>

If I have a subdirectory in a git repository, and I remove some files
without telling git, is there is a simple way to automatically run the
equivalent of 'git rm' for all the missing files?  git commit -a would
work, except that I only want to remove files beneath a particular
subdirectory.  git add <directory> does the equivalent operation for
adding files, but I don't see a way to automatically remove them
without parsing the output of git status.

Thanks,
Geoffrey
