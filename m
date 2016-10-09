Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B986C1F4F8
	for <e@80x24.org>; Sun,  9 Oct 2016 05:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbcJIFdP (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 01:33:15 -0400
Received: from mout.web.de ([217.72.192.78]:64160 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbcJIFdO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 01:33:14 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LilJB-1bIP0B2rFd-00d0GM; Sun, 09 Oct 2016 07:32:50
 +0200
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20161008112530.15506-1-larsxschneider@gmail.com>
 <20161008112530.15506-14-larsxschneider@gmail.com>
 <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <a80f6399-b344-b979-d849-1dc7f899fabe@web.de>
Date:   Sun, 9 Oct 2016 07:32:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:an4gOK5Gijjs2iva+uRwrcLnYflRMwuPaPQ1J8ulV6+qUAz4gWy
 GGcmX9FbqT3U2UkdmI+UNxH9M5DtSvYv5eKlt+HRAC+u8tJtR9vDi/h65gOcAY2V+HJucME
 Xf3qgRlKrr/svrO+ez4nI7rOd6HgAuyRleuiJocscKVmIgIbHbFQT6ZOogUbNpA0Q3g+5op
 CcPOVpoqdolZPKQOo1fgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NlRor8cj4ts=:YpdIXysdBLUpssdK2fBuOx
 Hcaid/EjrOo4xknRIR+nEPIaFhD8AS71cuiNFsQpglv2byhYD7mQV9vCq0L6pC10iC0AAKDl2
 2K+c/IwXfH6TANLcY2DRKKeQA9GG+IT5aLHpuGejgRB5+sSRacp5EerjdbaqMW/il66vE9Ijv
 xORp8h8sL88+gEzKbzJVloPfv4suGrKZhocCeGpLob4xQC2srF+SiIaIdLCXE6Rw+pTgUOgbb
 hkH1eC9ly2NBVDNXYNNEhJjUlO+pVPfJCJczcKepJkkjQDYiDC0iMp3hDKTYxDUW3JEnScFiz
 cEfgKOOxh8K6zSllnIOLjXDW6jpRdDALD/MmWhIqhvRRPnZ40OGOI4+ipYX7trlLZdTjubNBK
 uWDzjBMYLHok59pkt/QVOVLhlqm+1nyEKVbgrWF01se5bCpxbCZaAA+kiw8wjPSBHZzEW3PuG
 ceS1SpZqzwmovcFwMpGTXrBp3jD042vW+74BsXVnDG59+As3rHmNIXbpIDpKdQ72yCkgUHRgp
 1SFax3KzxMlu49KTOXtoqg8Xx6ftKPV9P1ZRIJwnh9hMbbRBP4iDu+DJTCuCu1eZ2bu8DdN55
 5g38Q3Nnjiz4seitKQWYQjGQASVbq3Q0H03YhdeX7U4PdYB8IhS09ijTW1XnbjhOdLyf/Dzp6
 mwNpsaq20b1QfFT+V2PmbKP1Wd0PIyvHVZmxhEtw+H0PPXyJY6C9Cc/oIcQBW+fsDDg3fHZ26
 Z6+hZOF3l7HwU+5fP9XkCyLfDKOEKJDHJvBFfTLLpHhifFp3HTOkINh7QSwFYf8xxRKaTbd5o
 09W1LSG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.10.16 01:06, Jakub Narębski wrote:
>> +------------------------
>> > +packet:          git< status=abort
>> > +packet:          git< 0000
>> > +------------------------
>> > +
>> > +After the filter has processed a blob it is expected to wait for
>> > +the next "key=value" list containing a command. Git will close
>> > +the command pipe on exit. The filter is expected to detect EOF
>> > +and exit gracefully on its own.
> Any "kill filter" solutions should probably be put here.  I guess
> that filter exiting means EOF on its standard output when read
> by Git command, isn't it?
>
Isn't it that Git closes the command pipe, then filter sees EOF on it's stdin

and does a graceful exit.



