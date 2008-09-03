From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] for-each-ref: `:short` format for `refname`
Date: Wed, 3 Sep 2008 18:33:45 +0200
Message-ID: <36ca99e90809030933m15ef9cf5p1a56bfe90071fc10@mail.gmail.com>
References: <36ca99e90809030133r43fc5a3agad1aa38339a758a3@mail.gmail.com>
	 <1220431352-30605-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080903151829.GB27682@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	szeder@ira.uka.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:34:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KavJl-0007gH-PZ
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 18:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYICQdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 12:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbYICQdr
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 12:33:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:44070 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYICQdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 12:33:46 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2024856waf.23
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+mTENokxve51PBdtCU9We3hXlvYE5dslh58L4ZCrpKY=;
        b=gCyr14tqbCNxYFGYIxN0WDcU8s09hB/GR5Cr2MPoOb/bHUIUM8uz/hUCPXlVow/kUj
         nckzBt+3LV6MDmm/i/EvYfqJLdpps3oQrMCq7XTID0OmibGB7wBMzszzRsg6cXLCglk/
         0VNvQt5lN54aABCXgFuudphpBxhxoRNQ7yID0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EcWVtVS1TlcCm7Bmava7rY7J8jhgoK+2RBh70B6o4UGv/WS0nndGbAhAAn3Ktvwyko
         aXmsuPtnbdzpBAM4kHenz4qkCZaLLfJ1BMPV/wG0jx2JafCEO63JLm1E2eLpwX2DbIll
         0bjPTvvxc2KlIHfbNgh8pU+hZS99U1Mya1bHU=
Received: by 10.114.53.1 with SMTP id b1mr7772186waa.53.1220459625559;
        Wed, 03 Sep 2008 09:33:45 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Wed, 3 Sep 2008 09:33:45 -0700 (PDT)
In-Reply-To: <20080903151829.GB27682@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94810>

On Wed, Sep 3, 2008 at 17:18, Shawn O. Pearce <spearce@spearce.org> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> Try to shorten the refname to a non-ambiguous name.
>>
>> Changes in v3:
>>  * don't compare sha1's, its ambiguous if the short name
>>    resovles to more than one ref
>>  * use xstrdup()
>>  * use indexes for the loops to clarify backward/forward
>>    direction
>>
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>> Cc: git@vger.kernel.org
>> Cc: szeder@ira.uka.de
>> Cc: Shawn O. Pearce <spearce@spearce.org>
>> ---
>
> Looks good.  But the commit messages shouldn't have the "Changes
> in v3" section or probably the "Cc:" lines.  The changes in v3
> part usually goes below the ---.
Ok, but shouldn't git format-patch detect that there is already a ---
in the commit message, or is it illegal to have more than one ---?

And while we are at it, shouldn't git format-patch detect, that there
is already a [*PATCH*]-prefix in the first line of the commit?

I always need to edit these two things after format-patch.

Bert
>
> --
> Shawn.
>
