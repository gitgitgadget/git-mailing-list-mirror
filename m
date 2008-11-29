From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 2/3] git add --intent-to-add: fix removal of cached emptiness
Date: Sat, 29 Nov 2008 16:38:12 +0100
Message-ID: <bd6139dc0811290738qbd93ff6oa7aa854708009075@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
	 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
	 <20081128192033.GF23984@spearce.org>
	 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
	 <7vk5an4cba.fsf_-_@gitster.siamese.dyndns.org>
	 <7vvdu72nq9.fsf@gitster.siamese.dyndns.org>
	 <7vprkf2nki.fsf_-_@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 16:39:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Rv6-0003Xq-DY
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 16:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYK2PiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 10:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYK2PiS
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 10:38:18 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:65386 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYK2PiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 10:38:13 -0500
Received: by yx-out-2324.google.com with SMTP id 8so703551yxm.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 07:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eTweI9trtXSseCpLHG/JehGyNVHyP9IA6IyGN7xGEB8=;
        b=T4/XU5GzEZIbE9ROet+SWVdzgdl+mVVL/3DwId0xSiredln57kN80dwd/xE/WllDpF
         Ogw3EmwKMw8K21/+fqfdOdtPRhgJfRhBw6MiYMEWrrkNejUfs1gi2+3KmqJJ88p2/4T1
         m3A+DE1yuXg+E0J517+qHHeDDI6jLDrSiW/u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=tSVm0+y2rQ4UgjnpjWyo4u3vO7EKIqYQK/F+iN9nNp7bBSB1ZS15l7eCxZ/AycvM2Y
         bTRZh9XQKY8z4438+XA3+flm8Iu0Ujnc4cyqoJj+3jxSOwBynAuRrsSsUngrEtuKE4Cw
         THWBcM1L24OEHNikLa/7KRJSxoEmYJ8Pbt51g=
Received: by 10.151.42.6 with SMTP id u6mr17840974ybj.153.1227973092599;
        Sat, 29 Nov 2008 07:38:12 -0800 (PST)
Received: by 10.151.108.18 with HTTP; Sat, 29 Nov 2008 07:38:12 -0800 (PST)
In-Reply-To: <7vprkf2nki.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101914>

On Sat, Nov 29, 2008 at 04:55, Junio C Hamano <gitster@pobox.com> wrote:
> This uses the extended index flag mechanism introduced earlier to mark
> the entries added to the index via "git add -N" with CE_INTENT_TO_ADD.

Is 'intent' [0] used properly here? Should it not be 'intend' [1]?

[0] http://en.wiktionary.org/wiki/intent
[1] http://en.wiktionary.org/wiki/intend

-- 
Cheers,

Sverre Rabbelier
