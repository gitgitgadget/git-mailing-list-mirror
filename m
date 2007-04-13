From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/3] Add basic infrastructure to assign attributes to paths
Date: Fri, 13 Apr 2007 10:33:12 +0100
Message-ID: <200704131033.15751.andyparkins@gmail.com>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 11:33:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcI9n-0001sA-9s
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 11:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbXDMJdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 05:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbXDMJdX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 05:33:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:30767 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbXDMJdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 05:33:22 -0400
Received: by ug-out-1314.google.com with SMTP id 44so508556uga
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 02:33:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TBAO3LdQ3WDW0hkR5yEWPVZu+7wL+0QN/OELfROjIhqb7SbFuJAJTPDDynXf2av+1IzklGMrRAGA7y0gpyL/R0B2oJ5YgEVUAo2Uj2lDkfPR36xuoimb9bntGLrrSCG2HQq86dgAIJGBLbjVLTKPMzVSX7SszGWnZIvzH2IlZDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IwUY1oeJTpIF3T0x6j3G+EwzW0ToZuN23dNgMKbv4cEdsniaqduCsMV6t84nNPAHNmXaih8TXkYb1dvt68PxN+G20Eqb3377HhGDJFHVJU9CAWPPsWFms7LBB3RYwMwXJbsxEC7OFupw0uMOU/XDZPb8V+rWdJR1bcwq6s5/B+M=
Received: by 10.67.74.7 with SMTP id b7mr1880976ugl.1176456800458;
        Fri, 13 Apr 2007 02:33:20 -0700 (PDT)
Received: from ?192.168.11.214? ( [84.201.153.164])
        by mx.google.com with ESMTP id 27sm827272ugp.2007.04.13.02.33.18;
        Fri, 13 Apr 2007 02:33:19 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44400>

On Friday 2007, April 13, Junio C Hamano wrote:

> parent directories.  Lines in $GIT_DIR/info/attributes file are
> used as the lowest precedence default rules.

Shouldn't this be the highest precedence?  This would be important for 
those cases where I (as a fringe developer) disagree with an attribute 
that's been assigned in-tree.  I don't want to force my will on every 
other developer, but would want my repository to work how I like it.  

For example: what if I /can/ read postscript :-)

Incidentally - already I love gitattributes - nicely done Junio.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
