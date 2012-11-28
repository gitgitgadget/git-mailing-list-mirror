From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 02:42:24 +0100
Message-ID: <CAMP44s1Kr0DGvqL5V3P-JD_aa5fbiyp2evCjBfZ7-X7nar_VnA@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
	<20121128011750.GA23498@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:42:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWfg-0004NP-Nj
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab2K1BmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:42:25 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34210 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab2K1BmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:42:24 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13076582oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jiHme82OpDoJ/L68grS5cpwZYRKoJWqltaPeJF4iqFE=;
        b=EbA0mGuFyPsYPnxcZ534CZr2U7XsCfwCfD7hLI0N/jKoqYKim5RKGMrfWLvDOB+EzB
         2QVKhpzsw5hQeczkenASIwobXQp+RfqCuq9Qd9LtdzBCH5ZDIzt5akDCVa+bWsU6mz63
         zPHDBYUdceNFGfNfHJSEOVfN7NwdfzavCmWqcmVdFDWdXbeTuRi8EeIhA6I/VJ49+o5N
         HFY9R2iYtKAJpfsrpVlFL961ylaJEsJJEx73CyCyL5GPD8PfRm4hGRaAKGwT9m7WBbUb
         V+Ee/pwdD9Ip23aGbovbJv2ct6xLdjPCBgKpbN1DMRiJPAj2wNYkYG+cFCMdDsMSpv0C
         0iMA==
Received: by 10.182.17.72 with SMTP id m8mr1501002obd.55.1354066944261; Tue,
 27 Nov 2012 17:42:24 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 17:42:24 -0800 (PST)
In-Reply-To: <20121128011750.GA23498@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210660>

On Wed, Nov 28, 2012 at 2:17 AM, Jeff King <peff@peff.net> wrote:

> But I really wonder if anybody actually cares about adding sub-second
> timestamp support, or if it is merely "because SVN has it".

I agree, I don't see any point.

-- 
Felipe Contreras
