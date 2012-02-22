From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv4] git-p4: add initial support for RCS keywords
Date: Wed, 22 Feb 2012 07:53:27 -0500
Message-ID: <20120222125327.GA2292@padd.com>
References: <1329905741-2092-1-git-send-email-luke@diamand.org>
 <1329905741-2092-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Scouten <eric@scouten.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 13:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0BhQ-00022K-6y
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 13:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab2BVMxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 07:53:31 -0500
Received: from honk.padd.com ([74.3.171.149]:35912 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab2BVMxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 07:53:31 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 4B226E8D;
	Wed, 22 Feb 2012 04:53:30 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7EC7531481; Wed, 22 Feb 2012 07:53:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1329905741-2092-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191253>

luke@diamand.org wrote on Wed, 22 Feb 2012 10:15 +0000:
> RCS keywords cause problems for git-p4 as perforce always
> expands them (if +k is set) and so when applying the patch,
> git reports that the files have been modified by both sides,
> when in fact they haven't.
> 
> This change means that when git-p4 detects a problem applying
> a patch, it will check to see if keyword expansion could be
> the culprit. If it is, it strips the keywords in the p4
> repository so that they match what git is expecting. It then
> has another go at applying the patch.
> 
> This behaviour is enabled with a new git-p4 configuration
> option and is off by default.
> 
> Improved-by: Pete Wyckoff <pw@padd.com>
> Signed-off-by: Luke Diamand <luke@diamand.org>

Looks brilliant.  Ack.  Thanks for suffering through N rounds of
review.  :)

		-- Pete
