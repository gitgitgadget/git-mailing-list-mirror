From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 7/9] builtin-checkout-index.c: use parse_options()
Date: Thu, 24 Jul 2008 22:08:37 +0200
Message-ID: <200807242208.37192.barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-8-git-send-email-barra_cuda@katamail.com> <alpine.DEB.1.00.0807241543190.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM71s-0002Cc-41
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYGXUCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYGXUCM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:02:12 -0400
Received: from smtp.katamail.com ([62.149.157.154]:46087 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751624AbYGXUCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:02:11 -0400
Received: (qmail 2056 invoked by uid 89); 24 Jul 2008 20:02:03 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host59-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.59)
  by smtp1-pc with SMTP; 24 Jul 2008 20:02:02 -0000
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807241543190.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89953>

On Thursday 24 July 2008, Johannes Schindelin wrote:
> On Wed, 23 Jul 2008, Michele Ballabio wrote:
> 
> > +		{ OPTION_CALLBACK, 'f', "force", &state, NULL,
> > +		  "force overwrite of existing files",
> > +		  PARSE_OPT_NOARG, parse_state_force_cb, 0 },
> 
> I wonder if this could not be written as
> 
> 		OPT_BOOLEAN('f', "force", &state.force,
> 			"force overwrite of existing files"), 

I did it that way because 'force' is a bitfield.
