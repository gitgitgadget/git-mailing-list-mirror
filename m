From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Removal of post-upload-hook
Date: Fri, 15 Jan 2010 13:52:12 +0200
Message-ID: <20100115115212.GA9221@Knoppix>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com>
 <20100114193607.GB25863@coredump.intra.peff.net>
 <20100114194107.GA20033@spearce.org>
 <20100114204305.GC26883@coredump.intra.peff.net>
 <6f8b45101001142212i4151c625k54b450cd5978f158@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Arun Raghavan <ford_prefect@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 12:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVkj3-0004uF-Kw
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 12:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932Ab0AOLwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 06:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756884Ab0AOLwU
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 06:52:20 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:44525 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0AOLwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 06:52:20 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id C84A1EF24C;
	Fri, 15 Jan 2010 13:52:18 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0674A915F5; Fri, 15 Jan 2010 13:52:18 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 0456B2BD54;
	Fri, 15 Jan 2010 13:52:13 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <6f8b45101001142212i4151c625k54b450cd5978f158@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137064>

On Fri, Jan 15, 2010 at 11:42:19AM +0530, Arun Raghavan wrote:
> 
> Another thought - would it be acceptable to have a config option to
> enable/disable these types of hooks, so that people who are not
> affected by the problem or explicitly don't care can use them? Perhaps
> a core.allowInsecureHooks ?

That enable/disable would have to ignore per-repo configuration, which
would make it behave differently from other options. Otherwise attacker
could just flip the setting...

-Ilari
