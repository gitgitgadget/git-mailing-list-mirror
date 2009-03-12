From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Thu, 12 Mar 2009 11:02:08 +0200
Message-ID: <94a0d4530903120202w22f1f8ecwc6b4d22652afc427@mail.gmail.com>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
	 <49773240.7090605@drmicha.warpmail.net>
	 <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com>
	 <49773E48.90302@drmicha.warpmail.net>
	 <20090121161940.GA20702@coredump.intra.peff.net>
	 <alpine.LNX.1.00.0901211237530.19665@iabervon.org>
	 <20090121191219.GD21686@coredump.intra.peff.net>
	 <20090121191408.GA22958@coredump.intra.peff.net>
	 <alpine.LNX.1.00.0901211443140.19665@iabervon.org>
	 <20090121195348.GB3589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhgpR-0001Ti-12
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbZCLJCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 05:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbZCLJCM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:02:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:54986 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZCLJCL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 05:02:11 -0400
Received: by fg-out-1718.google.com with SMTP id 16so86524fgg.17
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G6DhF2308cpqoHAB/WlpseC/bnLDYLfIutYQaPXMfDE=;
        b=Em2mpKMWmklsDD3KJNFM1DQbOI6+6BbfNG1/vrHOdM7SSYkgdKwU1jKkZrEIVL77S3
         U3fOci83xY9zDObjpApTP39QNBd4LtRldwq40LlG/lzKFxdJMWGx7gM59FX2iEovAg3l
         Z8NhJcBMABZZ4Wnb4Yb4l0FaUVVlL+orVT+UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JYDvcbB7/a7GgNMOkKGt+J5/KVQEjpSFnObSNMlvzYS/zLwxQtYhqceLumA8tvD+Rf
         3lEATSv+WR7TCr9UKw2TP3DH1tZJDUdyWoOc+adZF7FTZ7lG/E46WwnsrAvcvIWvh0zq
         v3bRTQ9KZTQ/ETWSNbT+EJabBnNs9ndVI0dyo=
Received: by 10.86.94.11 with SMTP id r11mr6590117fgb.11.1236848528275; Thu, 
	12 Mar 2009 02:02:08 -0700 (PDT)
In-Reply-To: <20090121195348.GB3589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113024>

On Wed, Jan 21, 2009 at 9:53 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 21, 2009 at 02:50:40PM -0500, Daniel Barkalow wrote:
>
>> I think the ideal thing is to keep the symref as a reminder and just=
 give
>> a non-confusing error message instead of a confusing one. E.g.:
>>
>> """
>> $foo is set to mean the tracking branch $foo/bar, which does not exi=
st.
>> Use:
>>
>> =C2=A0 git remote set-default $foo <name>
>>
>> to set a new default branch for $foo.
>> """
>>
>> (And, of course, add that subcommand to remote)
>
> I think that would be reasonable behavior (and probably a special mod=
e
> for set-default to just update from the remote's idea of HEAD).

Nobody is working on this, right?

--=20
=46elipe Contreras
