From: Quim K Holland <qkholland@gmail.com>
Subject: Re: How to ignore a modified file?
Date: Thu, 05 Mar 2009 14:53:08 +0600
Message-ID: <20090305145308.6117@qkholland.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: dealmaker <vinkhc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 09:55:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9My-0000WB-Ux
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 09:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZCEIya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 03:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbZCEIy3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 03:54:29 -0500
Received: from mail-ew0-f164.google.com ([209.85.219.164]:34650 "EHLO
	mail-ew0-f164.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZCEIy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 03:54:28 -0500
Received: by ewy8 with SMTP id 8so1620106ewy.13
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:date:subject
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=TeyBmiRttMXUgX6pwqwTpFj2gKUR1f2YzV211AIBl20=;
        b=G8o+ezXB4DGY0G6Jg3r1PrsZ59g9+mcgBfcaTQzIUQ7BY6/h+EYwhomzu9FwTOM8Pj
         T822rAwT+D/3MNG8VT3Umh+x44izC/k+5z6Inqfw6VwnBev+bNXhurNNUFagPvgIzQh/
         snveM0LUbbryUd1iRgW+4U9XiMvN1bOkrGz+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:date:subject:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=h2Hy5rRTOccm4T3+3sj+KNv8LF66i5dOIrtdXAe9bZtMaP4DH9VYLaqBDVOrWnYt1h
         Mxg6fY7am2uUeFJam2E66gkY7QFE3+0i57vwgsO7vrqso8+0MjsBete2VSe+JF4uSb5O
         kcUuPtIAYhN4oU8VO9Sb8rcnSGdf2KqjLTIu0=
Received: by 10.216.50.69 with SMTP id y47mr423124web.91.1236243265394;
        Thu, 05 Mar 2009 00:54:25 -0800 (PST)
Received: from 5662.smtp.gmail.com ([212.62.97.21])
        by mx.google.com with ESMTPS id 7sm2024513eyg.47.2009.03.05.00.54.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Mar 2009 00:54:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112270>

You can run "git checkout directory".

> Hi, 
>   I run "git status", and I saw the a modified file in a directory.  I want
> to ignore all files in that directory.  I put the directory name into
> .gitignore, but it still shows as modified file.  Why?  How do I ignore the
> directory?
> Thanks.
> -- 
> View this message in context: http://n2.nabble.com/How-to-ignore-a-modified-file--tp2428157p2428157.html
> Sent from the git mailing list archive at Nabble.com.
