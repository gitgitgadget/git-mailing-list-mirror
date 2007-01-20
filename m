From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] New files in git weren't being downloaded during CVS update
Date: Sat, 20 Jan 2007 10:25:29 +0000
Message-ID: <200701201025.31251.andyparkins@gmail.com>
References: <200701191049.40833.andyparkins@gmail.com> <45B16E29.7000607@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 20 11:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8DSS-00051d-Qt
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 11:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbXATK2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 05:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbXATK2W
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 05:28:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:30954 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965234AbXATK2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 05:28:21 -0500
Received: by ug-out-1314.google.com with SMTP id 44so648296uga
        for <git@vger.kernel.org>; Sat, 20 Jan 2007 02:28:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hbEsYYpr2Kk/+c27matB3rYwxZ4TGgzOaY/HTRNbxmpWu5U19cetHuNwMm2Yz+Z3Hz6p8w3yJK8y+VpQDdKrH47G2hNeXaZzWVezvR7o/GBubQ5Qjcgb0LjedvTuKfCvoSKMATB01M9yY9eWxvZq9JoWtb1oWSU98fsIK6UgD5g=
Received: by 10.67.29.12 with SMTP id g12mr4449127ugj.1169288899944;
        Sat, 20 Jan 2007 02:28:19 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id o24sm3791802ugd.2007.01.20.02.28.19;
        Sat, 20 Jan 2007 02:28:19 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <45B16E29.7000607@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37266>

On Saturday 2007, January 20 01:19, Simon 'corecode' Schubert wrote:

> I think this is the wrong fix.  Reading cvs's classify.c, T_ADDED is
> only generated for *locally* added files, never for added files in
> the repo.  The correct status would be "U" as well.

I'm sure you're right; I don't know enough about CVS to comment.  The 
real fix would seem to be to completely remove the special case for 
added files and let it drop through to the normal update code. 

However, I'm not confident about that either.



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
