From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2016, #04; Wed, 20)
Date: Wed, 27 Jan 2016 09:46:27 +0100
Message-ID: <53B46FC1-7E34-49F1-9955-AE87E27519F5@gmail.com>
References: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com> <C1F7518D-3898-4F53-8BAD-60B5648D4B5B@gmail.com> <xmqqwpqw9cdk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stefan Beller <sbeller@google.com>, Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:48:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOLkJ-0000TL-IC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 09:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbcA0Iqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 03:46:33 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:32967 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbcA0Iqb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 03:46:31 -0500
Received: by mail-wm0-f48.google.com with SMTP id 123so141065869wmz.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 00:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LyDTa+E3gydWQJ425o43OOy1ATCt938oo8CW3FY7fnU=;
        b=rM/oJ3smEES4sQZC9a8kD9JwtDfUGZgozKDjD6AFATBDKisVS7ZXMPPeemdE6e5EWx
         mXGmQU4v1HYlt70dcpucs/I1SCMHUVgwdlIu9C4j98p7dOTYsNH8spqzVqwXsEQPS1Le
         QEyHAok0q9k3FgpeBVats0NveiDtGvbaflRWZ/fovq2s+lgHJHwjX4gYPG0SZMjj8GDg
         x7nyAMaOr5diyD6OmVZ8YUznU2sLYfLTwD4frQu8bp0dyV2ioHlBI0Yl41wi1GTSbaVG
         PVZrBU/1KjzKxJoC+dKFJLsNPMV1F/MIliQlu/wj8DEVJHj31OM+zZKiaYsPa29DNBJh
         poIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=LyDTa+E3gydWQJ425o43OOy1ATCt938oo8CW3FY7fnU=;
        b=CN9hpjBVbM9J2KaFRRcB6m29FMrehC88DgpeI8UF4gxfjsXauDULyKQUUtV33MVk8o
         pufpuhnJlTUusdm2L8Zi7BlxMzNer3u56PbIUw3uuseBxzEUPQOhbLqQBDZx392ELZOr
         RltHCUg2/nf7N/wX+e8PGzKVmOpJHo/zLeNCkq2Ko7nMeFCaU6kjsfttASIrW9UBQij0
         qPFX/8tKbadEgjELYAJrM7Yx6EAUiqQV/IRQ8/tr1KDRVuzoa+e/M8ryGSi5gA5aVVmC
         L1vwLD+tW8ZxXd3MolUy25/gTfaVLoLLFYPrM9HbNlNuBwWkBaIz1jGuPsJzIEs60yKL
         5m+w==
X-Gm-Message-State: AG10YOT5KutisGjPa5Dhr38/eTHjR/Lwt94tBjKnfT20Ej36+e47itZETAq1Mbz4nTscSQ==
X-Received: by 10.28.223.134 with SMTP id w128mr27554807wmg.69.1453884390030;
        Wed, 27 Jan 2016 00:46:30 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA675.dip0.t-ipconnect.de. [80.139.166.117])
        by smtp.gmail.com with ESMTPSA id gb9sm5052179wjb.26.2016.01.27.00.46.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 00:46:29 -0800 (PST)
In-Reply-To: <xmqqwpqw9cdk.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284896>


On 26 Jan 2016, at 23:58, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> Hi Junio,
>> 
>> Did you miss the topic "submodule: extend die message on failed
>> checkout with depth argument" or do you not agree with it
>> ($gmane/282779)? Stefan Beller reviewed the commits ($gmane/283666
>> and $gmane/283851).
> 
> No, these three are still in my inbox.
> 
> Quite honestly, "test to demonstrate breakage" alone is not all that
> interesting to me unless I get a firm impression that somebody is
> (or will soon be) working on fixing the breakage--which would make
> it worth keeping track of it in my tree, to allow the eventual fix
> to be more easily verified and protected from getting broken again.
> Also "these look good to me" without much explanation is not much of
> a review, and such a comment on a "demonstrate breakage" did not add
> to the sense of urgency to the issue, either.
> 
> That was why it has been sitting near the bottom of the pile.

OK, I get your point. I got the impression that Stefan is on to a fix ($gmane/281260). Looks like he is not and I need to learn more about Git to tackle fixes of this scope. Would it be an option for you to just drop patch 1/3 from this series and look at the remaining ones? 2/3 fixes an "&& chain issue" ($gmane/282776) and 3/3 prints a explanatory user warning instead of an incomprehensible error ($gmane/282777).

Thanks,
Lars