From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 19/25] gettextize: git-reset reset_type_names messages
Date: Wed, 15 Sep 2010 17:50:00 +0200
Message-ID: <201009151750.00882.trast@student.ethz.ch>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com> <1283456446-22577-20-git-send-email-avarab@gmail.com> <alpine.DEB.2.00.1009151216000.11791@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 17:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvuFQ-000867-Uk
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 17:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab0IOPuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 11:50:04 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:28077 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab0IOPuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 11:50:04 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 15 Sep
 2010 17:50:01 +0200
Received: from thomas.site (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Sep
 2010 17:50:01 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34.4-0.1-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.1009151216000.11791@ds9.cixit.se>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156239>

Peter Krefting wrote:
> This is untranslatable for several languages. For Swedish it would suffice 
> to move the " reset" part into the array:
> 
> > -	"mixed", "soft", "hard", "merge", "keep", NULL
> > +	N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("keep"), NULL
> > };
> 
> changing it to
> 
> N_("mixed reset"), N_("soft reset"), ...
> 
> and changing this
> 
> > -		die("Cannot do a %s reset in the middle of a merge.",
> > -		    reset_type_names[reset_type]);
> > +		die(_("Cannot do a %s reset in the middle of a merge."),
> > +		    _(reset_type_names[reset_type]));
> 
> into "... do a %s in ..", with similar changes for the others.

This would still break even in English(!) if we ever introduced an
arduous or extreme reset...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
