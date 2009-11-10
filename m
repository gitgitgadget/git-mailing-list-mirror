From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the default
Date: Tue, 10 Nov 2009 13:46:50 -0600
Message-ID: <b4087cc50911101146j7f773613j74d6d6716a82ebd4@mail.gmail.com>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp> 
	<1257789555.4108.348.camel@laptop> <20091110040847.GC29454@elte.hu> 
	<1257838352.21088.5.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Peter Zijlstra <peterz@infradead.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 20:47:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7wgR-0006KU-SB
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 20:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757960AbZKJTrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 14:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757956AbZKJTrH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 14:47:07 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:47380 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757958AbZKJTrG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 14:47:06 -0500
Received: by ewy3 with SMTP id 3so405926ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 11:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=X2V7VEx3Ptn246S5Mk9ti1lb28Ikvuv8wSMHJ+vatEc=;
        b=sCS8Pdb3xbxdEB9qsRnyap16wTBLbIbkBs57unDAg5uPkGVa/GFPQVMrpuLIzHIAwJ
         HL33SlsByfgo2cJqlmRhCoR9V86FWeVe7d1dnNlHOmgGyCpA8PAUGHTPfS0LgMpZucM2
         QlX3c6BxkUGI7k6R4aOWdp6Is2Z2Zitc8AF6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QnHgcQ2T431J+usccVpB5XAD+T6VtTFT2xk8rEBEbBN54atlp1YkAIUis+qPj5qfz4
         HB1czO+Q5fYQZ+3U7TG9DSyh4eQCNRopWY2dqlVSa9dDb+bLyNYXPaPhL7/na8Qdr/kL
         r5V04w2bscoOX0a4j4y5SEkuotENIhUGzA088=
Received: by 10.213.96.136 with SMTP id h8mr588809ebn.48.1257882430265; Tue, 
	10 Nov 2009 11:47:10 -0800 (PST)
In-Reply-To: <1257838352.21088.5.camel@twins>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132587>

[Sorry about the repeat, Peter]

On Tue, Nov 10, 2009 at 1:32 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
> On Tue, 2009-11-10 at 05:08 +0100, Ingo Molnar wrote:
>> about half of every patch series that gets sent to me on lkml is
>> unreadable in my email client due to the default threading that
>> git-send-email does. It looks like this:
>>
>> 28685 r T Nov 05 Hitoshi Mitake =A0( =A031) [PATCH v5 0/7] Adding ge=
neral performance benchmarki
>> 28686 =A0 T Nov 05 Hitoshi Mitake =A0( =A031) +->[PATCH v5 1/7] Addi=
ng new directory and header fo
>> 28687 =A0 T Nov 05 Hitoshi Mitake =A0( 368) | +->[PATCH v5 2/7] sche=
d-messaging.c: benchmark for
>> 28688 =A0 T Nov 05 Hitoshi Mitake =A0( 148) | | +->[PATCH v5 3/7] sc=
hed-pipe.c: benchmark for pi
>> 28689 =A0 T Nov 05 Hitoshi Mitake =A0( 149) | | | +->[PATCH v5 4/7] =
builtin-bench.c: General fra
>> 28690 =A0 T Nov 05 Hitoshi Mitake =A0( =A024) | | | | +->[PATCH v5 5=
/7] Modifying builtin.h for ne
>> 28691 =A0 T Nov 05 Hitoshi Mitake =A0( =A025) | | | | | +->[PATCH v5=
 6/7] Modyfing perf.c for subc
>> 28692 =A0 T Nov 05 Hitoshi Mitake =A0( =A030) | | | | | | +->[PATCH =
v5 7/7] Modyfing Makefile to b
>
> Do what I do and flame the sender and have them repost.
>
> I simply won't even attempt to read crap send like that.

What, precisely, is unreadable or crappy about that? I suppose the
chaining was introduced to keep some order to the patches.
