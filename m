From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Mon, 6 Sep 2010 23:33:57 +0100
Message-ID: <AANLkTimxyWOd3MUnbXZS0ZdqEXb8oRCUwHDNtavbCpgJ@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
	<AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
	<4C81A67B.2060400@gmail.com>
	<alpine.LFD.2.00.1009032304560.19366@xanadu.home>
	<4C81DC34.2090800@gmail.com>
	<alpine.LFD.2.00.1009040153280.19366@xanadu.home>
	<AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
	<AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
	<alpine.LFD.2.00.1009042132500.19366@xanadu.home>
	<AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
	<alpine.LFD.2.00.1009051820100.19366@xanadu.home>
	<AANLkTi=CEOj40Sj+zegvX+ry8-y6p7UwsyqdtoHB1d-T@mail.gmail.com>
	<alpine.LFD.2.00.1009061025210.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 00:34:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OskGL-0004MY-HX
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 00:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab0IFWeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 18:34:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40551 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab0IFWd7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 18:33:59 -0400
Received: by vws3 with SMTP id 3so3678976vws.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZUy9zIyoUD2gyswqn+dhOL3ORaMAa97oUsxgFEFdVIE=;
        b=M5yLuDjrnhbtmh8sNvlAsysFhgcJslXN5lPiwUsFwPc0E9Q3S4kmiUon4pa/Yaxyuv
         WqAyOy4IkmGhpQ7w4wZC5LxLkvo6egsAFVszr4c09+z88RUc9ZANfIhvpD0T1iIr1dS0
         rFa5K1jAg97TLzp5Xxa0XUQ79ojtnZ9IbYMek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Mn1yI3W330vdj+BCpLdp8mFPsuBeDZA+hHLWbwjbf4EBA4GRKYsgh6oFUGqnhGwuyX
         slZHHbnhHwQuDm/dhBVaxNpafhDCCMutDMXdajE8mMLd4ayG59QWBpjwnPgzOC/OrV/k
         lF6l/Sn1xKQcBsY5R3igZn7J+LEdPfDQOtW3Y=
Received: by 10.220.126.130 with SMTP id c2mr293313vcs.224.1283812437843; Mon,
 06 Sep 2010 15:33:57 -0700 (PDT)
Received: by 10.220.75.196 with HTTP; Mon, 6 Sep 2010 15:33:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009061025210.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155637>

nicolas, thank you very brief reply (busy for 2 days)

On Mon, Sep 6, 2010 at 5:51 PM, Nicolas Pitre <nico@fluxnic.net> wrote:

>> * to work out how far local deviates from remote along that list of =
commits
>
> That's an operation that only the peer with the most recent commits c=
an
> do, unless you transfer that huge list of commits from above across t=
he
> network.

 i Have A Plan for dealing with that.

> So, on a server (i.e. the peer sending objects) you'd do:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rev-list <refs_that_I_publish> --not <=
refs_that_the_remote_has>

 sadly that involves telling the sender what the recipient has.

>> =C2=A0problem: despite looking through virtually every single builti=
n/*.c
>> file which uses write_sha1_file (which i believe i have correctly
>> identified, from examining git unpack-objects, as being the function
>> which stores actual objects, including their type), i do not see a g=
it
>> command (yet) which performs the reverse operation of "git cat-file"=
=2E
>
> It is 'git hash-object'.

 ah _haa_ - thank you!  ok, so i have to create a pack-object-like
format, putting the object type at the beginning of the format, then
put the contents of "git cat-file" after it.

 so - apologies, will be dealing with some work-related stuff for a
day or so.  thank you for everything so far nicolas.

l.
