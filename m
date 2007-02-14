From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: How to get rid of tracking branch?
Date: Wed, 14 Feb 2007 13:35:37 +0000
Message-ID: <200702141335.41165.andyparkins@gmail.com>
References: <45D30D8F.50261DB0@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 14:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHKIc-0003mA-5z
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 14:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbXBNNfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 08:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbXBNNfv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 08:35:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:59324 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272AbXBNNfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 08:35:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so188961uga
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 05:35:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ELwhwcefl8WHDAu9qR/yF3nd9USPydpl9ycqFr3aVPAOa05bjHULPuZuIjnQwTZrFkYGDnHdwRUCO52iJwPlVVGWoKjIinO6vtQyJtXYI1W+G5wJs0KtT80lNevuKPHrvW+bWxOK30ycS2Jv6fdCQs2hxuhg1jExWE6RksgYyP0=
Received: by 10.67.121.15 with SMTP id y15mr368798ugm.1171460148537;
        Wed, 14 Feb 2007 05:35:48 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id a1sm925148ugf.2007.02.14.05.35.45;
        Wed, 14 Feb 2007 05:35:46 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <45D30D8F.50261DB0@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39642>

On Wednesday 2007 February 14 13:24, Johannes Sixt wrote:
> Call me clueless, but how the heck do I get rid of a tracking remote
> branch? I've cloned a repo locally, but in the clone I don't want to
> track all the topic branches of the origin. But git branch -d keeps
> saying it doesn't find the remote branch:

 $ git branch -r -d origin/repo-devel

I suffered the same thing a while ago :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
