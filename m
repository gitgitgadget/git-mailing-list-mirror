From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/3] post-receive-email: explicitly set Content-Type
 header
Date: Fri, 2 Aug 2013 16:21:18 -0700
Message-ID: <20130802232118.GB2963@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Shumkin <alex.crezoff@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Alexander Gerasiov <gq@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 01:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Of2-0004z4-QM
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 01:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab3HBXVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 19:21:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33312 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab3HBXVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 19:21:24 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so1180137pab.13
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=r+GjuaM5JVCWvAVZsMSPMDAljFZt5yZfUVzNfzpAZkc=;
        b=IQuh/jzS0/RUaAuuUpvX1xd4teCSzUwjU1Gn1v6gwL5pDhyrK41AAkh33fv5e9U8st
         6zsevOZFzwGfNseesS1NcRdc702clXdyiwogt4LfAcwj3SceMcRbutc9NA7TICcV9H+V
         gChNPqR8TSCCaooWD32TbmCF0L9AnfG0FKLluRIKWGGybzBcjpgNk7LqEaRZ+l11w85u
         Aj+5VtsDgg3YMfG9LnOGCpptoFzV0dvAfEsyL6kMI/iyILu26pjEwjdDHupxbDKEXbUq
         Bp9ohOrXyrA2ClE/doAwMqkSnliP91W6wIKFSV7+r8XMv2U/75F2tsMcD288/NemGMi7
         quLA==
X-Received: by 10.66.240.2 with SMTP id vw2mr13060162pac.137.1375485683515;
        Fri, 02 Aug 2013 16:21:23 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ot4sm12901761pac.17.2013.08.02.16.21.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 16:21:21 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231544>

Hi all,

This is a revival of [1], which declares encoding in emails to make it
more likely that they can be read.  I like to think it avoids the
mistakes of previous attempts, but I'll let you judge. :)

Sorry for the long delay.  Thoughts of all kinds welcome, as always.

Thanks,
Jonathan

Gerrit Pape (1):
  hooks/post-receive-email: set declared encoding to utf-8

Jonathan Nieder (2):
  hooks/post-receive-email: use plumbing instead of 'git log' and 'git show'
  hooks/post-receive-email: force log messages in UTF-8

 contrib/hooks/post-receive-email | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/181737/focus=183070
