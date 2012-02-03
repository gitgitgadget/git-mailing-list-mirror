From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Fri, 03 Feb 2012 12:28:11 -0800
Message-ID: <7vehuboe5g.fsf@alter.siamese.dyndns.org>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino> <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:28:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtPkR-0003yH-D4
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 21:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386Ab2BCU2a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 15:28:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757390Ab2BCU2O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 15:28:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1DCE6EF3;
	Fri,  3 Feb 2012 15:28:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ltkpDhR2Ru+YYzyx/N3Z/a8fe
	24=; b=f3rDarHyWJ2PJdw3zW3n+N6BcjSwyimr4TOfmK2mAJGMESF6AkohxdngM
	82fIHfYRin3HzYt2CR3oen3VRqugeNPVS3Fkt/UI4rJBtVuXfYbtTOO6itH9tQhs
	gTBtZMr7URIXBVPe54drfT6nrxAONqzzUwce+M17d3N8dDCOaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=pg3UFE740CxQJ45jmL6
	t7Zpkq9w9MBYvc5Yq2G3i0d5qSA/IvOzeoKjXIyJMsKS1+cfqnpRZWyrWWvFwlDD
	He0M2R6eaZ/8fneECTqcP2u6iJv+hQmPHSRhsByUJZK3txPNoKNya+oPax2PqmoX
	gdoBimY6M/nPqrphSJIwYRkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6E6E6EF2;
	Fri,  3 Feb 2012 15:28:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 331C66EE5; Fri,  3 Feb 2012
 15:28:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98752244-4EA5-11E1-A149-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189799>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Feb 3, 2012 at 2:17 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> ...
>> Here is what I ended up in preparation for queuing the series. I sti=
ll
>> haven't seen any version of 4/4, but please check $gmane/189683 and =
see if
>> that matches what you intended. Also I am assuming $gmane/189606 rel=
ayed
>> by Jonathan is a squash between your 2 and 3 (which didn't reach me)=
, so
>> please advise if that does not match what you want to have.
>
> This is getting ridiculous, now I sent the patches directly to you, i=
s
> your pobox.com server also silently dropping them for no reason?

Do not blame pobox.com; they have nothing to do with the corruption of
your headers.

The volume of messages on the git mailing list I read on gmane's nntp
interface is much larger than that of my personal git-mail mailbox.
Patches and ideas in their early rounds do not come to my personal
git-mail mailbox (because I asked people not to cc: me such messages
unless I am an area expert, and they have been good to me), but I try t=
o
point people not to go in a wrong direction as early as possible to avo=
id
wasting time for contributors and reviewers when I can.

So I almost always am on the mailing list "newsgroup" when dealing with
git related mail traffic (which is not 100% of my git time to begin wit=
h),
and only after I ran out of messages to process I check my personal
git-mail mailbox "newsgroup". I usually only find "help me" messages an=
d
questions that are addressed directly to me in private, and my standard
response to them is to ask the sender to conduct the business in public=
 on
the list instead. In other words, my personal git-mail mailbox "newsgro=
up"
is primariliy a back-up mailbox for my purpose.  I do not even run
fetchmail that often to poll it, because the latency for it is large du=
e
to the way I work (described above).

You just caught me at the wrong moment when there were much more import=
ant
messages on the list (more refers to the volume, not all of them are mo=
re
important) and I was working on them (not limited to your issue) from t=
op
to bottom in the mailing list "newsgroup".  I however wanted to get the
zsh issue resolved sooner, and because you seemed to have been having s=
o
much trouble with your MUA (I only so 0/4 even for v4), I tried to help
out by sending what I thought is already good, hoping that a message th=
at
only has to say "that looks good, thanks" would be easier to make it to
the list.

All that happened before I got to the back-up git mailbox where you sen=
t
the rest of your v4.

People say "Oops, our mails crossed." and go on without making too much
fuss about it.  E-mail communications are asynchronous.  Get used to it=
=2E

I think your mail breakage, from looking at your mail header, is this:

  From: Felipe Contreras <felipe.contreras@gmail.com>
  To: git@vger.kernel.org
  Cc: Junio C Hamano <gitster@pobox.com>, SZEDER G=C3=A1bor <szeder@ira=
=2Euka.de>, Jonathan Nieder <jrnieder@gmail.com>, Thomas Rast <trast@in=
f.ethz.ch>, Felipe Contreras <felipe.contreras@gmail.com>, "Shawn O. Pe=
arce" <spearce@spearce.org>>
  Subject: [PATCH v4 1/4] completion: work around zsh option propagatio=
n bug

Notice the excess '>' after the last address on Cc:?

It's not like this is your first serious submission to the list, so it =
is
curious why only this time you have been having so much trouble. Perhap=
s
you have changed your mail set-up lately?
