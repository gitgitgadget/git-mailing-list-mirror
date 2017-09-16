Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290F020286
	for <e@80x24.org>; Sat, 16 Sep 2017 15:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdIPP1v (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 11:27:51 -0400
Received: from mout.web.de ([217.72.192.78]:60137 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbdIPP1u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 11:27:50 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Laky4-1d9Dwk0Vg0-00kLvN; Sat, 16
 Sep 2017 17:27:26 +0200
Subject: Re: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-11-benpeart@microsoft.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <ce17a042-91e4-bf84-d9e6-36a9e99f3644@web.de>
Date:   Sat, 16 Sep 2017 17:27:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170915192043.4516-11-benpeart@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+r7DPYuad6+ofeDNP+0LdXLZ8dnGwEvX/3IgTv8ohhj909Z+5Gs
 mARAfo/4Q4xCEc3FyDrURuxULubsPq94GBBZG0sgZm6cJR7UI3ZTmtUCwxNRKtr+1XCPqfD
 Yyfbtq4ZItw5cR0O4856i0IRi7txs4xutbQyqBq6CBjVA6073SzKiAAqnOXdh7z6dj5m1rJ
 Q5fkgNPYJqvn8FlqMDOzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PHZLE+Nkq5A=:qTSM5X/9BM6YV7FjkjsLwC
 EMljB6Ue9mcElbEuRpnzgoSV4l3oDAs8bdOBt4CB+se/Vf9Osf2STlAKW/+LpUxRJMF+zRZCa
 kNSWmjv+Q2b/JpvNDa7ZixAzJ2rnlagn3UbMz1Yd6TA1Ez4fKAUcPhmoKGJCS3UMcDZHFUYJB
 8tNJqQF55xHSKtdmKXER3J3+qx4eID5gijNkSe4vM6N+qaMMuzcHGHW/lxS3DY8dipGTdSjWp
 SHF7IMnBYDYbNBPwtEuR7yksdwMR6Q+saFfrx+D/IgAa/F8iz1K7QdGRI7fgHa7tfiUrVdVJj
 /t2xxB7wjhJSZSR9VDKqU9KPAuoZ4aUxCoXYy7wPE6M8a3nXAUOF7Yo3HjuNtEjdnwap9+SBg
 gpoCsEGsPm7G5ETZX4BTzBLVUZDNi8hA4dH/mnjtaJwAsQq/ga6bo7nMD6SBy5SdrkrH00DKe
 HQok+Pbsg3oJh5U/qs+7+Npo04pMkqZQ68j5U3VqPkW/uTMxoDeUDmVhRhHP+eWQuwHU14Ld+
 WJaWoZu7IO6I/CNWWp3oHF4Os0W/IRzVnN56Mwj6vBO5DcKXsaHJ5yyMQaPAJS4ZU8DQdK5SM
 C8vkpHabCXjgd1nJf/43+19wfHAdHZ3ycrAe1TjxP3bH03DUMZ/XGP/ne2X1oIpVoZS2h7Rje
 9u35Hefl2waqYd816LTqcRdvu6HsktMyoVOKXuKCGs6JjS+Ninni+wJFLQx9qw5qvZyuQnqYK
 6AVN4qGQGHvUEeSbCyiIjsItYYsj49Sr1+VhSK7kaUKDZ7JbJhnFCThkTzI2ekv/oyW31/DN3
 vlL6+vsC+ke9Xakv73WGzPt9AbrnMHmAKajsVUSmXJqlbiOJNY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-09-15 21:20, Ben Peart wrote:
> +if [ "$1" != 1 ]
> +then
> +	echo -e "Unsupported core.fsmonitor hook version.\n" >&2
> +	exit 1
> +fi

The echo -e not portable
(It was detected by a tighter version of the lint script,
 which I have here, but not yet send to the list :-(

This will do:
echo  "Unsupported core.fsmonitor hook version." >&2
