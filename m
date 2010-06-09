From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [RFC/ PATCH 5/5] t7609: test merge and checkout error messages
Date: Wed, 9 Jun 2010 23:10:33 +0200
Message-ID: <AANLkTinw5gC9jCqhEeufwVnK0rZ-bJdx9sgpwEPoBEAw@mail.gmail.com>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-7-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<vpqtypcx7a9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 23:10:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSY4-0003QJ-Rc
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 23:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032Ab0FIVKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 17:10:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62087 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307Ab0FIVKt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 17:10:49 -0400
Received: by fxm8 with SMTP id 8so3882848fxm.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=j5EbirvYnt8xzp8Xv2QxskEt4uxS+9fBIViahp8VNyE=;
        b=RBkPS2TTvoHjpF9o5/Okq97+ui9mKtMtCGdYZY6grr32PqNGyD2q6MsBlsZyXWCQWw
         /J/0b34sLet74oVgdnR/QLvPnvHTMeP4dirNxZ8jTclebrIMTTFJ6H+mVxB6LXhST6ql
         3iGJGHLQb8THv0VUpYR9Nm9iA3Je20olh6KLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=KWZftEpOWddGWozVENlUDeVyFRzTX2br0Ed+vIu4j5WXufMtxG2u63Vqy7bXmbYA27
         o+iWYFQ5FMvL3dQREmoRE6OxsSrleHWskTmZCLytFYa2lImmjlAWfaufowipzsIELGWi
         W/k+1pKIR96nSsSlfHyR1Fk815SpCoW+Zb+5o=
Received: by 10.239.169.199 with SMTP id p7mr1297282hbe.195.1276117848153; 
	Wed, 09 Jun 2010 14:10:48 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Wed, 9 Jun 2010 14:10:33 -0700 (PDT)
In-Reply-To: <vpqtypcx7a9.fsf@bauges.imag.fr>
X-Google-Sender-Auth: YfiQkc1cU2L-s6Xnlb7C5m43L0s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148819>

Le 9 juin 2010 22:47, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =E9=
crit :
> Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:
>
>> +error: Untracked working tree files:
>> + =A0 =A0 five
>> +would be overwritten by merge.
>> +EOF
>
> In my experience, newbies are often confused by this message (typical
> example is students who don't believe me when I tell them not to
> exchange files by email, getting untracked files from their co-worker=
s
> outside Git, and then trying to pull).
>
> Perhaps this deserves an advice like the one we have for modified
> files:
>
>> +error: Your local changes to the files:
>> + =A0 =A0 two
>> + =A0 =A0 three
>> + =A0 =A0 four
>> +would be overwritten by merge.
>> +Please, commit your changes or stash them before you can merge.
>
> (also disabled by advice.commitBeforeMerge)
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>

It seems a good idea, I will introduce that in my next version.
Should the message directly advice that files should not be exchanged
outside of Git and propose a solution for resolving the situation?
