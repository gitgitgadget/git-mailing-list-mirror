From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Tue, 4 Sep 2012 13:22:18 +0200
Message-ID: <CANGUGtChELcXe08JtrJW=rt48xOSSeEd9tCgcJvtHiKaX5GCMQ@mail.gmail.com>
References: <5040C59A.6090303@gmail.com>
	<50412E2D.7070503@kdbg.org>
	<5041BC94.7000304@gmail.com>
	<504214AA.9080706@kdbg.org>
	<50425F8B.5020406@gmail.com>
	<7voblognny.fsf@alter.siamese.dyndns.org>
	<5044D162.1010608@gmail.com>
	<7voblmeua3.fsf@alter.siamese.dyndns.org>
	<CANGUGtBk7DME4pkhJhcYoaM-q_S+i9_6u_Ku-9N6D41Mx50ghg@mail.gmail.com>
	<7v4nneduvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8rD9-0003FV-BS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 13:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792Ab2IDLWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 07:22:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64222 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778Ab2IDLWT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 07:22:19 -0400
Received: by eaac11 with SMTP id c11so1900937eaa.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nLo4iTII8Ta2rkmf4/+eVe4rJqiTQnwViBEE0SYeKNs=;
        b=MC30UhUc3fFlUyGFVKpoEZu0R0AV6H2PwoalG+Iw3EeIJ0aC2TiMCCGGo+SRd/8ESz
         fY+j6uDmelQXDxdfM255MWf/jftq8Dv4CWuSOZkVmGOJ7CeZgZsZmrPwzSwFmsPXMYpt
         QV2+55uuEIgDsN0v9ow0qvIiypddx5HxFbgxrrAUm4sbZPxtdwflbW0dWY/MBzFAHUlN
         REeR8z8tic3BtLu/fhWk/+ifSIHFhvRJaXCj0IC4AO+hezvCqXwhRkJRrG2Fd6SanP2p
         o10l8lvi2cBF4U2Rm+dt/0GPTeGBL7gqoUT8R0chn/wiAw9rSwD7lilODdmKljvjEzr6
         TKwg==
Received: by 10.14.198.65 with SMTP id u41mr25923545een.22.1346757738569; Tue,
 04 Sep 2012 04:22:18 -0700 (PDT)
Received: by 10.14.68.129 with HTTP; Tue, 4 Sep 2012 04:22:18 -0700 (PDT)
In-Reply-To: <7v4nneduvj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204736>

2012/9/4 Junio C Hamano <gitster@pobox.com>:
> Marco Stornelli <marco.stornelli@gmail.com> writes:
>
>> I don't have thunderbird now but actually it's really simple:
>>
>> Subject:
>> To:
>> Cc:
>> $SEP
>
> The above is not a very useful "example" to advance this discussion,
> I have to say.  For one, where is your Oggetto?

1) Where is your Oggetto?
I used english template simply because the question was about position
of each statement, but with translation the positions are the same.

2) Are these fields the only ones you will ever see?
No, the template is dynamic according to the settings of plug-in
"external editor". You can have
Subject, To, Cc, Ccn, In reply to, discussion group (please see
external editor for details).

3)  Are they always empty?
Yes. If they are empty, nothing happens actually. I mean, if you have
the field Cc: empty, in the message composition
Thunderbird will use an empty Cc: line, but no problem in sending.

>
> I would expect, at least when you are responding to an existing
> message, some of them are filled already (and if so, I think appp.sh
> wants to know exactly how, for example, has RFC2047 quoting already
> applied, or are we supposed to write in UTF-8 and let Thunderbird
> massage the contents when we give the file back to it?), and also
> there would appear In-Reply-To: field already filled (possibly there
> may be References: as well).

Message reply is out of scope of my patch. The goal here is send a
patch, so the execution flow is to open a new message,
clik on external editor (configured properly), select patch file and
send. It was the scope of the old script and it is the scope of my
patch. Usually you don't send a patch as reply, however even if you
want to send patch as proof-of-concept as reply, there is no
problem, you can copy&paste the patch body. The script, instead, is
very useful to load all patch info, pre-formatting it and filling with
all To: and Cc. So IMHO the in-reply-to case is simply overkilling for
this script. In addition, I think all this discussion is overkilling
for a simple script like that, if a thing can be improved ok I agree
to improve it, but what are we talking about? About a little script
that is only an external utility for this project, not a core
functionality.

Marco
