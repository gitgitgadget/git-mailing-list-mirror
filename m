From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Tue, 7 Apr 2009 13:01:35 +0300
Message-ID: <94a0d4530904070301k62687e2i772637068494ab74@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
	 <200904060117.24810.markus.heidelberg@web.de>
	 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
	 <20090406032457.GA14758@gmail.com>
	 <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
	 <871vs5kjfw.fsf@krank.kagedal.org>
	 <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904061213pabd87aj9db577aaa231945c@mail.gmail.com>
	 <20090406192514.GI20356@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 12:04:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr89i-0001HO-5Y
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 12:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbZDGKBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 06:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbZDGKBj
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 06:01:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:29157 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZDGKBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 06:01:38 -0400
Received: by fg-out-1718.google.com with SMTP id e12so909485fga.17
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jXxfxb3dK32w9Q6m6FWjB37Fz1wKLD0HtG7RPjQu2Z4=;
        b=jwI7KDpJ1bybc0IcrKyV7W8UEfSL8pRT/RoqxKhj5CeRf2JoAv9pGvqX+I4+cv3DuC
         5vuC9nKoZXZGKCj96bthB2S5rTWwQk2//IZ9PueOxC1GHUdXdWja5zVaFv+LpzQDwOK1
         xb6SyRSB+mNNJnS9F9XzKLuN7h8cEn3q+GT1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XM6jdlumE1qzfBt5mRiqgHgsFzQGCKf9HBIFZt7cCqfq7zDNW3xsPuueDZCFPdcrg7
         E/w8B2MrJjcwRLTXSngitXFBwxKrGtGlLU+783rYcQqrPN6Rz19wgdgLg3IIB1EbQDra
         jF/TQ1f25YnL4BQPHmpfsyNW/7Ex53q2R9hvg=
Received: by 10.86.93.17 with SMTP id q17mr8591fgb.75.1239098495910; Tue, 07 
	Apr 2009 03:01:35 -0700 (PDT)
In-Reply-To: <20090406192514.GI20356@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115942>

On Mon, Apr 6, 2009 at 10:25 PM, Bj=C3=B6rn Steinbrink <B.Steinbrink@gm=
x.de> wrote:
> On 2009.04.06 22:13:26 +0300, Felipe Contreras wrote:
>> On Mon, Apr 6, 2009 at 9:30 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> > David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>> >
>> >> What do you mean? This was a suggestion for how git diff should
>> >> work. I fail to see how you would need a WORKTREEANDTHEINDEX ther=
e.
>> >
>> > You are talking only about "git diff". =C2=A0I am talking about th=
e whole git
>> > suite, because you have to worry about how such a proposal would a=
ffect
>> > other parts of the UI.
>>
>> How do currently do you something like this:
>> git diff HEAD^..STAGE
>
> git diff --cached HEAD^
>
> The "hard" (and pretty weird) one would be "git diff STAGE..HEAD^",
> which is:
>
> git diff -R --cached HEAD^

Sorry, that's what I meant.

So it's possible, but completely unintuitive, and different from other
use cases.

--=20
=46elipe Contreras
