From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] rev-parse --namespace
Date: Sun, 17 Jan 2010 18:40:57 +0200
Message-ID: <20100117164057.GA20554@Knoppix>
References: <1263735931-20227-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100117162712.GB7153@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 17:41:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWYBp-0003S8-6E
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 17:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab0AQQlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 11:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934Ab0AQQlR
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 11:41:17 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:50854 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab0AQQlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 11:41:16 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 9918E18CFBE;
	Sun, 17 Jan 2010 18:41:14 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00AB12D361; Sun, 17 Jan 2010 18:41:14 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 35E754065;
	Sun, 17 Jan 2010 18:41:12 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100117162712.GB7153@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137305>

On Sun, Jan 17, 2010 at 11:27:12AM -0500, Jeff King wrote:
> On Sun, Jan 17, 2010 at 03:45:31PM +0200, Ilari Liusvaara wrote:
> 
> > Add --namespace=<namespace> option to rev-parse and everything that
> > accepts its options. This option matches all refs in some subnamespace
> > of refs hierarchy, and is useful for selecting everything reachable from
> > one or few, but not all remotes (--namespace=remotes/foo).
> 
> If I understand it correctly, isn't the same as
> 
>   git for-each-ref refs/remotes/foo

Nope. Compare:

'git log --branches --not --namespace=remotes/origin' 

with whatever you would have to currently type...

-Ilari
