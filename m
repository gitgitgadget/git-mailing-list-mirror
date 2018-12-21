Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46C41F405
	for <e@80x24.org>; Fri, 21 Dec 2018 12:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbeLUMEe (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 07:04:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:44557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbeLUMEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 07:04:34 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7YF5-1hMCrs34K7-00xNKU; Fri, 21
 Dec 2018 13:04:27 +0100
Date:   Fri, 21 Dec 2018 13:04:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2] git: add -P as a short option for --no-pager
In-Reply-To: <23493ba1-1704-1e8c-f448-95540a36f886@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1812211303270.41@tvgsbejvaqbjf.bet>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org> <23493ba1-1704-1e8c-f448-95540a36f886@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b7mu3xDYA9vePade4S9k7RU/RLtUIY8NOWEtvFkgN+rmzuFhdu6
 a0U7VzodT6sccvcarqpHXsWuogD6XCXZBkGD0Ce8nYmEPFPJqGP+PxAVkqD0GTPGfoehPE2
 GqEz/oDmW5CHT+o9zoFaUeTCNlGidGR0wMXRnPs6OIqTbqTMMef0EBdASqBmMzfl8IHFseW
 XrdTiCb4MKw0591Tj0skQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AdERBKS+7W8=:sPbRuk7h9hD1lLpyTC3yBJ
 qYsXGXUNEVYPNv2HP1GEcS2gS3GLrJmVL452cludrfFdu9z7PdT/tOyq79HB5GxSzJ1qOVc15
 WAkRdY8DSgiqybdAJUFn7ka8OgNRNp3lmCaW4q+tQm0AZ4Y7yCpOdWzjGynYyJze/l5ICTV4m
 0MypT8M66v3vxTQxo9PkBMZBMsWso2vV/9fV+u+CEflnxzH4107p/JqFkA91civcLPBQm9f1+
 uFYY3ZhFjj9Zv4ZbhSd5EtrIpvDyK/U/yKIIAD4sd8nNNbgvLzV6XxtOUiFwn5CFRa3S3OdJh
 ZliufKrLvdYz7G+yyav+hHjQKkhTWntk8TQPB5Jw75JOxX9WsZnjfeiCJkjEIZDiV+pWavidm
 sZa/ri0EpceCRW4tflH0PN/34uuHQwou47tedIGDfHEK/y1MOVTpcgyD6dLtVvuR5bMquPSnK
 IioQxFrF+bWpItyWlDkYHGoYl4K11xhejQMQN5JEfqyU5ZAUfxs8HnnhFeRmMlV2pRmN25KKP
 KHwVsROeZVqiRzXBnQMbycbnLryQ+VlLUXaFWRKiEdfwilfYDC8FJWbd/YkWXt9TANFTqSj80
 8TDTWRm6Bh0XZ5bqDUooPQG0WmMhKp1maOPGXELBfqitscrCJeMe0O8WF2jD2GcJ8D8Wt2yba
 L7bXNkBfoj5FBOy7xIQvGRxirur4kvBmmM8M9fkZJi8obLEBTO94UWDL/KyeLqxdatY8Aepxn
 7J7/mW4Mgqq5HQKxEP7At6eoP18mQpRevACYBXPI+0hdqcRPT+2Qc7q7qQ+X8Z2wFes2mjcLo
 5SGawSzeBBTnfzU/IHMjEf0vYKkX8Evy/xzwnQzeQfzdnjaPmWvwqU+XxRapo2pcUn9wQUtU4
 3kueYgCeZx4iaSossLYeJd5KFwkd187EzCqxA3WNL11tDlvDZZs4ldy9YoaN1YlE5QpUYJADt
 7lJi148p8vw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 3 May 2018, Johannes Sixt wrote:

> It is possible to configure 'less', the pager, to use an alternate
> screen to show the content, for example, by setting LESS=RS in the
> environment. When it is closed in this configuration, it switches
> back to the original screen, and all content is gone.
> 
> It is not uncommon to request that the output remains visible in
> the terminal. For this, the option --no-pager can be used. But
> it is a bit cumbersome to type, even when command completion is
> available. Provide a short option, -P, to make the option easier
> accessible.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Given the positive feedback, I resurrect the patch.
> 
>  Changes since v1:
>  - Use -P instead of -N
>  - Commit message changed as proposed by Kaartic

Just a quick note, as mine was a vocal voice against this patch: I find
myself using this more and more. So I was wrong to object, and I
apologize.

Thank you,
Dscho
