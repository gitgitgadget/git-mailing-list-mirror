From: Andy Parkins <andyparkins@gmail.com>
Subject: /etc/gitconfig
Date: Wed, 14 Feb 2007 09:09:26 +0000
Message-ID: <200702140909.28369.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 10:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHG8v-0005Xs-5L
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 10:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbXBNJJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 04:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbXBNJJd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 04:09:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:50726 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157AbXBNJJc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 04:09:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so115560uga
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 01:09:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kXU0CDLHg4/eVcrGYuStywgVZp6LP2CNwWVOf1Qk5+BAoaUu0bL5FBe98zZmavV2MyLuQphwTMo8RePoDaohLrTkpJ2+8xRrcTbTdyFNKvJWpVUwLyJFaNi5NhRia61MwtjRk7wx+YbXJ8bUuKG00cHnK0Bn2W3x/pNM9xmAeV0=
Received: by 10.67.96.14 with SMTP id y14mr140029ugl.1171444170694;
        Wed, 14 Feb 2007 01:09:30 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id q1sm565905uge.2007.02.14.01.09.28;
        Wed, 14 Feb 2007 01:09:28 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39625>

Hello

With the release of 1.5.0 I added legacyheaders=false and 
usedelatbaseoffset=true to my repositories.

While doing that though, it felt wrong to be editing every single config.  Is 
there a justification for having three config files?

 /etc/gitconfig
 $HOME/.gitconfig
 $GIT_DIR/config

With /etc/gitconfig coming in at lowest priority?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
