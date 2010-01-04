From: Dongas <dongas86@gmail.com>
Subject: A question about changing remote repo name
Date: Mon, 4 Jan 2010 14:45:09 +0800
Message-ID: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 07:45:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRgh4-0006um-Fk
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 07:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab0ADGpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 01:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785Ab0ADGpO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 01:45:14 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:53035 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0ADGpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 01:45:12 -0500
Received: by ywh6 with SMTP id 6so15081714ywh.4
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 22:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=DPG+z8he0AqVC8ZvBPwHMDjCJswW5qk6SlhcGE8Bx40=;
        b=NIHRxg4Uv4LGLfnva8zknXRqwsEvGtjqAvrW1uPwU/w6RyQ/PcEoAuau6B9BaWDTla
         5N2V9Ah43dOpinOC4/1HF1zyRHBq3B0qI7N78v9L76zWEU2pMmbZ6Y7gFpc1jC+yyr+y
         vGI3Eo04jc3fX0oPxASbUvWOVm1dsxTDLFxuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qRWZqLy0Vi69y94iyXBNVVfkSHt8JQNvfwhwTPmHCiSv835DLy/PuIcK7OjvAs5dbL
         XnOSbZvo60G8QwRsrfESR0S40IxWfZFwkqp9fZgBhfRqLCdGxfBnpU1auUREIq84j7ZH
         VApN25iDSarR90hlYkxyu/kwS9h+FmjDs78SU=
Received: by 10.90.16.9 with SMTP id 9mr3219027agp.44.1262587509445; Sun, 03 
	Jan 2010 22:45:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136096>

Hi ALL,

I'm running ubuntu 9.04 and the git coming along with it doesn't
support git remote rename command.
Below is the man page of it:
GIT-REMOTE(1)
                                        Git Manual

     GIT-REMOTE(1)

NAME
       git-remote - manage set of tracked repositories

SYNOPSIS
           git remote [-v | --verbose]
           git remote add [-t <branch>] [-m <master>] [-f] [--mirror]
<name> <url>
           git remote rm <name>
           git remote show [-n] <name>
           git remote prune [-n | --dry-run] <name>
           git remote update [group]
Note: There's no rename option.

So i need to change the remote name manually.

I tried modifying the .git/config file locally but it didn't work.

Could someone help tell how to do it?

Thanks

Regards
Dongas
