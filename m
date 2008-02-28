From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Thu, 28 Feb 2008 01:32:41 +0100
Message-ID: <8aa486160802271632k5c7f14e0q132bd12f53838ed1@mail.gmail.com>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
	 <7v63waqasu.fsf@gitster.siamese.dyndns.org>
	 <8aa486160802271504r7744422ag290b1f4d1725210f@mail.gmail.com>
	 <8aa486160802271516h7c2c636dna3a9f067fc51da2@mail.gmail.com>
	 <7vpruindag.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0802280024460.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Mark Levedahl" <mdl123@verizon.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWiA-00049b-He
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204AbYB1Acp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 19:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757948AbYB1Acp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:32:45 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:57667 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758191AbYB1Acp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 19:32:45 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2475964tif.23
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 16:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZaaSLjiOkVHGMiJ9jKTrKxoRiabejc0K0dpv/Ck0LgM=;
        b=PQwKEpDklELpi+RC2wXrKLDw7wsspQTMxorNW44+12XLdbbn7UDzKYhVFchY/sh06d/zjgy5319WROcN46rcZ7T3JEsISgCLoCJhufdwkn7bYdEwqiyEE2lMUglNuLRXGyxJaGcYoplB51iBMjFrW4tVNGCYiMggrdSu12HsXFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hMvE2FOcMFzbyHSTC7iGpzH+DXQDXgYXQAlCCdmbQmqhLFqCTdFuBJvwCB02ACG0pDSxOU2XCek7AoSuQMXM/IZT+GUbObtvM4eJEIwGjA2YBAulW0jAREFry7CLe18wIWzhFmvPLT8YzRnFoyCb9YFRgtvZRwxxRBERFVc1N2w=
Received: by 10.151.112.3 with SMTP id p3mr2568819ybm.192.1204158761852;
        Wed, 27 Feb 2008 16:32:41 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Wed, 27 Feb 2008 16:32:41 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802280024460.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75332>

On Thu, Feb 28, 2008 at 1:26 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  On Wed, 27 Feb 2008, Junio C Hamano wrote:
>
[...]

>  > calling it .bundle or .bndl would be sane.
>  >
>  > Opinions?
>
>  I like .bundle, obviously (I used it in every single example I gave).

+1

Santi
