From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 1 Mar 2011 19:30:41 +0200
Message-ID: <AANLkTikCEoc55WuiRNo6Q=sXqTd_WDfVRb6cnN5bRD=0@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
	<AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	<20110227084317.GB3356@sigill.intra.peff.net>
	<1298820840.19827.69.camel@drew-northup.unet.maine.edu>
	<20110228230311.GA7533@sigill.intra.peff.net>
	<AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
	<vpqaahf9p69.fsf@bauges.imag.fr>
	<AANLkTi=sXLcVJRVH87jXvVwCth+8vGgc7Ha0=XEG0Kx4@mail.gmail.com>
	<1298998965.5247.46.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	David <bouncingcats@gmail.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:30:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuTPP-0005SM-Oq
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 18:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756926Ab1CARao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 12:30:44 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41947 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009Ab1CARan convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 12:30:43 -0500
Received: by wwb22 with SMTP id 22so4736283wwb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h3x89ld+RXxr4C1IccjoUfkEa3LunQJ/yG3FeuL9BKE=;
        b=XpQoWKvGjXgujdxOChCvnGUhsjPkQE5BjR1Hw0wB3wGtWFRyfOMESmjVBNX54FGSVF
         Ffy9Gv56obm3QxQkt8475KTxXzWTc6F10Di+el3PryzYIBfVIDr6ld9CVLV1vjC/xJWF
         Rp5T8CrmgAas7yP2FlwiZZg14RKTPY88f9aAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=osluUv2gKRI8lJ5CcI3uKbyTxVUTHP3hlFzsLBa6p1/rQY6HLGlPJSuWs3wFhHPosn
         N7C+zvqIMYudWarTOb2yRbeECBJPVjE/QcRwac3ylghtvbkhvBkh2pyfpLvYyVo3VK89
         chakGpNQFWhdrFwDDGnoF6Q3HP/ZA9rRLMjKc=
Received: by 10.216.179.133 with SMTP id h5mr3581264wem.69.1299000641265; Tue,
 01 Mar 2011 09:30:41 -0800 (PST)
Received: by 10.216.7.9 with HTTP; Tue, 1 Mar 2011 09:30:41 -0800 (PST)
In-Reply-To: <1298998965.5247.46.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168232>

On 1 March 2011 19:02, Drew Northup <drew.northup@maine.edu> wrote:
>
> On Tue, 2011-03-01 at 11:32 +0200, Alexei Sholik wrote:
>
>> I guess, people who are friendly with git using the word "index"
>> because it's easier to type. But it confuses an unprepared reader. T=
he
>> solution of the problem with confusion must be relevant to these
>> points:
>> =C2=A0- clarify that "index" means the same thing as the "staging ar=
ea" (in
>> man if it isn't there already?)
>
> Alas, this isn't quite true. Blobs are copied to the .git/objects
> directory (which I referred to earlier as an object store without pro=
per
> qualification) with each "git add" action AND are noted in the Index =
at
> the same time. Therefore the Index is quite literally containing
> information about the blobs to be committed without containing the bl=
obs
> themselves. This is why I find any specific equivalence between Index
> and "staging area" distasteful--it is misleading.

There's no reason to make it more confusing by telling all the
implementation details users are not interested in.

Once I add a modified file to index (via 'git add') or even add a new
file, its content is already tracked by git. This is the most relevant
part.

It is not relevant from the user's point of view whether it's already
in .git/objects or not. Once I've staged a file, I can rm it and then
'git checkout' it again to the version that's remembered in the
staging area, i.e. I will not lose it's contents once it's been
staged.

If what you're trying to say is that new users think of the 'staging
area' as some place where the content is stored before a subsequent
commit, there's nothing bad about it. If they will try to find out
about it's concrete location in the fs, they'll eventually find out
about index and its true nature in terms of implementation.

--
Best regards,
Alexei Sholik
