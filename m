From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 14:12:06 -0400
Message-ID: <AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
 <AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
 <4D909DD1.2050904@viscovery.net> <AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
 <vpq62r3i1z4.fsf@bauges.imag.fr> <AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
 <vpqr59r6sg5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 28 20:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4GvZ-0005j7-Dx
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 20:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1C1SM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 14:12:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51139 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab1C1SM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 14:12:27 -0400
Received: by ewy4 with SMTP id 4so1262879ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=j1GzjNYH6BKmguCmGNo84Rx25y8Vr4PnPlb9Xkl1la4=;
        b=IH0AmY/NrV5tDrKVfRAKZE8KAuQ8uG12kgPfWNWPK3+sgxt5n8rHXo7YQ6JVwy5ClP
         OU/aJcLwVy5EKlJBefr4b15+R3xt7BMGg5sFIVju217X594oeKJi2LympH77Nmj1Lg4S
         5v8BuY5Uu7d/EAL7hgh/ZJZrFFaMwIGpMrCqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=Xy0ZuhFGFXVemH81DGaCqcaAY6wlLQwa8/RFfzzyIDwPNKfSRe1Pt2BOGY716tx9hH
         FhgGn6KtfE/pED7kuGrO9QJVqFcx+DF7bS/6/HqYA1klSU7/D4tk4aQv35XwtyaKSyHs
         v3G5cgkX6OJmIjhj9PADv7CMDefbE8mOyyJGg=
Received: by 10.213.104.103 with SMTP id n39mr1936816ebo.144.1301335946151;
 Mon, 28 Mar 2011 11:12:26 -0700 (PDT)
Received: by 10.213.105.76 with HTTP; Mon, 28 Mar 2011 11:12:06 -0700 (PDT)
In-Reply-To: <vpqr59r6sg5.fsf@bauges.imag.fr>
X-Google-Sender-Auth: -oVM_OSiQVffdh3mudcT6bkyngk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170171>

On Mon, Mar 28, 2011 at 1:55 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

> Then which commit do you specify as "good"?

Any ancestral commit *on the same branch* which is know to be working.
Isn't the whole point of git bisect is to do binary search through
time? It only makes sense to me to use it on a single branch at a
time. Perhaps you could give a concrete example of where you could use
it for multiple branches simultaneously?
