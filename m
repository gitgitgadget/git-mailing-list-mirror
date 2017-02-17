Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFC420136
	for <e@80x24.org>; Fri, 17 Feb 2017 17:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbdBQRaI (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 12:30:08 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33933 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934360AbdBQRaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 12:30:07 -0500
Received: by mail-lf0-f67.google.com with SMTP id q89so4325594lfi.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cLoEu11mmUSk/kgdDnB8w0bi8/Qho3gRxnXzBmEVx04=;
        b=QyZkfAdOenghEDsURoC0e5LuoK0GkH44rDFUdRY0eNv+MvwxsIfJm7kiE3ev9+gIpf
         avtU22uaG1a8KLcRciTTCO9FTp+SBWbSCHOM266AgYnEU3AwPIA1yaCeY/7Y2U5p+MSy
         N/PIgx1zStsgKIFTGE0i4twXCzjo2Aj4XhxBG9BwDbHa3SCVbCmUnT4QJxfsXHzhbki2
         eyDDEROqGnUoEVm3ETJAbx1OTeHMRQxd2C1LsbzXmu4SYYbX0DnkAUw1WsDVMWxC053D
         xWW3SAG77RTJ9SV37ilSrtdKKMjBvhfvZ4WTnkAuS1rH95sYLPQAHqVT1mPbM8Ardd0t
         tPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cLoEu11mmUSk/kgdDnB8w0bi8/Qho3gRxnXzBmEVx04=;
        b=DBoG+TuJxJGFH2gGbup3XtqQ9rQYK9Kc6KL14vAcEMpIUpZ8g65Vgj7yoCWzfxSuvt
         TcJ0EXgFW9VLZgXQ71oUktgPD81055bGKk1+3RFt3naQMgnNXsbtMQJfPzQtClVoWBgG
         GsKDgmJcJJIDO+bJPkWqBYVigi/5FCICKmPB4YDFuWwbi4Euqn3uLJkYjZIG7Z4KtDgV
         LCBEM4aDGmFlcNSoOyIemJhZOEEHtBwsHtUClArOTQVoMYYK8Hys1oa/KtUpL8GmWYF5
         j9EtgLnxY9g3Vu5ykqcbHi3DHim15oF4l6wF2RBINzmiQb7vLfFjR7DHAg4MdSj6mHoQ
         ZbNQ==
X-Gm-Message-State: AMke39m47I1Z0DbFjjB8piKEvoMYOENp8KmNWk3pVtkklyYogGip/k+kvwvz6Qyzt7za8A==
X-Received: by 10.46.21.93 with SMTP id 29mr2396144ljv.11.1487352605173;
        Fri, 17 Feb 2017 09:30:05 -0800 (PST)
Received: from xi.terra ([84.216.234.102])
        by smtp.gmail.com with ESMTPSA id a71sm2667147lfe.36.2017.02.17.09.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 09:30:04 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.88)
        (envelope-from <johan@kernel.org>)
        id 1cemM8-0008Ta-5S; Fri, 17 Feb 2017 18:30:04 +0100
Date:   Fri, 17 Feb 2017 18:30:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Johan Hovold <johan@kernel.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
Message-ID: <20170217173004.GF2625@localhost>
References: <20170216174924.GB2625@localhost>
 <vpqlgt6hug6.fsf@anie.imag.fr>
 <20170217110642.GD2625@localhost>
 <vpq7f4pdkjp.fsf@anie.imag.fr>
 <20170217164241.GE2625@localhost>
 <vpq4lzs7o0s.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vpq4lzs7o0s.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 05:58:11PM +0100, Matthieu Moy wrote:
> > On Fri, Feb 17, 2017 at 02:16:42PM +0100, Matthieu Moy wrote:
> >> Johan Hovold <johan@kernel.org> writes:
> >
> >> The "multiple emails per Cc: field" has been there for a while already
> >> (b1c8a11c8024 released in 2.6.0, sept 2015), some users may have got
> >> used to it. What you are proposing breaks their flow.
> >
> > Note that that commit never mentions multiple addresses in either
> > headers or body-tags -- it's all about being able to specify multiple
> > entries on the command line.
> 
> Indeed. I'm not the author of the patch, but I was supervising the
> students who wrote it and "multiple addresses in Cc:" was not the goal,
> but a (IMHO positive) side effect we discovered after the fact.

Yeah, and the broken --suppress-cc=self I mention below is indicative
of that too.

> If I had a time machine, I'd probably go back then and forbid multiple
> addresses there, but ...
> 
> > There does not seem to be single commit in the kernel where multiple
> > address are specified in a CC tag since after git-send-email started
> > allowing it, but there are ten commits before (to my surprise), and that
> > should be contrasted with at least 4178 commits with trailing comments
> > including a # sign.
> 
> Hey, there's a life outside the kernel ;-).

Sure, but it's the origin of git as well as the tags we're discussing (I
believe).

My point of bringing it up was that the multiple addresses in a CC-tag
was indeed an unintended (and undocumented) side-effect and I doubt many
people have started using it given that it's sort of counter-intuitive
(again, compare with SoB).

If either the trailing comments or multiple addresses in a CC-tag has to
go, I think dropping the latter is clearly the best choice.

> >> 1) Stop calling Mail::Address even if available.[...]
> >
> > Right, that sounds like the right thing to do regardless.
> >
> >> 2) Modify our in-house parser to discard garbage after the >. [...]
> >
> > Sounds perfectly fine to me, and seems to work too after quick test.
> 
> OK, sounds like the way to go.
> 
> Do you want to work on a patch? If not, I should be able to do that
> myself. The code changes are straightforward, but we probably want a
> proper test for that.

Feel free to implement it this way if that's what people prefer. As long
as trailing comments are supported and discarded, I don't really have a
preference.

> > addresses in a Cc-tag in that it breaks --suppress-cc=self, but I guess
> > that can be fixed separately.
> 
> OK. If it's unrelated enough, please start a separate thread to explain
> the problem (and/or write a patch ;-) ).

Well, it's related to the "offending" patch that added support for
multiple addresses in tags. By disallowing that, as my fix does, the
problem goes away.

	# Now parse the message body
	while(<$fh>) {
		$message .=  $_;
		if (/^(Signed-off-by|Cc): (.*)$/i) {
			chomp;
			my ($what, $c) = ($1, $2);
			chomp $c;
			my $sc = sanitize_address($c);

			if ($sc eq $sender) {
				next if ($suppress_cc{'self'});

The problem here is that $sc will never match $sender when there are more
than one address in a tag. For example:

	From: Johan Hovold <johan@kernel.org>
	...

	Cc: alpha <test1@a.com>, Johan Hovold <johan@kernel.org>

results in

	sc = alpha <test1@a.com>, Johan Hovold <johan@kernel.org>
	sender = Johan Hovold <johan@kernel.org>

so that --suppress-cc=self is not honoured.

Thanks,
Johan
