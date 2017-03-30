Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B3520966
	for <e@80x24.org>; Thu, 30 Mar 2017 13:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933752AbdC3Nsc (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 09:48:32 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57206 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdC3Nsc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 09:48:32 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MXR93-1cf87X3Gon-00WEe6; Thu, 30 Mar 2017 15:48:14 +0200
Subject: Re: [PATCH v2 0/3] name-rev sanity
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
 <cover.1490798142.git.git@grubix.eu>
 <xmqq4lycatsu.fsf@gitster.mtv.corp.google.com>
 <xmqqvaqs9dws.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <12937baf-f36d-836c-612d-72578a5929b4@grubix.eu>
Date:   Thu, 30 Mar 2017 15:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqvaqs9dws.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:isPEI26J4zL8spV53LwuRI3JhXIQW34uDmJ7imwzoF6nbF7A1VV
 xstzAU3jFbjkQ0LSy9aT/COQZOwM0kXO43wpzbOYpbgqWbBPxom0hcvIOLCJqF+qb0jt8ip
 xoyhR7De277kZsz9BNCF+q/73I92ovFwShXz2/iFy0hoReUuZAP17LdSre2JwsH/9tszciE
 x/VLUVyVGfmWES6KBOh2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5a8xS1i78FI=:I6oYtugZ2AoeuwULP9cxj+
 Dj6nDkDjEwy0rdGW3ALXUJadQv3rI9PFgilnbegSPvidJhnWcg5ALeBrCiXPKhRfx9zyKkL2R
 2YhiXrRrJWuobi3l2Z2k0YG4FQ4nLAMLNE9884BiAkdiiHZAm08ESqqj3JzCmAFh9Qts12xoc
 wCyNYVl/5pnAfQcpmI78m970ZoVmKq+Y67EGEzuzhi44czMk1jQfGYKLLLxzi1vdi8+QRN2vj
 jVHMe4jvn3zDbHnzY/iaSPkMDxo8tWpVqvknscSBckim0XZYErfvdCHyH2G6jI+Cag/LNMZ3m
 ZkSmTNvkiUOlLt0JLI59txa8P5yghwrVk0Z2Z8oFVgH1KDoXf4dtGD+nMmnKzkVre0CVyLlV9
 w/Sv2cv285Zg3mCFOXHOz6F0OvBDMGAo+Xg9OOD12mwIRrNc8rVvODST5alaY3CT/CMglVc+W
 bexoSoyeSDBhDA1N37JkBCj2JqD5otZKvHHVQLCIgP/gb5qo8HhTYEJwbWvtVurjpPnQ/EVQu
 Ye1JxKd8R+2QuSuVkXWVuLsQv3rj8aB7WgGd5U+9InM0NezlVqz3hhpFsuuMX9QzPSkHZLgXf
 sTp6KqTC6VP+FJlNwzgwvIWywvFRVZtRxgJCQJ2IIsLkRDwhz+tW/xeoRf+tHsWHUGl8CAa3Z
 gTJbaAizTwJX7+7IuGzWSCjUI8WbJB61IlbKiTAt1xQd5/9zn1VmNUbCQ1WM5JtxRgzNJd95B
 OQhEFPlU0MOfn+qc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 29.03.2017 19:43:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> The first two applies cleanly to the same base as jc/name-rev that
>> the first two of these patches are meant to replace, but the third
>> one doesn't apply on top.  Are you depending on something newer?
> 
> Ah, of course, you are depending on your other topic ;-)
> I'll wiggle these in.
> 
> Thanks.
> 

Yes, sorry, isn't that in next already? I should have meantioned it anyways.

Also, I should split patch 3 into name-rev and describe related parts
and update the name-rev documentation. We don't have tests for describe
--debug, that should be ok.

Mihael
