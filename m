Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA32320FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 19:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbcF2ThV (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 15:37:21 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37099 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbcF2ThV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 15:37:21 -0400
Received: by mail-wm0-f52.google.com with SMTP id a66so88193397wme.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 12:37:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Xm3vL7EGxJhq8TfLG97yRlBT6ZxQDlt4LZN8i+XZJrY=;
        b=UmssYPTZd8VPH0NpUxI3wqEjNJktOMHUdMqcKoSLM5IVgv356IJMCfEiVCOdt3tMdl
         mb3qbAm415kaCAx8vD4pLVwNYdvLsR/EbNnrls6CUwD/OalBaVQXT2yna2xS1wFSBcBV
         2mDumKt8vt+pveeybh7m1fYqvXriPSD9cjYYcOFxSgFdmQiYNXYQeetBkjcVmsoNE9CV
         LrKhWpDTzDxdOLNi6TGnVi2a3Q9h1ZG/jSFklsPKVaUPMUH3Gugyn4CSiZiX+zaE7Yxt
         bAFgL4iNm3woOZZcS/yRj1mTn2C2Cc56YoRrvQSYqdYzxltdj4A8Zw2PJ1Ai9bCQHD1j
         FwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Xm3vL7EGxJhq8TfLG97yRlBT6ZxQDlt4LZN8i+XZJrY=;
        b=BfgIyr3uP+PunyL3xFaCR2swUTxstkOVz/AWEsChoj1T7+GoK/WHtU++J7PxvWqzCD
         ve86SZN3B6RAP4v4JGumaXOhQHzxDhfaAaooJFeOVvZNMdI8UEiuWaQnt/p0fuh7V6Yr
         wLmOR5g3Or7IIYqD3py2T9QNJ6bflA6VdNLrRLI9r6kqq9Qcf4exZLLPAaja3Plvm92l
         v9DiQYsbhTbJ/tbBLEcbZiRhVFkhg1l/Y+H4RjSLsXICuNkW3ONdZMEHo3vrtzlavSDI
         0ahtEuvqO561qPRs85x2kVXEq6bEWrcApP8F2QcGLvHR/RjI2MHeCXfMex5+Q958VjJX
         GKiw==
X-Gm-Message-State: ALyK8tJ9EFs+uU1Pk2ATLCSG0oIGnAH2roSBAUb0Q3nrtt9Wiz2s7d1HFIp8UsqoXD2jyQ==
X-Received: by 10.194.101.233 with SMTP id fj9mr9903021wjb.54.1467228549213;
        Wed, 29 Jun 2016 12:29:09 -0700 (PDT)
Received: from [192.168.1.34] (aefh205.neoplus.adsl.tpnet.pl. [79.186.137.205])
        by smtp.googlemail.com with ESMTPSA id p6sm757897wme.22.2016.06.29.12.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 12:29:08 -0700 (PDT)
Subject: Re: Fwd: what is a snapshot?
To:	Ovatta Bianca <ovattabianca@gmail.com>, git@vger.kernel.org
References: <CAHWPVgNrTEw9FmW6K7QucgA74QWsTKfxZGt+mGd099k+O7O+rw@mail.gmail.com>
 <CAHWPVgMWeHoD5vTiFJ1gsm2hS74LK7j4npVVbOZeR43cX3qWXw@mail.gmail.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57742174.9020309@gmail.com>
Date:	Wed, 29 Jun 2016 21:28:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAHWPVgMWeHoD5vTiFJ1gsm2hS74LK7j4npVVbOZeR43cX3qWXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-19 o 16:15, Ovatta Bianca pisze:

> I read in every comparison of git vs other version control systems,
> that git does not record differences but takes "snapshots"
> I was wondering what a "snapshot" is ? Does git store at every commit
> the entire files which have been modified even if only a few bytes
> were changed out of a large file?

There are two things: the conceptual level, and actual storage. On the
conceptual level, object representing revisions (commit) refer to
object representing top directory (tree) of a project, that is a snapshot
of a project state at given revision.

On the storage level, Git has two types of object storage. In "loose"
format (used for new objects), each object is stored as a separate
file. This is not as wasteful as you think: first, there is deduplication,
that is each version of a file is stored only once. Second, contents
(usually text) is stored compressed.

In "packed" format (nowadays Git automatically repacks from "loose"
to "packed" when it looks like it is needed) there is additional
libxdiff-like deltafication. In this format Git stores differences
(well, it also ensures that delta chain doesn't gets too long).

HTH
-- 
Jakub Narębski

