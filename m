From: wfp5p@viridian.itc.Virginia.EDU (Bill Pemberton)
Subject: Re: [PATCH 5/6] Re: Remove mix of high and low-precedence booleans
Date: Wed, 29 Apr 2009 13:00:32 -0400 (EDT)
Message-ID: <20090429170032.59F0B57034@viridian.itc.Virginia.EDU>
References: <20090429165407.GB12908@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: nicolas.s.dev@gmail.com (Nicolas Sebrecht)
X-From: git-owner@vger.kernel.org Wed Apr 29 19:02:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzDAv-0000YN-Rs
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 19:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760581AbZD2RAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 13:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760570AbZD2RAe
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 13:00:34 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:40584 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760559AbZD2RAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 13:00:33 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id 59F0B57034; Wed, 29 Apr 2009 13:00:32 -0400 (EDT)
In-Reply-To: <20090429165407.GB12908@vidovic>
X-Mailer: ELM [version 2.5 PL8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117906>

> > Booleans such as &&, ||, ! have higher precedence than and, or, not.
> > They should not be mixed.
> 
> But round brackets have higher precedence than both '&&' and 'and',
> right?  If so, why thoses changes?
> 

While those particular statements may be correct, mixing the low
precedence logical operators with the high precedence ones is likely
to introduce bugs down the road.  See the book "Perl Best Practices"
for more information on this.

-- 
Bill
