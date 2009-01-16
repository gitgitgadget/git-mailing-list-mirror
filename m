From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Fri, 16 Jan 2009 10:02:33 +0100
Message-ID: <adf1fd3d0901160102y32a08e26q96728495fc0b6fcf@mail.gmail.com>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
	 <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>
	 <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
	 <8763khtbfc.fsf@iki.fi>
	 <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>
	 <7vmydstoys.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901151940170.3586@pacific.mpi-cbg.de>
	 <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>
	 <alpine.DEB.1.00.0901160253210.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 10:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNkcR-0004Ba-Da
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 10:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759859AbZAPJCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 04:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758475AbZAPJCh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 04:02:37 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:61053 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531AbZAPJCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 04:02:35 -0500
Received: by bwz14 with SMTP id 14so4655841bwz.13
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 01:02:33 -0800 (PST)
Received: by 10.103.92.10 with SMTP id u10mr1107539mul.22.1232096553218; Fri, 
	16 Jan 2009 01:02:33 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901160253210.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105929>

 2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Fri, 16 Jan 2009, Santi B=E9jar wrote:
>
>> If everything works as I think (it's late night :-) with the above t=
wo lines:
>>
>> matrix[a,b,c]
>> matrix{d,b,c}
>>
>> the word diff would be
>>
>> matrix<RED>[<GREEN>{<RED>a<GREEN>d<RESET>,b,c<RED>]<GREEN>}<RED>
>
> So I guess that you want something like
>
>        [A-Za-z0-9]+|[^A-Za-z0-9 \t]+
>
> Note: I only want to help you finding what you actually want, I am no=
t
> trying to find it for you.
>

Thanks all for the answers.

So, I see, it is a matter of finding the right regexp.

But the only use case for me is of this kind, and I think for the
others too. So maybe an easier way to specify it could be worth. But
I'll write an alias as this is the only regexp I would use, apart from
the default word diff.

Thanks,
Santi
