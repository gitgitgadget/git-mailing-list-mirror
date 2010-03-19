From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 15:56:52 +0100
Message-ID: <40aa078e1003190756h190af29ao472508aaf624efe3@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <m3tyscjt7h.fsf@localhost.localdomain>
	 <b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 16:03:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsdjC-0001rQ-1r
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 16:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab0CSO4y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 10:56:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36521 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab0CSO4y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 10:56:54 -0400
Received: by wyb38 with SMTP id 38so1554196wyb.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mmSXfkzt+flmcxHurXjAIU//CtIM/7BGXjEIX5vsfVw=;
        b=xT2s3P7gWqzmJrRxTy7IuDy7M/5ReS9WQoPmVs7jO+hl5CSeYEo5t/ebcXwVgmQcai
         iv7aO14ZRErSRYzGrJnuRI7T9DmTmRAgDfAaaj7+VJbGhJJQ2Q2BdmuwTrVFfHadMnSK
         BCjUp9kZzWaYhSF4AQoRmUVfCBZYycVB62FjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Ra4cexqi768YpE6G1PX4ItmsrmUOfOpaS8GmIUDcGtUgCRpqv5RnuNF0OUyoUfH3/Y
         UCz54P2q2jthQ2OnjrhavJSfStrfNS0rOYfFND51QMTiyUHlcLRPKvIl2HWHp07mMayj
         /RYGB7zGKic0MOrBB2Mc8rjHhdzbtLHakQBoQ=
Received: by 10.216.174.129 with SMTP id x1mr687018wel.140.1269010612386; Fri, 
	19 Mar 2010 07:56:52 -0700 (PDT)
In-Reply-To: <b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142610>

On Fri, Mar 19, 2010 at 3:40 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Fri, Mar 19, 2010 at 08:08, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> First, the user.name and user.email does not need to be name and ema=
il
>> from some email account. =A0It might be some "canonical name" and
>> "canonical email".
>
> The vast majority of patches come in through email; the git tools
> expect the user.name and user.email to reflect physical email account
> information.

What git tools would that be? The only one I know of that does
anything near assuming that is git send-email, and it only uses
user.email if neither sendemail.from is configured nor --from option
is specified. And even when it does, it prompts the user so it can be
changed if called from a terminal. So I wouldn't say that it assumes
anything about the "physicalness" of user.email, it just uses it's as
the most sane default unless anything else has been specified.

--=20
Erik "kusma" Faye-Lund
