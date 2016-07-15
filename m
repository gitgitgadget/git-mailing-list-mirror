Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67CDA2018F
	for <e@80x24.org>; Fri, 15 Jul 2016 07:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbcGOHhW (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 03:37:22 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35975 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcGOHhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2016 03:37:21 -0400
Received: by mail-wm0-f47.google.com with SMTP id f126so14877704wma.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 00:37:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Zn/k9QSbyH5YrwN+LFhO0929s0xX8PNK7F4ij5aYYo4=;
        b=lQ9kuENn9XcoiVKFg/6fpaKwJUX3DNDUlUtYDgH11KuKl8umT1v31Jw+Bu28wQo27h
         Ii6DW/Ivj437IDpi3Ga0UmxsWNlIMEc5ULAJiO7+BmWe0jlPRxhDIlcJeDtrm10CuX5o
         18y9NubHcH15vS7qZNKl+Rp2qeC6CIxK9fI0IQspq+3oi0bswksOTOz3c+pprvNbFTsd
         mD1vK60wHmfrQcuO0XbLb2kw0I4TgujndUibxgkNk6kycxpNbnJ+7zU7e9HNxX3IoRCv
         880PJ19ubmwbePKsW+4aeg04r6pbVrw9vUNHM0T4T+banDTVosOuTAcmv39H4PrAh6EO
         fDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Zn/k9QSbyH5YrwN+LFhO0929s0xX8PNK7F4ij5aYYo4=;
        b=JO4lXxOyrVts9YUcQ3Lw6wiG0cJA1Rc2wqZXLEd+6lYvyifuszOgdPWRjtRVGMa3Do
         ESj0yP7lG7B/Zh8lMKVEHghzVJiB32xVcSjPJqYbrSRaQLGJ297ORDmAoQMXpHwwXvh0
         o66fhkFyenNG8yqCAzBrMpo1sfkCsRRpQg8Hy5IXx/sWEBh7qc0sSbqCjUbsFZl4yY74
         DXas/McbF791EftBoG7cGqeZsWOh3Jta2eZSf0On2qisVrQHohqIF7ycqiviztFk7OUB
         u7l1tNg5uI/+UN2rQ/UPeHaV0CZNTEIkLKdpOxc/a3Mc7dDdme6fHHvH5f5gBwy11g+p
         M8Vg==
X-Gm-Message-State: ALyK8tJtB5ahgROh4nLUR6VeYWL52mjxLASxYYw0sicnCYkQZwDSpGU9a5bhLgEYlZOv1Q==
X-Received: by 10.28.197.68 with SMTP id v65mr22776642wmf.2.1468568238696;
        Fri, 15 Jul 2016 00:37:18 -0700 (PDT)
Received: from shf5pggxy1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id f193sm4112275wme.11.2016.07.15.00.37.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jul 2016 00:37:18 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Plugin mechanism(s) for Git?
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
Date:	Fri, 15 Jul 2016 09:37:15 +0200
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Ben Peart <peartben@gmail.com>, Joey Hess <joey@kitenet.net>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2C31984D-310C-4E8C-927B-6D98B7D7570B@gmail.com>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
To:	Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 15 Jul 2016, at 08:46, Christian Couder <christian.couder@gmail.com> wrote:
> 
> [...]
> 
> The current topics/work I can think of are:
> 
> - the ref backend work by Michael based on Ronnie Sahlberg's and others' work,
> - the smudge/clean filters work by Joey and Lars,
> - the watchman/index helper work by David, Duy and Ben,
> - the external ODB work by Peff and myself.
> 
> They all have a need to talk to potentially different
> backends/external processes and this need is potentially not well
> satisfied by the usual mechanism that Git has traditionally used which
> is to have one or a few commands configured and to just launch the
> command(s) for each file or object, like what "git difftool" and "git
> mergetool" do.
> 
> [...]
> 
> If people think that evolution is better than intelligent design, and
> want each current topic/work to just implement what is best for it,
> then that's ok for me. If on the other hand standardizing on some ways
> to interact with external processes could be helpful to avoid
> duplicating mechanisms/code in slightly different and incompatible
> ways, then I would be happy to discuss it in a thread that is not
> specific to one of the current work.

Thanks for this great summary of the problem, Christian!

I think a generic plugin mechanism would be great but how would we do it?

We could dynamically load libraries but this would force us to freeze 
the ABI as mentioned by Duy:
http://article.gmane.org/gmane.comp.version-control.git/298463

Unix sockets are not really portable as mentioned by Dscho:
http://article.gmane.org/gmane.comp.version-control.git/298432

So far the pipe communication used by the clean/smudge filter seems
to be a good option. Maybe we could "standardize" some kind of protocol
over pipes?

I also like your ODB work and I think it is the right thing to do in
the long run. However, I only have a couple of hours a week to work 
on this and improving an existing solution seemed easier to me
(ODB would require bigger changes in Git and Git-LFS for instance).

Thanks,
Lars