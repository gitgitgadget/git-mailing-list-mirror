From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 0/2] bookmarks
Date: Thu, 26 Apr 2007 09:33:36 +0100
Message-ID: <200704260933.38677.andyparkins@gmail.com>
References: <200704252004.45112.andyparkins@gmail.com> <Pine.LNX.4.64.0704260816480.27356@beast.quantumfyre.co.uk> <200704260923.26637.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 10:34:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgzQx-0003iy-0P
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933605AbXDZIeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 04:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933609AbXDZIeb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 04:34:31 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:13134 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933605AbXDZIea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 04:34:30 -0400
Received: by ik-out-1112.google.com with SMTP id c30so515359ika
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 01:34:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Mn99JVqYf3+T/u33YUlWzzAhuDZn2AT9vDL1PsUvZ13K0+96SbKl+wGrTKNdmt406xXL/iK2sCtXe+I7iLuqIorkIDs0HTVtwR80sllNDpap6+otCxZnocAmfkJ7pyB+sSgJIdtDms+wBWSD9QS7FK190PJm6lLdQna2nQD/BMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Cl4j6yc/sbh95yvzmsG7ei8a9dd8oghAi3oeIsC89EcGsh/Go9a04R1Xs7HZSBnunE/OrRnGRtd/XLJdOaDC/aouRL0LN61q5V5gR+jjKFHORcNQEpdRK9CxH8fZYrgi6Ku4aVjAvFgOXUkIGLUeTFgFTazOgJwjfj6EKbGG/9o=
Received: by 10.82.187.16 with SMTP id k16mr2792676buf.1177576466993;
        Thu, 26 Apr 2007 01:34:26 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm2941ika.2007.04.26.01.33.57;
        Thu, 26 Apr 2007 01:34:19 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200704260923.26637.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45621>

On Thursday 2007 April 26, Andy Parkins wrote:

> Actually how about this: an option in the remote section to turn off
> auto-following and then add fetch and push lines for the tags too - that
> means very minimal changes and then everyone's happy (where everyone =
> me ;-)).

Funny.  I went looking to add the above facility, and lo-and-behold, it's 
already there in the form of the remote.$remote.tagopt parameter.

[remote "origin"]
   tagopt = --no-tags
   push = refs/tags/public:refs/tags/*
   fetch = refs/tags/*:refs/tags/public/*

This does exactly what I want.  Once again, git is waaaay ahead of me :-)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
