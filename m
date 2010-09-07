From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Tue, 7 Sep 2010 01:17:24 +0100
Message-ID: <AANLkTimq50_suDMu67PSDE0LGJDCLd6TMhJOdSGot+dK@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
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
	<7v8w3etpjr.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1009061942150.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 02:17:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslsS-0004PU-Ej
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 02:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab0IGAR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 20:17:28 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54515 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab0IGAR0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 20:17:26 -0400
Received: by vws3 with SMTP id 3so3730382vws.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FmPKUrl345qsy5C/ThDfWB2ZGl98Z45VnhPYQt5ClAU=;
        b=EOuAmSflyvH3S7Q1J9KvhY+YgckaiGdzwa+wswWYDQYJQoxUoKHZS2nED1nss7yDMn
         TwVw+1IwYE7HNX345mNLDTF12FwCeO7EpO+jAS7vmN4Bx5ZH+whgTC8KLageCfDQo8FZ
         /Hvod4/EMIgItmLIx3LZNzrFUALpJsU8+89NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OU2UwQtZhqS/skYhx8IxYwV1lZ1oOBCrzTXjxmpxmoXCltFmT9UBUbgRfh8AvRUZue
         aspZarBhLl2a+35OS9Gnv+QvDu+AZkM8dBxUtfxTr47/pbgzsOvQqJ3aKdBiWdZlhwxD
         WdcipvoPsILXoX45lctgaLVk+lxaP7/e7KHeg=
Received: by 10.220.128.204 with SMTP id l12mr861883vcs.242.1283818644350;
 Mon, 06 Sep 2010 17:17:24 -0700 (PDT)
Received: by 10.220.75.196 with HTTP; Mon, 6 Sep 2010 17:17:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009061942150.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155651>

On Tue, Sep 7, 2010 at 12:57 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Mon, 6 Sep 2010, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@fluxnic.net> writes:
>>
>> >> * enumerate the list of objects associated with an individual com=
mit by:
>> >> =C2=A0 =C2=A0 i) creating a CUSTOM pack+idx using git pack-object=
s {ref}
>> >> =C2=A0 =C2=A0 ii) *parsing* the idx file using gitdb's FileIndex =
to get the list
>> >> of objects
>> >
>> > That's where you're going so much out of your way to give you trou=
ble.
>> > A simple rev-list would give you that list:
>> >
>> > =C2=A0 =C2=A0 git rev-list --objects <this_commit> --not <this_com=
mit''s_parents>
>> >
>> > That's it.
>>
>> I didn't want to get into this discussion, but where in the above pi=
cture
>> does the usual "want/ack" exchange fit?
>
> Before object enumeration obviously. =C2=A0But I think that Luke has =
enough
> to play with already by only assuming the easy case for now. =C2=A0If=
 Git P2P
> is to be viable, it has to prove itself at least with the easy case
> first.

 :)   yes.  worry about that later.  optimisation.  time to think.
idea earlier (from 2 hours ago) unworkable, thought of another one,
split commit list into multi-level "virtual hierarchical
subdirectories" of say 256 entries each.  can therefore easily trip
down each "subdirectory" which will quickly get you to the right place
where the commits are different, with only a few roundtrips.  sort-of
binary search but 256-way search.  binary search not optimal here
because of multiple network round-trips.  sorry very obtuse will write
up better.

l.
