Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C4E1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfHTRth (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 13:49:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55783 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfHTRtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 13:49:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id f72so3367111wmf.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A6IMiModHxmhmZYsXwdjTiend2w6mu0+tkKPoyjy34A=;
        b=q5CTmuiaJNh2Rb001tjHaqNXywD1dgBMK3cougjjpQPcUhqPA23ReW49wsU6bXtked
         A4CRLgIO4GISk+BwgFVfqtxXpnm6tY1VfTVfpnWJ/SavS8SVpgfJSghj5tEXiGzfLdJm
         VAvcCGtsn59D2jeOftNSQEO14lsti1ytHpgPLUGnMaKAoGZ5jPg3MqGMRCOLBl4Onbfl
         V5/tk4jOTSNMgQh2EX1RZiqWn/zD9Iu6i2KEU4KFgX0cnToaIGRc4FFlsyd+wyqYEPYn
         A4KZLo4lx0HK0CD14ByK5R06kewTFcHOYR46QgxsBy7owrQXyNXqm1wdr7vQfd4MeVaJ
         eGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A6IMiModHxmhmZYsXwdjTiend2w6mu0+tkKPoyjy34A=;
        b=Bx1JQYaOHRYXPBKAMO2Xk1guTMG541c3WRcJjrC2JikABp/CzCpK6t6uYtzA66Z/g9
         m1CKpvDTaqQcYaiVc7XB+/bsePyZ0osRNId95p8/okGjk/G1J/lVtqstTIsVdfK5nSWA
         mgiOQApdrExmfGpKPaFP62i4eDOF1TExLd7+j8FPIzO3G4QSzwhfoFHNbiGFG4vv3CU2
         B5AL9kQxgSLSh1hor7kvHrYXS8E8r7hzpoM+DBxh9LMOdXbMjPNxQgyutZ36V7OhDWsw
         jxmh4/QZ58CHMVHFVZ1E3B8+a0rQLc5GYbCU/3zZlPnqe2S+iisZ2TLcwkyCI4o2Km9u
         3ZJw==
X-Gm-Message-State: APjAAAWul1Hp1M3l9FOV2JMjLC3ssy5+f7DdrOLXx7/CvK5yCLqLtvP/
        cYJobduACIsS1PKzc8VsoltOOREq
X-Google-Smtp-Source: APXvYqzkO7tv5qosNBezzwOzMrHWC+sMZ9DwhvHnQYD5QERbKghbSpAH12/yg4NpD+Y5rEj7Oj85dg==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr1252451wmk.128.1566323374560;
        Tue, 20 Aug 2019 10:49:34 -0700 (PDT)
Received: from rigel (167.207.63.94.rev.vodafone.pt. [94.63.207.167])
        by smtp.gmail.com with ESMTPSA id 4sm35285419wro.78.2019.08.20.10.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:49:33 -0700 (PDT)
Date:   Tue, 20 Aug 2019 18:49:29 +0100
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [problem with name-rev] (was: git log --graph with a sort of
 local revision number)
Message-ID: <20190820174929.GA6753@rigel>
References: <87blwq7rn5.fsf@mat.ucm.es>
 <20190818190032.GA11185@rigel>
 <87pnkzkivn.fsf_-_@mat.ucm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnkzkivn.fsf_-_@mat.ucm.es>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 04:32:12PM +0200, Uwe Brauer wrote:
> 
> It seems that there is problem with name-rev.
> 

In git, branches are just pointers to a commits. Commits do not store
any information about branches. They're similar to mercurial bookmarks.

Thus, git is not able to answer "Was commit X was made in branch Y?".

What that command does is describe each entry in the log in function of
your active branch. Keep in mind that these descriptions are relative,
and they'll change as you make more commits.

It is basically asking git the following:

    "Is commit X (each log entry) an ancestor of the commit pointed by
    branch Y? (HEAD, meaning your active branch) If yes, describe the
    relationship between them"

Considering your example,

*   changeset: ae68dbe:master
    |\  user:      Uwe Brauer
    | | date:      Tue Aug 20 16:25:53 2019 +0200
    | | summary:   1.2.1/1.1
    | |
    | * changeset: c00bb5d:master^2
    | | user:      Uwe Brauer
    | | date:      Tue Aug 20 16:25:53 2019 +0200
    | | summary:   1.2.1
    | |
    | * changeset: 54c9230:master^2~1
    | |

54c9230 is the parent (~1) of master's second parent (master^2).

If you make an additional commit on master, the same 54c9230 will be
described as master~1^2~1

Check the documentation to learn the syntax: git help revisions

If want a permanent reference for a commit, you'll need to:
    1) Use an unambiguous prefix of the commit ID.
    2) Make a tag to the commit you want to reference.

Cheers,
Rafael Ascensão
