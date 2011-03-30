From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Portability: returning void
Date: Wed, 30 Mar 2011 13:54:40 -0500
Message-ID: <20110330185440.GC13440@elie>
References: <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie>
 <20110330033017.GA18157@sigill.intra.peff.net>
 <20110330035733.GA2793@elie>
 <20110330041339.GA26281@sigill.intra.peff.net>
 <20110330084148.GE2793@elie>
 <20110330124019.GA28062@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 20:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50Xc-0003Ri-Sy
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 20:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389Ab1C3Sys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 14:54:48 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54826 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812Ab1C3Syr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 14:54:47 -0400
Received: by qyg14 with SMTP id 14so1151210qyg.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rdbpn6amoD9EFmOKhcERyTFDy0JQUmAtuJxv3nRcG44=;
        b=al/uYzK7sLXIVehqUcQTnRIQQC9VtVVpVy9w0KbE+exTTxQ7Q29YTh6MetgvqJ5C2x
         s0fLFbYzmmMZwweXkRpnir9GDaFac0GnjL7Ys3BdLxASjzrpjCcXYBC2MXEPdC/ZXZ+g
         DzQP1G9IpsOGsf1wOTUwPQrfpFSAje4Ifu6wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SnQrMP0FvEb55OrNqhsYgY2TzLwY2d4vTwg3eUUfiR/tOGhLoQP21Xdh4A5DdIULr+
         L0DOOWrU9wTDG7O90gGLr7ABOOAlcWzMp1yEBa68fXKYqmotEFQbg0oeYcAOZV5C4gdX
         bEe7Ban8XVKtrmw8zlzj1ZIO6UGSdTRkalsP0=
Received: by 10.224.138.19 with SMTP id y19mr1516051qat.6.1301511286397;
        Wed, 30 Mar 2011 11:54:46 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id m7sm245876qcg.17.2011.03.30.11.54.43
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 11:54:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110330124019.GA28062@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170404>

Jeff King wrote:

> That's OK with me. Should it drop test-line-buffer, too?

For now, test-line-buffer is still being used to check the API wrt
early EOF.

In the long term, yes, I would like to replace those tests with tests
of svn-fe itself.  The test suite should not be an obstacle to
changing the line-buffer API as long as svn-fe is adjusted correctly
at the same time.

Thanks for looking it over.
