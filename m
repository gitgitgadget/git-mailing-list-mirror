From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Mon, 19 Jan 2009 11:59:28 +0000
Message-ID: <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 13:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOsoI-0001J4-KP
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 13:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772AbZASL7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 06:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758552AbZASL7a
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 06:59:30 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:42393 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772AbZASL73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 06:59:29 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3155347wfd.4
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 03:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CyOV3MQRZnx9+hubbQkr3EIvbr6LSCbBNS/HJC3ZYOE=;
        b=hp5n6gO2by0bovwwhRcDcRvS0CsC6KeHcBJIrkQg1Ibh9aFcJQkDpQ57YrNyqi3AJU
         1P71u5GsjDyl4YQCru/+QW6tcdn7KASCtuij//pEISDkYeCOUfPKRScrHgeFMYwuQNOI
         v6/ztnfl/KyMwkKZT01Msie5Osa2BpXmWUIlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rXc4O6bimrNYI4uaVQr8hoEe+CLHNNUNk3yamuPlMCFNLdC/eXErMtmsHTPzUhCA16
         hHfFaEIeVXzdCgklMDuEozNPKMDm8q5LOKumIKwjzIybghF5FUmindJgaloQkmLxWBg7
         SKIVUINH3waIlmUApDJrXqDWxnjEWPTgD3Bqc=
Received: by 10.142.43.7 with SMTP id q7mr2334438wfq.207.1232366368700; Mon, 
	19 Jan 2009 03:59:28 -0800 (PST)
In-Reply-To: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106348>

2009/1/19 Dilip M <dilipm79@gmail.com>:
> Hi,
>
> ..I recently install GIT on Ubuntu (hardy) box....I am able to use
> 'gitk' only If I do 'sudo'. Without 'sudo' it complains 'repository
> not found'

Who is the owner of the repository directory (and the .git directory)
and what are the permissions on the directory? You can run (on the
command line from the Terminal program):

   ls -lh directory

to find this out (where directory is the directory you are interested
in) and run:

   sudo chown user -R directory

to change ownership of that directory (and all of its content) to the
specified user (i.e. the one you are currently logged in as). This
will make it so that you own that directory and can make changes to
it. This should allow you to run gitk without using sudo.

HTH,
- Reece
