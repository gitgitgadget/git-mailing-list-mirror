From: Dany <nessup@gmail.com>
Subject: Re: Feature request:
Date: Wed, 3 Jul 2013 16:52:16 -0700
Message-ID: <67824DCD-A486-476D-9A04-D18B083DB090@gmail.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com> <vpqehbgrnrx.fsf@anie.imag.fr> <CADL+T9Z=SrVyMMnYk3M7Dmb4c5xGiQtCTiDYaceKwB2-51TV-g@mail.gmail.com> <7vppuzfrde.fsf@alter.siamese.dyndns.org> <loom.20130704T013747-723@post.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 04 01:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuWqU-0001Md-90
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 01:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab3GCXwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 19:52:18 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:55368 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab3GCXwS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 19:52:18 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so613715pbc.38
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 16:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=oRkmn4QlkfwwUp1bZ0zG7+pihRtnumh2sQLzVg/Od1A=;
        b=YjCRqCto9E3g7sHLGdJcBmqc0C54ATMyfTfYZ2XN4RQv1zgQ8xhGM45NoeTgtNIRjm
         cPhL50sreG6Bhq9iLMGscstD7mtwRKb0puFeGhy8hywwsUcfjH8m3Htnbr4L32JZCHUy
         yRSuM+W1vbFjrihPKd48lIHQpVpVuSRYVp6ZGQ7Cp9RxnZxS8S/Ob1pJw8onPJGJE9No
         JldybAdsxSw1nSgPTV6RjwX0NnNyUKGkpqbUx769UclvQJTpVZKtry3S3cJhM2MZngOg
         xGhWFSiO/BivWPSbkRPy1OEtZ6pGx6y3rNeThhZTiVHMFVjApOOPQnaqtuKF9o5rBpr6
         QUTg==
X-Received: by 10.67.1.68 with SMTP id be4mr4444553pad.161.1372895537579;
        Wed, 03 Jul 2013 16:52:17 -0700 (PDT)
Received: from [192.168.1.20] (c-76-102-3-186.hsd1.ca.comcast.net. [76.102.3.186])
        by mx.google.com with ESMTPSA id ry2sm226796pbc.41.2013.07.03.16.52.16
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 16:52:16 -0700 (PDT)
In-Reply-To: <loom.20130704T013747-723@post.gmane.org>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229549>

Hey Jonathan,

Thanks for the quick reply. I think that's a great message; I do have t=
o say that I wouldn't have known what the `matching` and `simple` modes=
 are without that message; I just had to look it up is all. It may be h=
elpful to tell users that `simple` is probably what they want :)

@DanyJoumaa
1 520 991 5001

On Jul 3, 2013, at 4:46 PM, Jakub Narebski <jnareb@gmail.com> wrote:

> [I'm sorry about breaking Cc: chain - responding via GMane web interf=
ace]
>=20
> Junio C Hamano <gitster <at> pobox.com> writes:
>> Ed Hutchins <eh <at> demeterr.com> writes:
>>=20
>>> I'm not trying to change the way git does things (which works perfe=
ctly
>>> well), I'm asking for some extra information to be added to the com=
mit
>>> so that analysis of the ancestry graph can be tied to the branch to=
pics
>>> that the original author was working from. [...]
> [...]
>> It is not just misleading but is actively wrong to recording the
>> name of the original branch in commits and carrying them forward via
>> rebase. If you want a record of what a group of commits were about,
>> the right time to do so is when you merge.
> [...]
>=20
> There is even git-resurrect.sh script in 'contrib/' that makes
> use of that practice to find merged-in and deleted branches,
> and resurrect them (among other tools).
>=20
> --=20
> Jakub Nar=C4=99bski
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
