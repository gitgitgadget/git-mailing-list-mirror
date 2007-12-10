From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] Add support for URLs to git-apply
Date: Mon, 10 Dec 2007 07:46:59 +0100
Organization: glandium.org
Message-ID: <20071210064659.GA4148@glandium.org>
References: <1197194672-28568-1-git-send-email-mh@glandium.org> <1197194672-28568-2-git-send-email-mh@glandium.org> <475C5869.4080900@op5.se> <7vhciro4vx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:47:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1cQQ-0004kT-LG
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 07:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbXLJGrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 01:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbXLJGrG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 01:47:06 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:60590 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbXLJGrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 01:47:05 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1906.orange.fr (SMTP Server) with ESMTP id B17451C0009D
	for <git@vger.kernel.org>; Mon, 10 Dec 2007 07:47:00 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf1906.orange.fr (SMTP Server) with ESMTP id 8D0FE1C0008A;
	Mon, 10 Dec 2007 07:47:00 +0100 (CET)
X-ME-UUID: 20071210064700577.8D0FE1C0008A@mwinf1906.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1cPr-00017b-4v; Mon, 10 Dec 2007 07:46:59 +0100
Content-Disposition: inline
In-Reply-To: <7vhciro4vx.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67685>

On Sun, Dec 09, 2007 at 02:54:58PM -0800, Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> > Mike Hommey wrote:
> >> Instead of doing several "wget -O - url | git-apply -" in a raw, you now
> >> can just git-apply url1 url2 ...
> >>
> >
> > I seriously like this idea. Combined with gitweb (or cgit), it could be
> > used as a cherry-pick from someone else's repo :)
> 
> FWIW, my initial impression is that I seriously dislike this.  It may be
> good if the patch were to git-am, but when git-apply rejects an
> inapplicable patch, there won't be nothing left for you to recover with
> and you need to re-download the patch anyway.

There are some usecase differences between git-apply and git-am.
Probably, this change would be good to have on both.

Mike
