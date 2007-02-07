From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: describe fails on tagless branch
Date: Wed, 7 Feb 2007 09:22:54 +0000
Message-ID: <200702070922.57163.andyparkins@gmail.com>
References: <eqb660$ft7$1@sea.gmane.org> <45C92918.8010801@xs4all.nl> <7vr6t2g1dt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, hanwen@xs4all.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 10:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEj1E-00074i-P7
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 10:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbXBGJXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 04:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbXBGJXJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 04:23:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:59719 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161054AbXBGJXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 04:23:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so130029uga
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 01:23:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ke5jdE5lE6EozouANqQXRz7rG7Pn1wJohQZwkZyvYorXNYJDubINCiFArJWPhxut8whu/ZEShaSBD/14le7wWwmHKhXSPVCjsAqJ3kSERJ1znzmsn+yGKRWTbK39o0BUi2bLB68ZZKsc1Rds30LpeuPuDMqYRd4eiitw33bgLiI=
Received: by 10.82.114.3 with SMTP id m3mr355607buc.1170840182167;
        Wed, 07 Feb 2007 01:23:02 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id b35sm843257ugd.2007.02.07.01.22.59;
        Wed, 07 Feb 2007 01:22:59 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vr6t2g1dt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38899>

On Wednesday 2007 February 07 02:14, Junio C Hamano wrote:

> I do not think it a good idea to make "git-describe" itself do
> the above, as the user of describe may want to fall back on
> something other than "rev-parse --verify" after ||.

Agreed - the "nearest tag" mode (--abbrev=0) would be broken in that it 
git-describe would return a tag that doesn't exist.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
