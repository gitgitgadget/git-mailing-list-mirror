From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 15:16:43 -0400
Message-ID: <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>
	 <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:23:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLJX-0005WT-60
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0CRTXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 15:23:19 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:21728 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0CRTXS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:23:18 -0400
Received: by qw-out-2122.google.com with SMTP id 8so453324qwh.37
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5jRSJ8HpqOvfWnNP9ofAy/QhhniAYmtQStDrgg/9/f8=;
        b=o0cbOdPnRTF1wsL29duAHvpSrt8q9Q6wXDTdu/kA4pbcDFSHWezvNarcnTZg6lrfyw
         s115/QG3oh6dgx/exO8hftLOVqdqZL0A1b2iqtuJ8d1wZ9Klsb169uvDJKXot5B+CFdn
         MhVn0N2xJ8n3VjIuwyXK81I0SXpSSHA48DgOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dpz84RH9mi5zhpdjbDLyZOzt9rz/gA6y3zXvQO0G9VgvKS+0ePolFzWRyQS1s6EYMd
         +G/1eHaWilD8C4uI4gZp9REjZdJ3kmZ0I9Uah94+jJrsoike4QPSOSAzLvE+/e8x1eYZ
         kxM45oxwRLk6uizbyXNrROWPtQ/IAIazqI9MY=
Received: by 10.229.190.133 with SMTP id di5mr597693qcb.23.1268939804031; Thu, 
	18 Mar 2010 12:16:44 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142499>

On Thu, Mar 18, 2010 at 3:07 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 18 Mar 2010, Jon Smirl wrote:
>>
>> We could hash people emails and then build a .mailmap equivalent thu=
s
>> hiding their identity.
>
> So? Why? What's the advantage?

I happen to think that the concept of privacy and working on an open
source project are fairly incompatible. But apparently their are
people who think otherwise.  The use would be to reconstruct that
mailmap I made, but with the email addresses replaced with SHA1 hashes
of the email. No human would use the SHA1s, they're just there to
obscure the emails.

>
> I literally _only_ see disadvantages to the whole thing. If the uuid =
has
> some meaning (ie it's related to actual _real_ information), then it =
is
> nothing but a really inconvenient placeholder for the real informatio=
n,
> adn another source of new problems (like "how do we know they are in
> sync? I edit the .gitconfig file by hand all the time").
>
> And if it doesn't have meaning, then it's just annoying and will neve=
r
> ever be attached to anything relevant long-term.
>
> Either way, there are only downsides, no upsides. There is absolutely=
 _no_
> way that teh uuid would ever actually encode any real meaningful
> information that isn't better represented by the name/email.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>



--=20
Jon Smirl
jonsmirl@gmail.com
