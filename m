From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: What's not in 'master', and likely not to be in, until 1.5.4
Date: Mon, 21 Jan 2008 09:11:06 +0100
Message-ID: <e5bfff550801210011i149c6e70t661024a3ed68b8f9@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <47891658.3090604@gmail.com>
	 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	 <47893E1A.5020702@gmail.com>
	 <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	 <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	 <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 09:11:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGrks-0004cu-Ov
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 09:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821AbYAUILL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 03:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757828AbYAUILK
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 03:11:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:9532 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806AbYAUILH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 03:11:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1706420rvb.1
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OPqH6c2CmX/A2fAJRIlWBGaRdzYV1ywLFEXwbI09K5Y=;
        b=kW1ydZNelzDC0IALcAlcM/Go/ELrBwwvW2R+z9ivPxohs0XDXgpx6U551nuKTOfT5+ph9FVpipYBTrOa/6OCLYH1n2b7qKFrHKg3AqpnsYXmEm85hhzp2O6a7veOgSZr/pt/OejG3m5cKe7oj87IbBasIsbMToMyoNDZzmWtiWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OmtjZXVEnfIvoBjEeSMByJWqrJGL08TPwnhdZN+MGx9ut8pdp9YgDLgvg6Te9HU807IDT14MNS7YWeMUf+7/ikA5hahqT7un6iQQcxEwVwnViWie7DQDuaf+vTDWMyE2/6+aRLE3Gnkgz/QF4w3GgGzdhFLWHbME27lV+1gTc48=
Received: by 10.140.54.6 with SMTP id c6mr4262101rva.37.1200903066946;
        Mon, 21 Jan 2008 00:11:06 -0800 (PST)
Received: by 10.141.68.21 with HTTP; Mon, 21 Jan 2008 00:11:06 -0800 (PST)
In-Reply-To: <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71239>

On Jan 21, 2008 3:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I suspect it might be a good idea to make an early declaration
> that 1.5.5 is to resolve the above listed issues plus the ones
> already in 'pu' (and nothing else), and have a fairly short
> cycle after 1.5.4.
>

I have another patch, already sent to the list but lost somewhere
about pretty=format optimization that I'm planning to resend after a
cleanup when 1.5.4 is out.
Patch improves git log speed when --pretty=format is used.

Marco
