From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] bash-completion: Add non-command git help files to bash-completion
Date: Fri, 15 Aug 2008 14:33:43 -0400
Message-ID: <48A5CC07.2040500@griep.us>
References: <1218816948-7864-1-git-send-email-marcus@griep.us> <7v8wuyb0m7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:35:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU48S-0006q8-OY
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 20:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089AbYHOSdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 14:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756515AbYHOSdt
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 14:33:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:40996 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbYHOSds (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 14:33:48 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1152931wri.5
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=gebftJw+inki0vUgtHJqcbyINZGlxwcbk64anxw5s3c=;
        b=wKQGXjBQ4Ho0l7l60XXXBZRr2TIcF5s6Rh2AtW344eOnl5kCi3iOPdjlZmAJLyVJDT
         mEAbLlONtbo8AUUjJKsg6ZaAJVZpE1iK+yZMA5df9KS8hA+sOBihtj98rXzrAEsQYSR7
         iflCKLljgMKmouA3EMSNcVVE7cA//lLjJAypU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=aFAeOXRLkoJiq4LixIeQldQauW1VHxs2G36kFeHaGv52MHLy/WUJdSzNN01vNBE8+8
         6paOTjt1BWnkFmXWFXfFo2S8Lb+N+76LRduRlIkds4z+aIStT6tpMAIrSBPjSnmjCKYE
         +BTa5BLNS/5SySXorAE1M1vzr12Ahp7yT1oAo=
Received: by 10.90.99.6 with SMTP id w6mr4089940agb.0.1218825227514;
        Fri, 15 Aug 2008 11:33:47 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id g5sm2131066wra.35.2008.08.15.11.33.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 11:33:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7v8wuyb0m7.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92506>

Junio C Hamano wrote:
> Marcus Griep <marcus@griep.us> writes:
>=20
>> Git allows access to the gitattributes man page via `git help attrib=
utes`,
>> but this is not discoverable via the bash-completion mechanism.  Thi=
s
>> patch adds all current non-command man pages to the completion candi=
date
>> list.
>=20
> I really do not think this belongs to completion.  "git help topics"
> perhaps.

I'm not sure I grok what you mean here...  These items are already acce=
ssible
from `git help`, they just aren't discoverable through bash-completion =
without
the patch.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
