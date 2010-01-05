From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC] Add support for the google-chrome web browser
Date: Tue, 5 Jan 2010 12:20:40 -0500
Message-ID: <32541b131001050920j2a569ec8u8811f1b0358f21ef@mail.gmail.com>
References: <20100105051906.GA22799@efarrerlx.appsig.com> <7vr5q56rew.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Evan Farrer <evan.farrer@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 18:21:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSD62-0004sj-VD
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 18:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085Ab0AERVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 12:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083Ab0AERVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 12:21:09 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:53249 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab0AERVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 12:21:06 -0500
Received: by yxe26 with SMTP id 26so15799564yxe.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 09:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=WPN4NHGytVykMH1NreJ/5jKJ/w6WfWwc6xAyItdeCsQ=;
        b=PGoaVV2Yi7+eWqYRVlSLaWTzQNO9DWVO5xTHE+E3zt70KYxFyVgV/tp+5RxIXzH3HK
         JtsoNNbw4gyjDEmgl/Z6DHqUy3yhFpNQ6WBMAcGd5y02KwhOZ579Re2GIZ8aFR6xpcNe
         Lj6PBEIUI9pxCQThPRHoi3OV+HtGdOEZnN0ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eXB/dHrkfcXDqwReLaFhIKvGQ4xhksClGC1AizHFaHCK0zylo0vRq6jqm6FyxEO31S
         AK9bD60y3bf1KwRr3P51ehe+pkcRtiByRjKnU7bzRu4tmvPSzwWzUPQJjiySSUdyoKBC
         WhwfhJJ55gYoFfgWVRc/FfCR5RHdZLrIPU7mo=
Received: by 10.150.65.9 with SMTP id n9mr10414246yba.187.1262712061212; Tue, 
	05 Jan 2010 09:21:01 -0800 (PST)
In-Reply-To: <7vr5q56rew.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136195>

On Tue, Jan 5, 2010 at 12:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Then we don't even have to add any specific support for "google-chrome" or
> anything that takes "$command $path..." and opens the documents.
>
> Is there a downside in this approach?

If someone has another firefox-derived browser installed with a
different name and tries to use it, this default wouldn't do the right
"firefoxy" thing, and would instead fail strangely.  On the other
hand, right now it'll fail anyway, just not strangely.

So your proposed change would decrease the number of failures, but
increase the strangeness of the remaining failures.  Maybe that's the
right thing to do though.

Avery
