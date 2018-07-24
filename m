Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3D91F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGXT06 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:26:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42912 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbeGXT06 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:26:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so3450668pgp.9
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bwAtMv73hTm+XIC0S4Eiocb6CN4fA/Fb5JTSAEcDEP4=;
        b=d77m1QMo3ecxruYxTpE2T1jlEr2B4kuzEf21ioSqrhCUY6WMwNMY2aeJrtsD0kfnZO
         J8R+QDdLElLxjeFnqbaDMv2jdCwO5d80iRmNXX5kGinO77MPAQ7pE71JaVEtWgfjpHwe
         fPsw0MFrRGPcBdbwnj1eZUnVzJnHZ9UNErqnCM8gsZjKmEZKoULwy0IjDp1eQLhQR+cM
         Cxt4ZLDUNMfXcCFgzTQwJ4PYwk7VZDy6Y1J3A6+35ahdMezuXIXxqTbXTsQA4xHAwPH/
         my811SvmxxMvmvJ0JPtW0b9gfji32Zdrq2Pmjy55gnQQbb217fEBkSg/upFDrlBFtcgD
         5npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwAtMv73hTm+XIC0S4Eiocb6CN4fA/Fb5JTSAEcDEP4=;
        b=kjkn71kUCWcmDS+Xbt0NvSinzEtCKDbmvoEcnh2FD0LJGqpXhq6D3UgzaX42slOW2F
         dpgKWRI9vZuxzNoim3Ks38UqHmPu9b363I/jIcCIQMhGii03Q0iM/9GkV81DAwTilO8Q
         XY/FS0z+kWx+n+3NDlXYMIZjD2mRsA5X+JlZ/kRr8PT3sypmKZJNXYR1noD2Ryu1a9/p
         HEcDjglsKsRM1i0tjIuuoMwh0f8NWrmBasJMHfaopQB8YjdSBHysNTVlHfbgWcPNqT5y
         wPe2TUh5DJ38pR2a9+tz2rY6p8QpxAolxX2UH3zlML9+1QNcNi4RSiqxn1OKj0cw8qZD
         jUvw==
X-Gm-Message-State: AOUpUlFQctM5viX9sD+7FH5FxCjezgYhrFdbmT1dd7a4aqRVgyj6jWNV
        GV8XXQmRlC8y+Plbz/u3mRVAHQ==
X-Google-Smtp-Source: AAOMgpeZQdp26G483hwqNsiPe7a3O/RcuTeeZxI013LgT8C1Tcaxfkta0rMcGVeZwFHFQA7Nhmr+Fg==
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr17277504pgg.163.1532456355237;
        Tue, 24 Jul 2018 11:19:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f184-v6sm16755485pfc.88.2018.07.24.11.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:19:13 -0700 (PDT)
Date:   Tue, 24 Jul 2018 11:19:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol: mention and point to docs for protocol v2
Message-ID: <20180724181913.GA225275@google.com>
References: <20180723174807.28903-1-bmwill@google.com>
 <20180724045233.GB208393@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724045233.GB208393@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/23, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > --- a/Documentation/technical/pack-protocol.txt
> > +++ b/Documentation/technical/pack-protocol.txt
> > @@ -50,7 +50,8 @@ Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
> >  
> >  Servers that receive any such Extra Parameters MUST ignore all
> >  unrecognized keys. Currently, the only Extra Parameter recognized is
> > -"version=1".
> > +"version" with a vlue of '1' or '2'.  See protocol-v2.txt for more
> 
> value?

yep, missed a letter.

> 
> > +information on protocol version 2.
> 
> Thanks.  Some thoughts on other parts of this document that may need
> updating:
> 
> - the whole document assumes that 0 and 1 are the only protocol
>   versions.  E.g. the discussion of the version number line in the
>   response when "version=1" is sent as an Extra Paramter should probably
>   apply to version 2, too.
> 
> - because the document was written before protocol v2, it describes the
>   more complicated v1 that many readers shouldn't have to care about
> 
> - there is no one document that describes v2 in a self contained way,
>   since protocol-v2.txt makes reference to protocol v1.
> 
> - the description of pkt-line format in protocol-common.txt is missing
>   a discussion of delim-pkt.
> 
> Not about this patch, but I wonder if an organization along the
> following lines would make sense?
> 
>  1. Rename pack-protocol.txt to protocol-v1.txt.  Rename
>     protocol-v2.txt to pack-protocol.txt.
> 
>  2. Make pack-protocol.txt self-contained, and remove any redundant
>     sections from protocol-v1.txt.
> 
>  3. Add a new protocol-v2.txt that briefly describes the benefits and
>     highlights of protocol v2, referring to pack-protocol.txt for
>     details.
> 
> That way, newcomers of the future could read pack-protocol.txt and
> quickly glean the main protocol in (then) current use.
> 
> What do you think?

I dislike the idea of renaming protocol-v2.txt to pack-protocol.txt.  I
agree that we should probably have protocol-v1 broken out into its own
file, taking the parts from pack-protocol.txt, but what really should
happen is that pack-protocol.txt could describe the basics of the wire
protocol (pkt-lines, the format of the various transports, etc) and then
refer to the protocol-v{1,2}.txt documents themselves.

-- 
Brandon Williams
