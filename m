Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5867020136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934763AbdBQSXa (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:23:30 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33568 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbdBQSX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:23:28 -0500
Received: by mail-lf0-f68.google.com with SMTP id x1so4430048lff.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJayP/FgI0bGUqg0x+aeEA0Sb+Z6yODHi1GyzwaK8/o=;
        b=eweN68thYORQ2F38ro/o9ouGyNo2EamHQMblWeWuCDbu2otMXTJDJIRs8+Svxu/RIT
         gfZ3E5x1TT03ZDtGmpHkQ5LS/yPIO+etfphqKzvf1HEs6tSwcWiQIyPXhQZx6VkAT7Tq
         RUOZZf00DGkVBrKUwOPlP2ewNpBSnl+1IfS1F8T991rRoYVpr5bAsb/yj0sspidEmSd7
         2Cz5cAg//ZaNxpcJrI6E5DASAZb9b5DMRsRdO/Hf696lW8FVYyAi8dSUbkMJzvXuPNzL
         zx53eDeYGXYmaC7tZu9JZsWpk9dxGlH055vboGBe1JINKDVSiBsfQMmWaX+0f8V5ndBA
         4zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJayP/FgI0bGUqg0x+aeEA0Sb+Z6yODHi1GyzwaK8/o=;
        b=ZBU9mRFYQh4e3nUPakBnGpqmaQJ68zNEAylVNqqmYGHgooZJBXSO8oxFebNj7u3JS8
         dcc7CKizy8vQVjVxCO202+hvUKn54avAon1FIR/QP1W74H0Mwz4R+xpZJoUnslwhUfQ5
         lm1FbV2gkUpAX/597JOBUTR0RBMgtj/jgVJYcO58otcj87ZQH8fiHvLv6McLSzbw6dfD
         2/obVeD2jiQzjdqxwoaP0NDQq2m4huKpW4FM6qDIWETz9b6WF6LR03iu1LVbk7GLOn9e
         PP5iFUDjBlwVipJoVWpCHYYJdbyPX1XrsRBu88rzzPp0CWuUP+Rtw+WLcKCvNbwq/LdR
         lNkw==
X-Gm-Message-State: AMke39lSwqmgG817C5j0DcJRvi9EUo6/CfiaHNHRDPca/Srm5K9Km4zlg3J3iBmmX5PVzg==
X-Received: by 10.25.15.68 with SMTP id e65mr2826652lfi.117.1487355806656;
        Fri, 17 Feb 2017 10:23:26 -0800 (PST)
Received: from xi.terra ([84.216.234.102])
        by smtp.gmail.com with ESMTPSA id a138sm2706346lfb.2.2017.02.17.10.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 10:23:26 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.88)
        (envelope-from <johan@kernel.org>)
        id 1cenBm-00008y-KE; Fri, 17 Feb 2017 19:23:26 +0100
Date:   Fri, 17 Feb 2017 19:23:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Johan Hovold <johan@kernel.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
Message-ID: <20170217182326.GA479@localhost>
References: <20170216174924.GB2625@localhost>
 <vpqlgt6hug6.fsf@anie.imag.fr>
 <20170217110642.GD2625@localhost>
 <vpq7f4pdkjp.fsf@anie.imag.fr>
 <20170217164241.GE2625@localhost>
 <vpq4lzs7o0s.fsf@anie.imag.fr>
 <xmqqd1egu1dl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1egu1dl.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 10:18:46AM -0800, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> >> On Fri, Feb 17, 2017 at 02:16:42PM +0100, Matthieu Moy wrote:
> > ...
> > If I had a time machine, I'd probably go back then and forbid multiple
> > addresses there, but ...
> >
> >> There does not seem to be single commit in the kernel where multiple
> >> address are specified in a CC tag since after git-send-email started
> >> allowing it, but there are ten commits before (to my surprise), and that
> >> should be contrasted with at least 4178 commits with trailing comments
> >> including a # sign.
> >
> > Hey, there's a life outside the kernel ;-).
> > ...
> >>> 1) Stop calling Mail::Address even if available.[...]
> >>
> >> Right, that sounds like the right thing to do regardless.
> >>
> >>> 2) Modify our in-house parser to discard garbage after the >. [...]
> >>
> >> Sounds perfectly fine to me, and seems to work too after quick test.
> >
> > OK, sounds like the way to go.
> >
> > Do you want to work on a patch? If not, I should be able to do that
> > myself. The code changes are straightforward, but we probably want a
> > proper test for that.
> 
> The true headers and the things at the bottom seem to be handled in
> a separate loop in send-email, so treating Cc: found in the former
> and in the latter differently should be doable.  I think it is OK to
> explicitly treat the latter as "these are not e-mail addresses, but
> just a single e-mail address possibly with non-address cruft",
> without losing the ability to have more than one addresses on a
> single CC: e-mail header.

That's precisely what the patch I posted earlier in the thread did.

Thanks,
Johan
