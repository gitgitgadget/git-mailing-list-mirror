From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 12:23:19 -0700
Message-ID: <xmqqpp4u6swo.fsf@gitster.dls.corp.google.com>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
	<vpqtwu6sf4r.fsf@anie.imag.fr>
	<xmqqoake4akt.fsf@gitster.dls.corp.google.com>
	<xmqqd20u48at.fsf@gitster.dls.corp.google.com>
	<5581A3A3.1070908@web.de> <vpqh9q6gsdt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:23:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Ivo-0002kk-S2
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbbFQTXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 15:23:22 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33947 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbbFQTXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:23:21 -0400
Received: by igboe5 with SMTP id oe5so1223734igb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=j8MFhm6MQec7o1IexcyZLaslruagqTPZC244/W+4hiI=;
        b=Aqlx0CfJJM6Pi+O1M3gkHU1nMRUJKA7b+f8dYT2+HdWlaT4QTjrSuicDATSQEq1jG+
         w+qIwHClsMafRvcDkT31H9nNg8UjqlqtPgTnmOtxHAwMEqLC+GWSJBL3fk5jRrEMjKPV
         PrMzAoomH4xEN+hWRaXQpvhCsDA28pVdq12yN7DOa5u7rzi8Y1kjRwklTwmFzx+K7zWb
         ZR/YhQ8uboYqwox/iClOwCzzaGYK4ZMU4VAvznuhoVvXJbdwcTcqQXxoXRTTu6dMes/h
         640EtbtxQcDUEejNG6YhRFCmrGocthqSD2VItOiNWMh2wcC8voiWsz8TJq7yYQhFT4Hu
         dTeQ==
X-Received: by 10.42.102.211 with SMTP id j19mr1906594ico.50.1434569001184;
        Wed, 17 Jun 2015 12:23:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id o19sm12519917igi.14.2015.06.17.12.23.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 12:23:20 -0700 (PDT)
In-Reply-To: <vpqh9q6gsdt.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	17 Jun 2015 19:24:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271886>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> My v3 will probably use the original line:
>> git-checkout - Checkout a branch or paths to the working tree
>
> I think mentionning "Switch branch" was a real improvement. For someo=
ne
> not familiar with the version control vocabulary, "checkout" does not
> mean much (just looked in a dictionary, it talks about payment and
> leaving a room in a hotel ...). And someone not understanding what
> "checkout" means in this context won't be helped much reading the
> description and getting "checkout" there.

Or, borrow a book from a library, which I think is the closest
analogy for this operation.  But you are right.  It is suboptimal to
explain "checkout" in terms of "checkout" ;-).

> But as you say, it copies into the workspace, so "copy a previous
> version into the workspace" sounds good to me.

I am afraid that "previous" would lead to "Ah, you mean HEAD~1?"
confusion.  In any case, you cannot copy what hasn't yet been
created, "previous" is superfluous.

I think "restore" also by definition has to go back to _some_
existing version, not a future yet-to-be-created one, so "restore to
some previous state" is superfluous; in that sense, I find that
"restore working tree files" may still be the one that makes most
sense, at least to me, among the phrases floated in this thread so
far.

> Basically, I'm fine with anything starting with "Switch branches or",
> but please do change the headline ;-).

Likewise; I agree "switch branches or" part is good.
