From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Wed, 1 Dec 2010 23:56:21 +0100
Message-ID: <AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
 <1291230820.11917.25.camel@drew-northup.unet.maine.edu> <877hftuvvz.fsf@picasso.cante.net>
 <7vfwuhtafr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 23:56:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNvbU-00033x-CX
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab0LAW4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 17:56:43 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53764 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233Ab0LAW4m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 17:56:42 -0500
Received: by qwb7 with SMTP id 7so7639961qwb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:56:42 -0800 (PST)
Received: by 10.229.28.143 with SMTP id m15mr1253765qcc.264.1291244201966;
 Wed, 01 Dec 2010 14:56:41 -0800 (PST)
Received: by 10.229.105.76 with HTTP; Wed, 1 Dec 2010 14:56:21 -0800 (PST)
In-Reply-To: <7vfwuhtafr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162634>

On Wed, Dec 1, 2010 at 11:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jari Aalto <jari.aalto@cante.net> writes:
>
>> What people appreciate, while learning, is constency. Sticking to on=
e
>> notation is better than giving multiple choices. And the "^" isn't
>> exactly readable, don't you agree?
>>
>> =A0 =A0 HEAD^^^^^^^^
>>
>> Right. How many was there again?
>
> There is no question that you need to really count them, and that is =
why
> we invented HEAD~8 notation in the first place. =A0It however is wron=
g to
> use the above illustration to defend your change that replaces "HEAD^=
"
> with "HEAD~1".
>
> The thing is, you need to name/call the previous one a lot more often=
 than
> you need to call the eighth previous one. =A0The previous one "HEAD~1=
" is
> special because it directly relates to the current commit (it is the =
first
> parent of the current commit) and that is why people often need to ac=
cess
> it.

Additionaly, you must know about the ^ notation. That is the only way
refer to the second parent HEAD^2, for example.

HTH,
Santi
