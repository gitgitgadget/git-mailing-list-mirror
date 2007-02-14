From: "David Tweed" <david.tweed@gmail.com>
Subject: "freezing" gitk geometry
Date: Wed, 14 Feb 2007 17:23:51 +0000
Message-ID: <e1dab3980702140923m1e4e430ci28f8ed246c5fe786@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 18:23:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNrH-0001n9-Nd
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbXBNRXx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbXBNRXw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:23:52 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:17070 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbXBNRXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:23:52 -0500
Received: by nz-out-0506.google.com with SMTP id s1so262448nze
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 09:23:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Swac3DLghmSr6CMofFdBV+KrEdLgz7zxxZ78Uopwpx+mUr6MPuf8Pl46A8SBdoAZdmyuW586oM5PWEx0BbOsCy2pTm8LqGQH5AsHkMgBvHYFLu7OozUh0c/sAEecBfsLw/11lnRWJEJ1HbhsBAbFg3S3C8h6TvkUWsAA5msNoIg=
Received: by 10.64.10.2 with SMTP id 2mr1065823qbj.1171473831725;
        Wed, 14 Feb 2007 09:23:51 -0800 (PST)
Received: by 10.65.160.13 with HTTP; Wed, 14 Feb 2007 09:23:51 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39696>

Hi,

now I've installed 1.5.0, I've discovered gitk is still the
visualisation tool for graphically browsing history. I think gitk is a
good program, but one thing I'd like to be able to change is to have a
way to force gitk not to update its saved internal geometry (position
of internal dividers, etc) when it exits. I tried making ~/.gitk not
writable but that didn't work. I don't know tcl: is there a simple way
to prevent gitk updating this upon quitting?

(Why do I want this? A tiling window manager often changes the size of
clients automatically to fit things onto the screen as new windows
appear. Sometimes this results in windows being made quite small. If I
quit gitk without expanding it up to full size "just to get the
geometry right" it stores a crushed geometry which gets restored when
it's restarted regardless of the actual window space currently
available.)

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould
