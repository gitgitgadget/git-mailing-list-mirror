From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Wed, 16 Jun 2010 09:34:52 +0800
Message-ID: <AANLkTinb7eRrRRYxxRd3BbNfBwRYAVFTNJ7z8oklNvIs@mail.gmail.com>
References: <4C0E5103.7030501@viscovery.net>
	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
	<4C0E6810.3070301@viscovery.net>
	<AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
	<4C0E932B.3010702@viscovery.net>
	<AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
	<4C0EB741.9020905@op5.se>
	<AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
	<20100610082916.GA5559@coredump.intra.peff.net>
	<AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com>
	<20100610085952.GA8269@coredump.intra.peff.net>
	<gJV0lM_e77LzoiHR7moWdAApSZ7yI38lZ-w8kZwc97unWqtBc94nfg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Tor Arntsen <tor@spacetec.no>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>, gary@thewrittenword.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 16 03:41:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOhdI-0002zi-FH
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 03:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab0FPBlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 21:41:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36223 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab0FPBla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 21:41:30 -0400
Received: by gwj15 with SMTP id 15so3726658gwj.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=M2RgEriafKQrANukeHXwSopfE3CyeMOtfgSLVtACMG4=;
        b=I39M5feUxG7hfcbBoW2lYXj0PPPmcipp+ywCEgY/KyEYKfqrVaW/Ts5U0x3mQjtb9e
         TI8DiLm3WdE0wVYWgEdUKIORB3GdCphQL9PdaR+bRn60sQRDLXuJVlWm3TatjjuWTXwy
         wfyg50KRp7w62AQb2s33MPgR5XjOBgNSRCtBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HlsF2jm4BHlyCpzYkflNtsnexfxLUINwkpTYL3vdRXekNcf6xZI0PD6AyZrLy3Kjxe
         EodTJa6UqUOwVnqq1monaU1Ha8ERzYKguLY7kQDEXL997buEpnR809UW3vNZuCIabI6L
         vflGw6TJhHeXVGRAPJHzwSuw+BV42Ol56SfIA=
Received: by 10.91.63.40 with SMTP id q40mr6304201agk.92.1276652092818; Tue, 
	15 Jun 2010 18:34:52 -0700 (PDT)
Received: by 10.90.29.10 with HTTP; Tue, 15 Jun 2010 18:34:52 -0700 (PDT)
In-Reply-To: <gJV0lM_e77LzoiHR7moWdAApSZ7yI38lZ-w8kZwc97unWqtBc94nfg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149244>

On Wed, Jun 16, 2010 at 12:11 AM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> But, I also think it would be nice if git fell back to the 'cat'
> behavior when it fails to spawn the pager, because the following error
> is not very informative:

Falling back to 'cat' is nice except when you are on a remote machine
with very bad latency.

nazri
