From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] rebase: command "ref" and options --rewrite-{refs,heads,tags}
Date: Thu, 30 Jun 2011 09:55:11 +0530
Message-ID: <BANLkTimZzMXo17eRQMSq8RBQ9FBM4ui25Q@mail.gmail.com>
References: <cover.1309133817.git.greg@quora.com> <7vhb7bxgt9.fsf@alter.siamese.dyndns.org>
 <BANLkTinDFYsw7-N=_Ex8i42So_0LzVAWvA@mail.gmail.com> <20110628104758.GS5771@dr-wily.mit.edu>
 <20110628131717.GA6822@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 30 06:25:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc8ot-0001TI-1F
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 06:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881Ab1F3EZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jun 2011 00:25:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39398 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab1F3EZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2011 00:25:32 -0400
Received: by wyg8 with SMTP id 8so1281670wyg.19
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XLD2yxmBp1XKqx17W3X6DXDzI3QAh/Hq4+o/VFrETxM=;
        b=tdGI78wSLDJh19yAENiYRBJFsLLfhNdP9JxHeAddp4yv69rjfWxSOlQIqUD0wRw/kv
         I1mhwo0BHtf4QdCokvRVdt+vuaNMCyzOk8SlgquypqJb1EjHP56cnLaeRygWAMN8E0DX
         n1xjzrWPtME/JKKTYmhmeo4i4IA92DLaNKlx8=
Received: by 10.216.238.80 with SMTP id z58mr2141900weq.106.1309407931511;
 Wed, 29 Jun 2011 21:25:31 -0700 (PDT)
Received: by 10.216.18.16 with HTTP; Wed, 29 Jun 2011 21:25:11 -0700 (PDT)
In-Reply-To: <20110628131717.GA6822@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176468>

Hi Greg!

Greg Price writes:
> On Tue, Jun 28, 2011 at 06:47:58AM -0400, Greg Price wrote:
>> I agree with your footnote -- the more general case will require a
>> more powerful sequencer to support properly. =C2=A0And now I see tha=
t
>> Ramkumar Ramachandra is making progress on such a thing right now!
>> That's great news -- this is a project that has been attempted at
>> least four times, by five people (including me), in the last three
>> years. =C2=A0I hope to see this round make it in -- I was actually t=
hinking
>> about returning to the problem after seeing this series through, but=
 I
>> would be glad to see Ram beat me to it.

You're more than welcome to join in -- all the work is public :)
The latest iteration of the sequencer is in 'pu', and I'm currently
busy rolling out a nicer version.

> Hmm, on further reading I'm not sure the sequencer Ram aims to build
> this summer actually extends to the "mark" and "reset" commands (or
> the concepts of "the rewritten <commit>" and "detach" in the
> pseudo-TODO notation of your footnote) that would be required to
> implement this broader rewrite-side-branches feature. =C2=A0It looks =
like
> the focus may be on taking the existing features of rebase and
> bringing them into C.

Yes, you're absolutely right.  Bringing the existing features to C is
quite a challenging task in itself, and is bound to keep me busy for
the rest of the summer.  I don't plan to implement the features your
series introduces yet, but it's certainly a great long-term goal -- I
think the current series has all the right ingredients;  it just
requires a lot of work before it can start providing more features.

> This sounds great too -- it should make rebase a lot faster -- but it
> will leave open the pet project I've thought about returning to, of
> making "rebase -i -p" work correctly even when the user wants to
> rearrange the commits rather than just s/pick/edit/ etc. =C2=A0That w=
ill
> require implementing a richer sequencer very like the one required fo=
r
> a general rewrite-side-branches feature.

Right.  Since all this will take time, it'll probably be a good idea
to get your series merged in now.

-- Ram
