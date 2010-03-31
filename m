From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Import ClearCaase with history?
Date: Thu, 1 Apr 2010 00:13:57 +1200
Message-ID: <p2k2cfc40321003310513tf6adbef1p69ac01c8b1472c59@mail.gmail.com>
References: <1270035189.2785.11.camel@chumley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Hagood <david.hagood@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 14:14:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwwo9-00051L-Nf
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 14:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab0CaMN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 08:13:59 -0400
Received: from mail-pz0-f186.google.com ([209.85.222.186]:48232 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311Ab0CaMN6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 08:13:58 -0400
Received: by pzk16 with SMTP id 16so14342pzk.22
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d8Pui3TPMBrPIHIU0mGb8VQOwAw5944UC8Md0y5sHtk=;
        b=aKQtoEdNhqfWNyWb8hxz7nwbLcbwc/iZUFo0CdznfrCFlvUkZblBxxCEp+/y410Viq
         ew4msXJiZ8rp3OM4YDp74cj0sFEJILIL3w4HPe8plT6UJffqHExY8KDqy8TkGBXBoNFX
         2FpD/eEUpO1bT6z5XxZLJI0FRWY1JdDLoOkko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i2cWOCtHU8jwtfm9S/Chiii8sR84wAT+a45PmVYQSY22jGz/mEGth3Z6wmmaK++Z6O
         DQGqgKyTTu+c+93k1ZybFtNA7PqoaFHhK94ni1T9A1E9fnNhLhIItuuSxFgVnitaP5xQ
         dr5WNBUZsSTnsekpuXBRcbjGjURxJpAy4clrw=
Received: by 10.114.13.5 with HTTP; Wed, 31 Mar 2010 05:13:57 -0700 (PDT)
In-Reply-To: <1270035189.2785.11.camel@chumley>
Received: by 10.114.33.18 with SMTP id g18mr7994520wag.2.1270037637442; Wed, 
	31 Mar 2010 05:13:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143668>

On Wed, Mar 31, 2010 at 11:33 PM, David Hagood <david.hagood@gmail.com>=
 wrote:
> I am trying to drag where I work into a more modern software developm=
ent
> process, but I am getting resistance from one division that has a lar=
ge
> amount of history for some projects in a Clearcase repository. If I
> could show them that we could import all that history into git, it wo=
uld
> go a long way to removing that resistance.
>
> I've seen programs that purport to import Subversion (which is also
> good, as they also are using Subversion for other projects....) but d=
o
> any such programs exist for Clearcase?
>
> I know that, in theory, it would be possible to
> =C2=A0for all checkins to Clearcase
> =C2=A0 =C2=A0 check out of Clearcase
> =C2=A0 =C2=A0 check into git
> =C2=A0done
>
> but that would take an incredibly long time in practice, wouldn't it?

I have no idea whether this is any good, but you might look at:

   http://www.clearvision-cm.com/clearvision-products/clearcase-and-git=
-bridge-cc2git/ash_flypage.tpl.html

I am sceptical that the performance could be anything other than
glacial but I don't have any experience with it...

jon.


>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
