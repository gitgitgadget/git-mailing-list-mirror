From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 09:04:29 +0000
Message-ID: <200701100904.32077.andyparkins@gmail.com>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <7vy7obj07k.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 10 10:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4ZNx-00047W-Ls
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 10:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbXAJJEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 04:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbXAJJEi
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 04:04:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:27098 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932746AbXAJJEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 04:04:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so43773uga
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 01:04:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZDn9VqX7g2O9T4wIiPJ4NXVGRQ0EO4FR7F5Lh6VpgeAQwdUiVFrh7WcZ151xz/EbaFVLkxTew7dB4xKtFGH3jXCV0rhrFP5VnX/tFdtHakOFF3Qfv0jy/9KDQJv6YO5+vSF24U+wsi3t1sPhGx7WPBZjDxbjzbUrt8tHOLZYeA8=
Received: by 10.67.22.14 with SMTP id z14mr155867ugi.1168419875796;
        Wed, 10 Jan 2007 01:04:35 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id 28sm35007677ugc.2007.01.10.01.04.34;
        Wed, 10 Jan 2007 01:04:34 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36490>

On Tuesday 2007 January 09 23:46, Linus Torvalds wrote:

> I would suggest a solution:
>
>  - git checkout will refuse to switch AWAY from a detached head unless the
>    SHA1 of the detached head exactly matches some other branch.

If the detached HEAD matches another branch what did we need a detached HEAD 
for in the first place?

Seems that this check will in practice always be true.  A detached HEAD by 
definition doesn't match some other branch.

Have I misunderstood?  Perhaps you meant the detached HEAD is /on/ some other 
branch?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
