From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the default
Date: Tue, 10 Nov 2009 00:12:05 -0500
Message-ID: <76718490911092112v4d1e7761ue98def756ed0d93b@mail.gmail.com>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
	 <1257789555.4108.348.camel@laptop> <20091110040847.GC29454@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Nov 10 06:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7j1l-00009w-GD
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 06:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbZKJFMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 00:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZKJFMH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 00:12:07 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:50880 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZKJFMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 00:12:01 -0500
Received: by iwn10 with SMTP id 10so3001372iwn.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 21:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=DAmcLifecefS8BI6dGDhlz851U1agywuGP2xkcZp2bU=;
        b=Sjjbz3yD04BfLh6MK9088jmq2NhSzyqFPQYqaC18khZcFZUG92KvotRawKcxCA5au5
         LFTFqCP3zw/IkEG8+CCg9t/MHDqHtc69TCRuHeUb4/X5g/1ZH4OqgnpBRsCFdVaiqkzU
         aK3/B6uUzt22Rp/c0DIXs9JqOrzn6744crqJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dMGIZw5qyge43u9zwwkG4yiPwbjl0M9AscNONw9c1kP3KFLSkfDQzvR6xu+bHAIuMQ
         l+3mGwGaRNHs1uWrW6Ov7GcSwJRu8SCzZ2DvuByDkoTaXErYnN5S8g2tJXiF23XcrAAz
         b8fqfwbeOz6+1ksr9JjgUHnoQOJ7PNxnkX5uk=
Received: by 10.231.24.142 with SMTP id v14mr1655842ibb.55.1257829925491; Mon, 
	09 Nov 2009 21:12:05 -0800 (PST)
In-Reply-To: <20091110040847.GC29454@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132537>

On Mon, Nov 9, 2009 at 11:08 PM, Ingo Molnar <mingo@elte.hu> wrote:
> So ... the question would be ... could git-send-email flip its default

This is already in next for 1.7.0. See 41fe87f.

>From Junio's What's Cooking messages:

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
  (merged to 'next' on 2009-08-22 at 5106de8)

> Am i missing something subtle about why this default was chosen?

I'm not sure it was chosen so much as it was just the way the cookie crumbled.

j.
