Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F761F42D
	for <e@80x24.org>; Wed,  9 May 2018 09:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeEIJCL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 05:02:11 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934355AbeEIJB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 05:01:58 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0M3wF4-1eOvPn3CNO-00rYFV; Wed, 09 May 2018 11:01:53 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 5BFC3643F9F;
        Wed,  9 May 2018 09:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kx6Dgxbpzx-B; Wed,  9 May 2018 11:01:34 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 6B3A6648922;
        Wed,  9 May 2018 11:01:34 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 11:01:33 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 1613E804D2; Wed,  9 May 2018 11:01:34 +0200 (CEST)
Date:   Wed, 9 May 2018 11:01:34 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Stefan Beller <sbeller@google.com>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitk: show part of submodule log instead of empty
 pane when listing trees
Message-ID: <20180509090134.ozikiizgltfiusp5@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari>
 <20180508122229.k3n3ccpa5g3g4dxa@pflmari>
 <CAGZ79kYxZ43kJwS_odhNwCO2e_n-8JLNynAZj0+Hp3ugzYbqUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAGZ79kYxZ43kJwS_odhNwCO2e_n-8JLNynAZj0+Hp3ugzYbqUg@mail.gmail.com>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180508-6, 08.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:CX3EVxCQJmLL9S3XTtFf78MFzUAWwEt+BH0WtCW+VzGbL7Uxmby
 8YhthHVVpvxo/+Q5lIBCvqdEtnNQqaiRldUZ0uD28e43Jvn+82LXKdagqkIiVY6+Fa79QYr
 6Tkvr4APu8TFOSifvqj2dB213pKcZnXWxlEcWSiHZSnVY9ge89Pe3MxxNlEgWvAkDM9w2KV
 YfpDUCHWOPNvDTTIXei3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KKajWpksmPM=:ksExNUPtZ1QyJfKETCDLsl
 A79J4UoV2Ed1PTJ4cGpOIA6j8RYWxYnkPzEsJooe6PhfCXr1I7dTdGopXx+X9ReLsrmWBaYXU
 P5vXF3IWlc33yGV5BI5A1df2I7R4OpwfplbibzqZ5D/JgM2MjaDOXZmNZTxy0+Z1EALWMjZWC
 oRuXeJEls8t2DhHNzShbYui//lzRrDEl0hQkoD0lBZg/u9BvyRY1Ki990SawC6gb9661j9BIC
 o5OL+zDn8nMcNupS+EKuK4uFIyjEoSBuy3Eoy+uqdOL7N6z6ewV+S0EuFUmaD54QXCUnsoc3T
 uEumvfQ5Xg795xmomY7FpcFrODgWVtHfoxK5YBUYdXl8WOYPEgOApgvieM5UvHsuiXCQvSxgF
 vif829X6NFrER6pPW3VAjdgfO56a5m461jI4SK9Rk/nUgugkU4+Yfd98e1EtZkelkwRHtfkk1
 F3Cekk5UbPBnpdCSTT0v0hd9ESik+oGYtbjtUsuY2iazLkVLGfhh8TRF+jOHePPfZmesfYeEt
 8JGrOFadNHcHyNHGXjYx0xIM7gFKd1cTpjnewPr9KfOMBIRuvQHt1G7v9SZpFE/glXvjHQ5p8
 09DwRSEZly4i7ZOwnTpGfo2cFHo/XEiSuIv0ytq5eYe2T0yUWJMAV+kEUNAPBzHMsIUsES0GN
 PerNutFjkBtgmmWwk1yXJ3p+PdVaUmhEVLJ/REudhGzZLMKItLl2/La+LWZluqnYNdEk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller, Tue, May 08, 2018 19:07:29 +0200:
> On Tue, May 8, 2018 at 5:22 AM, Alex Riesen
> <alexander.riesen@cetitec.com> wrote:
> > Currently, the submodules either are not shown at all (if listing a
> > committed tree) or a Tcl error appears (when clicking on a submodule
> > from the index list).
> 
> I do not understand where this appears, yet.
> Where do I have to click to see the effects of this patch?

Er. I meant to say the file list panel (bottom right panel). Sorry,
didn't come out clear. I'll reword the commit message next time.

> > @@ -7659,21 +7660,42 @@ proc showfile {f} {
> >      global ctext_file_names ctext_file_lines
> >      global ctext commentend
> >
> > +    set submodlog "git\\ log\\ --format='%h\\ %aN:\\ %s'\\ -100"
> 
> Do we want to respect the config option diff.submodule here?

Probably not. It is already done when the file list panel is in "Patch" mode.
The "Tree" mode of the panel shows the files in full, so the submodules should
be shown similarly: in a format resembling their full (referenced) contents.

> The -100 is chosen rather arbitrarily. Ideally we'd only walk to the
> previous entry?

Yes, the limit is indeed arbitrary. I'm reluctant of listing full history,
though: it might take too long a while (and does, in my line of work). Maybe
an option in the settings? Or some kind of a more natural limit (for 1 second?
Until the end of panel?)

> > -       if {[catch {set bf [open $f r]} err]} {
> > -           puts "oops, can't read $f: $err"
> > -           return
> > +       if {[file isdirectory $f]} {
> > +           # a submodule
> > +           if {[catch {set bf [open "| sh -c cd\\ \"$f\"&&$submodlog" r]} err]} {
> 
> Can we have $submodlog use the "git -C <path> command"
> option, then we could save the "cd &&" part, which might even
> save us from spawning a shell?

That's because I forgot about that option. Of course, I'll fix this.
Also need a shellquote for the path.

Thanks!
Alex

---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

