Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667F81F858
	for <e@80x24.org>; Sun, 31 Jul 2016 20:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbcGaUmA (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 16:42:00 -0400
Received: from mout.web.de ([212.227.17.12]:51494 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbcGaUl7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 16:41:59 -0400
Received: from [192.168.2.11] ([156.34.81.190]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lpw6t-1ap91h1Xnz-00fkCO; Sun, 31 Jul 2016 22:41:40
 +0200
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
From:	=?utf-8?Q?Torstem_B=C3=B6gershausen?= <tboegi@web.de>
Mime-Version: 1.0 (1.0)
Date:	Sun, 31 Jul 2016 17:36:22 -0300
Message-Id: <63231F5B-959F-4A9D-89B9-E4A42AF34AB1@web.de>
Subject: Re: [PATCH v3 03/10] pkt-line: add packet_flush_gentle()
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-4-larsxschneider@gmail.com>
In-Reply-To: <20160729233801.82844-4-larsxschneider@gmail.com>
To:	"larsxschneider@gmail.com" <larsxschneider@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"jnareb@gmail.com" <jnareb@gmail.com>,
	"mlbright@gmail.com" <mlbright@gmail.com>,
	"e@80x24.org" <e@80x24.org>, "peff@peff.net" <peff@peff.net>
X-Mailer: iPad Mail (12F69)
X-Provags-ID: V03:K0:VfWbEECsvfn+BnP5wa5aLBMhOZ3N7XVTOLiSPkO7B54rlxhcaWA
 vl28nl6LU+0otL2rjFHErxD5Z92ytFvO8Jyl0EKGn9btoP/xeTkFapwn6HKefFWY9fQPj0J
 dZ3V05wZmlsjnEkr/k1UYcX2KR3X37COtcKO0hv4W0mD/GzdIZYTi83+xHnQe+LCQT1XTZV
 MyZSgLFeFDBdUSF6Vy7Pg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:yXhq2uEoeLk=:LHMd+QEiGk38Yff3EZNrwc
 n2b3oiuAOhmWhBiJXFsr3gVLxuhAMR3zehpYjzR3A1Nz1sGLCy3QRd4yi6UzZUYV1TAngfNy/
 bXZpdEkeq6NZsaK/oociho+II/oYwNSRlv6uzgzBRPrZBdZRHFp1sdlawduD/BfFLOpH6UPpn
 yXjbTQbBmz/Ah/4wram8/0tzwlwcxtCmfemlQBCDq6T6J5V66DaPbJA0OuTtcXPZTvYQH1qtZ
 9IC5B4oUjyl0o2N26SZAEuZqCM3ONJx7nWdTbTGCo1PIvAaPwy8oqamQOd4j0kZ+c3ScPfLHY
 5WXm+AB7wvOX/36n8DA8QhrHWCQ16MgWFuoTSGQs078fOR8asNdH/fveMgMlKjOXVoWeKP5Gl
 PyoLblS6+NJh18r0ngVG2yzkvArVwqhZkPPyXW9yF2bdvZqHDlkVYePV4JevrJXU/G8ZKQomz
 GSO34zQzTed5eZU9i2IWb6uFvyTfTtzJH524vm/km/YfwaPD5lr3mU5Kx+JaZ/PwRFeIN5DXe
 thmCsjG+bxR8H/Fq4vpyH5YNHsFey2z60L8ylSbhCrLehbXP4msPRSLPUGq9sqYBYoudTcIDI
 JaNOqpDEtiRB0yjKoBOCosNdVrFP1HwLic0LY5gXy9xDVxSnHnhR2GEhFbX8aibMf32Z8GR7i
 iHvWq6kNtMpGJGlMD+mqZzF/mcUhf0TRZK1ewXKAjWIGHMWYP7taEoujsPIPXu2rBOSOulP2e
 T30mLQGM7GMr1FSWWMnl5Q//sQY2hBtTtY2Ys6lVbcH3aX21mXzKzIChWLRNpLpDFAwl4E/kd
 yQUdCEO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



> Am 29.07.2016 um 20:37 schrieb larsxschneider@gmail.com:
> 
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> packet_flush() would die in case of a write error even though for some callers
> an error would be acceptable.
What happens if there is a write error ?
Basically the protocol is out of synch.
Lenght information is mixed up with payload, or the other way
around.
It may be, that the consequences of a write error are acceptable,
because a filter is allowed to fail.
What is not acceptable is a "broken" protocol.
The consequence schould be to close the fd and tear down all
resources. connected to it.
In our case to terminate the external filter daemon in some way,
and to never use this instance again.


> Add packet_flush_gentle() which writes a pkt-line
> flush packet and returns `0` for success and `1` for failure.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> pkt-line.c | 6 ++++++
> pkt-line.h | 1 +
> 2 files changed, 7 insertions(+)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index 6fae508..1728690 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -91,6 +91,12 @@ void packet_flush(int fd)
>  write_or_die(fd, "0000", 4);
> }
> 
> +int packet_flush_gentle(int fd)
> +{
> +    packet_trace("0000", 4, 1);
> +    return !write_or_whine_pipe(fd, "0000", 4, "flush packet");
> +}
> +
> void packet_buf_flush(struct strbuf *buf)
> {
>  packet_trace("0000", 4, 1);
> diff --git a/pkt-line.h b/pkt-line.h
> index 02dcced..3953c98 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -23,6 +23,7 @@ void packet_flush(int fd);
> void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> void packet_buf_flush(struct strbuf *buf);
> void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +int packet_flush_gentle(int fd);
> int direct_packet_write(int fd, char *buf, size_t size, int gentle);
> int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle);
> 
> -- 
> 2.9.0
> 
