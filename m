Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5647720193
	for <e@80x24.org>; Fri,  5 Aug 2016 21:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968674AbcHEVeo (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:34:44 -0400
Received: from mout.web.de ([217.72.192.78]:63051 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1950522AbcHEVel (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:34:41 -0400
Received: from macce.local ([217.89.153.218]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MC1jI-1bN1Ji3CKm-008vbz; Fri, 05 Aug 2016 23:34:26
 +0200
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-12-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
Date:	Fri, 5 Aug 2016 23:34:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160803164225.46355-12-larsxschneider@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JYefmS70MhXs0xtMCs+9BIgs4pTqs7gcT8uXOrE9p5/XTO5FjXs
 rGeL4v4E0jARuz9fuTsXhynfAMzC4fLToGZi5fUyE7byjSWP8SYdFc1hU9KbSKxgnr9x3Ze
 yWbOgLMGV+TRAoYeTDbuz65PhCtCbbzo3lRg0Q6ihZRJWeh5Aqgz2HgFefBAZMHPtqf+2m1
 xxxBm5BFxjUdJI6Lzjtww==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:myYmywJXCoc=:dGgQhGut1YJ/JDC6AIyYdB
 ZbJ7T2mmWla/rMwERiCVwSUlY0DrA9SKG8ojw0R5/ig2YekIRam2BSGgcOAPUrgJOk3aecTI3
 KLs6Xw/K/4lei/ZNkVdWIjx3tlXgR1ePTCV5rRO1guPQRIHJ2702XZqN78t+AzyhPV0GwCaDA
 TwJAqGZsRR7vY/o8G4fCKLrjWO64teb4JLzzoIn4EajeckojmBiBQnnyl+ENjkD8hXLNdnFbk
 YnagVDHyQa9Hd9nfJVLgO8QQTGLzVL5PbaQX4vl/PmDD4xxgzXCNuBsZVaIYF8+bqMHvxsjmz
 6SM50bEcRD6VYmsZG3Ts7HZSuc2bN7J7UuaJG4O0s/SRjE0SjPoZDMzia5CRenNz7EuHmF6fG
 H28wpzuSjTNVW0fUx5WjaWDqOHvq9CHCArR+TSIDKmjCMTS2cWThIXcfySXBJny1HB+1tmcwO
 qmAQ/9R7xI3uUfjQ+VmLdpW3wrUTxuRZNhYRlsmRacWG2SUjOD1Vh6sijGGvOnMmP4YbC5FNr
 CDE/4haMXljZmlhBfmeNLgMS/2B8ukLVoa78kMYoOmdOAXTaPyPu+6N0CwKkpYnTy149NO/04
 nHPVhj7tCkH+ITM0hcx9tL9PJmaPanIGc8uIXasdIu6knw7O9b8vdfbCBQHTx9vlc/7lmH2ZJ
 uON8SrlMYyolCBEfzerdLZISNB3Ib1A37Yqr8IugtrPt/d/QgcfT0qPB42C4LOHwE5wcuRwXU
 ZeQslH5WMokX2NbQ6H01YgHnhNSXJUUqjquX80oelXlwaW9prURO9hb5Qmndctuail0icE8ii
 8mmpFPd
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-03 18.42, larsxschneider@gmail.com wrote:
> The filter is expected to respond with the result content in zero
> or more pkt-line packets and a flush packet at the end. Finally, a
> "result=success" packet is expected if everything went well.
> ------------------------
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> packet:          git< result=success\n
> ------------------------
I would really send the diagnostics/return codes before the content.

> If the result content is empty then the filter is expected to respond
> only with a flush packet and a "result=success" packet.
> ------------------------
> packet:          git< 0000
> packet:          git< result=success\n
> ------------------------

Which may be:

packet:          git< result=success\n
packet:          git< SMUDGED_CONTENT
packet:          git< 0000

or for an empty file:

packet:          git< result=success\n
packet:          git< SMUDGED_CONTENT
packet:          git< 0000


or in case of an error:
packet:          git< result=reject\n
# And this will not send the "0000" packet

Does this makes sense ?

