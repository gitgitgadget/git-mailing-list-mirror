From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Preserving ownership and set*id bits
Date: Thu, 18 Jan 2007 20:10:39 +0000
Message-ID: <200701182010.41183.andyparkins@gmail.com>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D49679@MBGMail01.mobot.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 18 21:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ddg-0001pJ-AU
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 21:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXARUNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 15:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbXARUNe
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 15:13:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:37665 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbXARUNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 15:13:33 -0500
Received: by ug-out-1314.google.com with SMTP id 44so273536uga
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 12:13:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TSPeyTexk/94D7aLO1Jkc0XHEecUzBFiwyZNz/toydffDe9MaeCKFYHTCiJU2Rq/gD7geMgoJYjqQV6387/ASL9dYt8jjFknnLUkz4iDMrIkHWXzIxqLiBiV7aZdIBUcZ2vxeDVAoVSNnS+6s9/9Ye4ZU1hvSxC9JIC08C8pvi4=
Received: by 10.66.243.4 with SMTP id q4mr1899417ugh.1169151211968;
        Thu, 18 Jan 2007 12:13:31 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id q40sm1546442ugc.2007.01.18.12.13.28;
        Thu, 18 Jan 2007 12:13:28 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <769697AE3E25EF4FBC0763CD91AB1B0201D49679@MBGMail01.mobot.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37137>

On Thursday 2007, January 18 17:09, Ron Parker wrote:

> Anyway, I'm not here to complain, but I am looking for suggestions of
> how I might store and preserve this information as well.

Storing it is fairly easy.  You can use getfacl in the pre-commit hook to 
record all the file information you want.

The hard part (at the moment) is that there is no post-checkout hook that you 
could use to restore those attributes.

If you were willing to manually run that restoration script after every 
checkout then there is your answer.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
