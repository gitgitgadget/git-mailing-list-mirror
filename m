From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Wed, 11 May 2016 16:57:40 -0700
Message-ID: <CAGZ79kYj2Vs-Bp_6Fya4kDzpo1_9TouSPq0PBrwJSV7q5RScjA@mail.gmail.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq4ma5l526.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY3S6SmJOMQ7RAKw0yTvicY=Y1VRRGdm5uK9+Eb7W+Ykg@mail.gmail.com>
	<xmqqlh3gi2qr.fsf@gitster.mtv.corp.google.com>
	<xmqqh9e4i2av.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 01:57:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0e0f-0002GL-9b
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 01:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbcEKX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 19:57:41 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36245 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbcEKX5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 19:57:41 -0400
Received: by mail-ig0-f182.google.com with SMTP id lr7so44937982igb.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=am1tQ0I3hGb4ng4rD3CNgONtIXw6nvNROlt+T5Lq4Ck=;
        b=khUojg2SuZvoN3Aqq7lYdq+wwkd+lAkx55Ex1U7eQxc8k1fNGOAgz48XACnruLNpp6
         /oXkkUXfPmBBGV8swqgF5p7j4SV8LNt/rXgVbN8vsNvtKr5vweCeX/SC7+moZ3pmM2kx
         afwU3qh1mPwBayA74Uh5pyAjS5JQB+SF9+nZaTdmA3VCM2n9OsDEVIApy1j3qlN1BQK9
         8B6gXV1neygKKZIHECFf+AdecCSXj85yBKu5tX0bemKQ82k9gJGHrPeT7Z4sV7fWAIcl
         PyV0BiQmyJ6NY5bsl8bBGAV2rDQO0fcFD9ns1ObFWxU7IPsGZBgZ89GIaxx57fFP092B
         PYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=am1tQ0I3hGb4ng4rD3CNgONtIXw6nvNROlt+T5Lq4Ck=;
        b=d2LYru9w5uoElXID7b7XDENYN7jJZOUKwy/rlzcgbyagJ1w+b/GXtQ39AGqiWtEnnv
         iESxOmd5RQkc6qVSBNvxhpY3qDqwbeammbO/ZPGWzzaoysI3gF02QeI+5xzewm4Iox0g
         xHnel4H3dJKuj5BbCEY4jFXBBRRsOu4T0jjhZwpNK0fAezGFveoLmN+z5uWT4XlMf+Z2
         6ZlGBkIDb3GSUGxFyGuKY9JEEt4nTbt6nwjABCqb7m8Y6jUW2KGAwJmwpDgNpseziBow
         un6jXgDXzlXdzxCfHKrPmEHnvdZaV++vpmxtb9T1Z5EKLbIyJBcPdCC+DX5RUotNe5HH
         DSDQ==
X-Gm-Message-State: AOPr4FX0wnjkggejZl9w9Qc2sJUp1dakhpxqqrSkJaTBbiUBmtuXK9iOqH3qeanEwdL4wApcBfoFIM9AQJEoi1SO
X-Received: by 10.50.196.170 with SMTP id in10mr5605241igc.93.1463011060084;
 Wed, 11 May 2016 16:57:40 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 11 May 2016 16:57:40 -0700 (PDT)
In-Reply-To: <xmqqh9e4i2av.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294380>

On Wed, May 11, 2016 at 4:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>   git ls-files . :(file-size:>1024k)
>>
>> I somehow do not think this is a way normal people (read: end users)
>> would want to interact with Git.  Pathspec is about "paths" and
>> various ways to match them.  It is not about contents that happens
>> to be currently named by that path.  Don't tie types or sizes to it.
>
> To clarify, think what that non-pathspec means when used like this:
>
>     $ git diff :(size>1M)
>     $ git log --follow :(size>1M)
>
> Which side of comparison does the "size" thing apply?  Either, both,
> randomly?  More importantly, what use case of users do these
> commands serve?
>
> That is why I said that pathspec should never consider anything but
> the pathname string you see.

I see. That is bad indeed. So I'll go back and finish the submodulespec
to present.

Thanks,
Stefan
