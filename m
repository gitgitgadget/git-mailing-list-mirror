From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: About git pretty
Date: Sat, 23 Aug 2008 01:34:43 +0100
Message-ID: <e1dab3980808221734l470134d3u62bd708e7baabe0d@mail.gmail.com>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
	 <7vd4k062k2.fsf@gitster.siamese.dyndns.org>
	 <e1dab3980808221704h3c713e64n41adc631d7a79601@mail.gmail.com>
	 <7v4p5c612y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 02:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWh6b-0000Jn-Fj
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 02:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbYHWAeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 20:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYHWAep
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 20:34:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:43818 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbYHWAep (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 20:34:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so53569ywe.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/XioDRch/ZtCgtXEeyehjSoVB5k17ocklITOIYGMWr4=;
        b=OCfcHAZyH2lFqkdud3l9ugRjlXCwC9eq2Fs8AZTRjM2m8ySNXcuPWRqysyPfta+L4d
         AJdggBoHDYSv+1+frziy10a1BFWZR62+ybBO1/aNJkI4eRIIemAYnaBgI6aOkh/0KTiQ
         Culijr73X01fYoD/f8ywznUOKlaemTnzjZ/cE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eRgi2gm7Z+RXjY6VxRsWbiDNMi4QIcvz6d+j4wP0/0PYoME1HRGJyNjLFVHUckut2T
         VHOyNfPFeOMNpQFY1qBL+QTwdPpda+P4hhwfUEULsAS2wwqe+hUpGfsX3HxSUvBljaUN
         2wRDNKg/juhgnjNu91vg6Xd61TR726ZPI7gSU=
Received: by 10.142.141.21 with SMTP id o21mr618017wfd.213.1219451683463;
        Fri, 22 Aug 2008 17:34:43 -0700 (PDT)
Received: by 10.142.136.18 with HTTP; Fri, 22 Aug 2008 17:34:43 -0700 (PDT)
In-Reply-To: <7v4p5c612y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93410>

On Sat, Aug 23, 2008 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "David Tweed" <david.tweed@gmail.com> writes:
>
>> On Sat, Aug 23, 2008 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Felipe Contreras" <felipe.contreras@gmail.com> writes:
>>>> It is just me or 'pretty full' doesn't exactly convey the meaning of
>>>> the action to execute?
>> [snip]
>>>> If you like the idea I can work on a patch.
>>>
>>> FWIW, I don't like it.
>>
>> It's probably much too late to change conventions given the number of
>> deployed scripts, but one of the annoyances for me about git is that a
>> lot of the commands/options names are based on what the code does/is
>> written rather than relating to what a user who doesn't know or care
>> about the inner workings expects as output. For instance, I imagine
>> the --pretty gets its name because a pretty printing routine, called
>> pretty_print_commit in the code,...
>
> It's the other way around.  We name function pretty_print_commit() because
> we would want to pretty print out output and the option to trigger the
> behaviour then is named --pretty.

The point I was making is that, to my understanding, pretty-printing
is the "standard" term _programmers_ think of when they're thinking
about writing routines for doing sophisticated output formatting. I
doubt that anyone who isn't an experienced programmer associates the
term "pretty printing" naturally with "configuring output layout". I
was talking about options that would make sense for someone who's not
a hardcore programmer but for whom using git would be beneficial, so I
didn't include git-diff for criticism because to be able to use the
output you've got to be familiar with the diff program already, and
hence know the name.

(My undergrad degree was in mathematics and I only slowly picked up
computer jargon as I moved into computer research. Git would have been
useful to me long before I happened across some papers on pretty
printing, and I ended up learning what fsck in general  means from
trying to figure out what the hell the faux-swearing you get on the
internet was. I could probably have gone on in ignorance of the
concept unix people encapsulate with "fsck" otherwise.)

My point is that the terms that come naturally to hardcore programmers
are opaque to people who might benefit from git.

Being honest, my only serious issue was with git reset. The about the
first five times I knew the "operation" I wanted to perform by
carefully checked the man-page because I wasn't sure whether --hard or
--soft corresponded to the operation I wanted.



-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
