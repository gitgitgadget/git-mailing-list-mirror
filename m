From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sun, 25 Jan 2009 23:12:57 +0200
Message-ID: <94a0d4530901251312q4201d51btd806fe860a12afd6@mail.gmail.com>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
	 <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
	 <831vuvfh7t.fsf@kalahari.s2.org>
	 <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
	 <83wscndv57.fsf@kalahari.s2.org>
	 <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com>
	 <alpine.DEB.1.00.0901241438370.13232@racer>
	 <94a0d4530901240604o5ae0d321h17dc6aabeefe9d53@mail.gmail.com>
	 <7vvds3dszy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 22:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRCJG-0003i4-1E
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 22:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbZAYVNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 16:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZAYVNA
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 16:13:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:24374 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbZAYVM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 16:12:59 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3275064fgg.17
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 13:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DHnomcL9KYoksd3d+ctlaQy4F/Fc92Qb1tPpo0SQXBs=;
        b=jxHTV76TXw6dZ4wrvkxfUU7v8l5ZhSjjFfGGklbECIiHuriviho99T8VYpCLkrit0R
         AqpgvNSMOMtzU0rmA3vIDJwKJF98C+cj39vYWHrf44wDd+Q8qo8jp6cWR0RfFE7N6baw
         qmwg+JtTtnv8gHmlemdi4yoK70H3ZkrDxyvPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=foVORbUxMN+bGHeysPCWg8VIdDyEdyG7MmlibBVbMdyCWMdI5QwjoAYALjmAda2ZyI
         XYIvReWv0j+fIrtIJwzj4EfgC7QHJWGqSl3N/QSHN0WzRwv656rhqlyH4rKnjCUA2LkA
         gNGgN4RDFG5zPgACWOaYYHYZPGxLv6w2ElgV0=
Received: by 10.86.79.4 with SMTP id c4mr527823fgb.7.1232917977654; Sun, 25 
	Jan 2009 13:12:57 -0800 (PST)
In-Reply-To: <7vvds3dszy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107105>

On Sun, Jan 25, 2009 at 10:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It's much easier for everyone to just use git config --global than
>> explain how create and edit the .gitconfig file. If this is explained
>> it shouldn't be in the "Telling git your name" section.
>
> I think it is Ok to have, and it probably is helpful to have, a document
> that accompanies the generic manual, "Platform supplement", to explain
> things like "On this platform, what is referred to as $HOME in the generic
> manual is implemented as %HOMEDRIVE%%HOMEPATH%", to cover peculiarities of
> each platform.
>
> But I think it is going backwards to butcher the description in the main
> manual in order to make the platform supplement shorter.  Even Windows is
> not a good enough reason to break the logical ordering of how things
> should be best taught to the readers of the manual, which is not specific
> to a platform.

That's why I think there should be a whole section regarding git
configuration before "Telling git your name".

However, my last proposal was to have both the git config --global
*and* the $HOME/.gitconfig description. Is there any argument against
that?

-- 
Felipe Contreras
