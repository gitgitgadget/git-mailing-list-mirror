From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Wed, 2 Mar 2011 08:17:38 +0100
Message-ID: <AANLkTi=+iBR3OBZ=4fi_g=JMQKi=47F47hRsWxK=RbMv@mail.gmail.com>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
	<AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
	<7v7hckje4n.fsf@alter.siamese.dyndns.org>
	<20110301205424.GA18793@sigill.intra.peff.net>
	<7vwrkiccy6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 08:17:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PugJd-0003dA-1v
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 08:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918Ab1CBHRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 02:17:40 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59224 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1CBHRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 02:17:39 -0500
Received: by iyb26 with SMTP id 26so4657874iyb.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 23:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/cs8aM1M7wsWxxqrh2BGlaRXvmPdpgQ04V854Lc1hkc=;
        b=cZOXUL8vXhJvYt2F6pzzL/PwNa5L+xEYMTrQqgYZXsj2xeJCJ6xKTS+L05aBZajMwK
         Z8XnfxDVydHUj3zoK2cYDabpdGhYXbbAaG3lU5ZXH3fsmzIVdSLLqKa1yxAort3f2QVu
         pfk4cRQe3WUnD4yI92cnSGP6dzCIWtrt1jDkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wkQH0xTVRyMIj/jGFGHEgPhXnLxhxyy2UF/0wDltAapBmQlK/QQyssqZ+ndT85lBgb
         GTD2YlemAmUSPTIJMux2tj0vkMAIsSGPTGgMasdgqCPzzGFsh9NdVo0vLcCztipjPVgW
         LV++8WinYeMppuYiWJPHOGqewI5XD0Bz6q1ko=
Received: by 10.42.243.5 with SMTP id lk5mr1384226icb.282.1299050259009; Tue,
 01 Mar 2011 23:17:39 -0800 (PST)
Received: by 10.42.232.204 with HTTP; Tue, 1 Mar 2011 23:17:38 -0800 (PST)
In-Reply-To: <7vwrkiccy6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168297>

On Wed, Mar 2, 2011 at 6:24 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jeff King <peff@peff.net> writes:
>> =A0 - Nit: you nicely use "%d commit%s" to handle the single/plural =
case
>> =A0 =A0 in the warning message, but then you "them" later on. It nee=
ds
>> =A0 =A0 (1 < lost) ? "them" : "it".
>
> I actually don't like playing games like that, especially when i18n t=
opic
> is in flight. =A0Among the languages I know rules reasonably well, tw=
o has
> the rule that a countable noun is spelled differently depending on th=
e
> number of that thing is one or more, and one spells the noun the same=
 way
> regardless of the number. =A0Who knows if git needs to be translated =
into a
> language whose noun changes its shape three-way, depending on the num=
ber
> being one, two, or more?

=46or gettex this is described at
http://www.gnu.org/software/gettext/manual/gettext.html#Plural-forms

Don't know how it's handled in shell scripts or perl or whatever other
language (which does not use gettext?)


--=20
Piotrek
