From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 2/5] ls-remote: document --refs option
Date: Mon, 18 Jan 2016 22:39:46 +0100
Message-ID: <20160118213946.GG7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-3-git-send-email-t.gummerer@gmail.com>
 <20160118193140.GB1009@sigill.intra.peff.net>
 <xmqqsi1ud5dk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	bturner@atlassian.com, pedrorijo91@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 22:39:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLHWZ-0003lR-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 22:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596AbcARVjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 16:39:23 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35487 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530AbcARVjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 16:39:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so11889206wmz.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 13:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KCcOt0sLcoZAHMl+Z7E1LgAjJmWmdP1CsrawLciilaE=;
        b=0u53svHUE29ajeFTPNz0gpCUQVXtLHtqbD4HMhYWUEo3s1/xsMzZfc36KHoWalaaSD
         FCMeFcui5Mm3XlWnw1ZkIGzxxgSqL5kISsYTvQWZj+6j3jZ1RBwrK2AOgcqd6chEEAXh
         m7jRLFHOoTecwsXy3JZKN1BIjYyfbeAPmVQOrWAe3t3Xv0xoFrzwi5zm+4kBOHRDtc+W
         IUpoOqGadTP9dvWEOBhiD1jssUJLz/6YSdOGO2PIvh6QPt4TRAn3zJJAOZGo8dXfmGVp
         jZT7znUiBXGc1Hgc2HOSMk7AdQqAbsn+7rficZY/sWG3PBEgLv8LSmmleKC6Hy2ssVoJ
         1h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KCcOt0sLcoZAHMl+Z7E1LgAjJmWmdP1CsrawLciilaE=;
        b=Hqc+6B7bamFHZPNwITDhKP9hOo+SgT9E/jXrPwLhbRD0JbMYKjgEnGVaxile2ztvWJ
         QqUnDEXr83VJauqPUHzl+qyZywWg+JFwCbADRtTnvuhU6pdHfiIqGOMHYvHXwNHxe8tj
         keLMX83fwMb2KxQixmLTGQEg36kKGkh0mk9lUSwESaeWLhi09295d/z5BR0Kq1HP2qj8
         vguNyoDfTVA4mDz33d+HEuPYJaw/oWK1930hbRcGO5Wouk7hKSrXVLpeYol6anpLjXaj
         fvvZgueBhW3zrNogjJRf7+aaeuNuy1jOREqaBVXAN3/KYxhvA8icXGVAT5xdw7icfnpa
         7xxg==
X-Gm-Message-State: AG10YOThvnwBGnIgM5ZPv6vFrtmivvwf+ZGWpFRNqDi1u1bxn4oYw2cECV60x3NMlxHkzQ==
X-Received: by 10.28.211.136 with SMTP id k130mr16011159wmg.84.1453153160120;
        Mon, 18 Jan 2016 13:39:20 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id gb9sm25581752wjb.26.2016.01.18.13.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 13:39:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqsi1ud5dk.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284324>

On 01/18, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > On Mon, Jan 18, 2016 at 05:57:15PM +0100, Thomas Gummerer wrote:
> >
> >> +--refs::
> >> +	Do not show peeled tags or pseudo-refs like HEAD or MERGE_HEAD
> >> +	in the output.
> >> +
> >
> > Minor nit: we show whatever the other side sends us, which is the refs,
> > HEAD, and peeled tags. So mentioning MERGE_HEAD isn't wrong (if the
> > server _did_ send it to us, we would omit it), but it is a bit
> > misleading.
> >
> > I think saying "pseudo-refs like HEAD" is OK; even though we know it is
> > only HEAD in the current server implementation, it better describes what
> > the client side is doing.

Makes sense, will change.

>
> Good point, I think.  We probably would want to fix the glossary
> entry of the word that is not spelled with a dash in between the
> two word components (or update the above to spell it as a single
> word).
>

I'll update to spell it as a single word, as that seems to be more in
line with how it was used throughout the history.

$ git log | grep pseudo-ref | wc -l
2
$ git log | grep pseudoref | wc -l
18

Thanks, both.

--
Thomas
