Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118001FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 17:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbcK2Rlg (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 12:41:36 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33873 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbcK2Rlf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 12:41:35 -0500
Received: by mail-qt0-f180.google.com with SMTP id n6so162864625qtd.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yQIzQNI9Xud3zDJJ8NhtAfazEtnpNE1imGf5kuRrVgA=;
        b=bv14YrCs/HeesoDPl5WKWKgo/XBAr8U05snSd8OlcXVlCv9VuxpbKlyyZloQsbyahY
         fC3Q5HjIacOZtDlG7tyo6ZijXRKEx81vT0hzgJAF7OPhV+6hFFv79V84W46+TrDCLYtD
         YNC9dsddsELIIV2FIowSKvwMOunn5q3nbCrpYgk6oGylzUB3aNk2vXKLvgeQs4CQckPT
         XpxtfE9l5+5HWqFn5tsPKXKsVzY3Gvp1m1BhkM0TJTDU+BuxOUgC4jON1AKvkbWJRb/m
         SQHyJbMhn7TVkJCzfL3W1aYRIxy4for3NlzVDibPQRHKxH+mAX92LUPZlHfGi3OpdEze
         Lp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yQIzQNI9Xud3zDJJ8NhtAfazEtnpNE1imGf5kuRrVgA=;
        b=DDujrTKCql/BGzzO5YD4E2JyP7AGl1A4PuFM7G1elBqHNA6SQ1GMDmfqKdcrZdorUY
         8poZS0BOa45DUGlzQhqaqYhUjBrflHZXx1F00IM7xxT9ufxd21cY2H4/VW+SvLdKjqCd
         vDipqLXe29nmyHOGn0/kaDUIc0LXBsA+/BN/SAgEaDMwP8xL2k2Dt8PXmq6P80A1ZKki
         AZ4/x4iGOKib6sIRRQaLUli9wmUA4qGpaMbC1Sl2VQIgurE3TxlgrVTrf6dFugFFr5lj
         0ePgvHTNPTI12ehwh4cm4sG2zN0Fj+LGBxFPuRF75741LNg2IW4AGA2p00NKBHbX0YEf
         glmA==
X-Gm-Message-State: AKaTC00Ag4YaGqjg+K5+tKrQZ+5IoDkyb9fqipXmCadzmVGA3Av5VXniR0Pi/vjHqi4F+q+D9DgB0gsRMgpHr11K
X-Received: by 10.200.58.65 with SMTP id w59mr24452032qte.54.1480441294149;
 Tue, 29 Nov 2016 09:41:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 29 Nov 2016 09:41:33 -0800 (PST)
In-Reply-To: <CAKXGFGMGqnGJSEBx8=FXfG3pGEcpFGjLNUH23VTo4LEo75kTKg@mail.gmail.com>
References: <CAKXGFGMGqnGJSEBx8=FXfG3pGEcpFGjLNUH23VTo4LEo75kTKg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 Nov 2016 09:41:33 -0800
Message-ID: <CAGZ79kZHJgnNbvehQqOKRunpFcuZ-ua2KFOjX10xHY5NPR-jsQ@mail.gmail.com>
Subject: Re: gitk crashes on RHEL
To:     Alessandro Renieri <a.renieri@gmail.com>,
        Paul Mackerras <paulus@samba.org>, eric.frederich@gmail.com,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        rappazzo@gmail.com
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 1:51 AM, Alessandro Renieri <a.renieri@gmail.com> wrote:
> On Redhat Enterprise gitk returns the following error when launched:
>
> Error in startup script: unknown color name "lime"
>     (processing "-fill" option)
>     invoked from within
> "$progresscanv create rect -1 0 0 $h -fill lime"
>     (procedure "makewindow" line 201)
>     invoked from within
> "makewindow"
>     (file "/..../bin/git-exe/bin/gitk" line 12434)
>
> The fix is to change lime with {lime green}
>
> Regards

+cc Paul Mackeras, and people involved in the last bug report

See discussion at
https://public-inbox.org/git/CAAoZyYNnWk-yE9TG_Fpxxs-oRN-yEsm_YFs+Ej7muQ+5YCW43w@mail.gmail.com/#t
