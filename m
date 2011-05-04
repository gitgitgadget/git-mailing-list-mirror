From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Wed, 4 May 2011 06:58:08 -0400
Message-ID: <BANLkTin0Mi0sOWR5_mYnONW816cVoaXtbA@mail.gmail.com>
References: <20110503090351.GA27862@elie>
	<4DC0608F.9040208@dailyvoid.com>
	<20110503204442.GI1019@elie>
	<7vsjsvgzzf.fsf@alter.siamese.dyndns.org>
	<7vzkn3f5wo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org,
	vmiklos@frugalware.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 12:58:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHZmd-0002sH-Gz
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 12:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab1EDK6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 06:58:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40635 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab1EDK6J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 06:58:09 -0400
Received: by wya21 with SMTP id 21so730874wya.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d7hpCf58PUKetXQWhWv4nSnGAT9VTCJ6B0QQ71NBkpg=;
        b=CrnVkR7B8+lvclgB5BEqBXL4DUivaGEURYlHIOwV5DO8u6av30peQIytVONFoNCyWQ
         jToeWf9YJMvZ2AsRKwxk3WS4OF5waK4QoBbAKjjqa0C0tuIF1tv3Ttw54I2VE7Kh04lS
         vQ7PNUcXUqMlxmpsPrlsjSOQXJrwgrUDHIuew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=prHYH/MILX0F3ldt7ybLPgmEoqS7ozaqXabPTsoPOqCoDUvUK48s0Ji37EsTvcNaqd
         LAc9JBhfmvo30lQtckPJ3AN/p+BNVG0qgNTkX3lFDY+h5GSu2sO7Y7Gwo2lg3FflpmNw
         4KIurJ96hrkACnEnVoBVGATHrUwHDSYkc5oiQ=
Received: by 10.216.255.206 with SMTP id j56mr487690wes.39.1304506688288; Wed,
 04 May 2011 03:58:08 -0700 (PDT)
Received: by 10.216.86.204 with HTTP; Wed, 4 May 2011 03:58:08 -0700 (PDT)
In-Reply-To: <7vzkn3f5wo.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: JeSfDv1If-eSyJa7SqZmEhiXt7o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172738>

On Wed, May 4, 2011 at 12:25 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> I'm starting to suspect it might be simpler to add a new "[merge] n=
o-ff"
>>> configuration item, like the existing "[merge] log".
>>
>> Surely
>>
>> =C2=A0 =C2=A0 =C2=A0 [merge]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log =3D false
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ff =3D false
>>
>> would be a lot simpler and probably far easier to explain.
>
> Yes, it is far simpler and easier to explain. =C2=A0I'll leave the te=
sts and
> the commit log message to people who are more interested in this topi=
c
> than I am ;-)

I like the idea.  I assume it can be overridden on the command line too=
?

-John
