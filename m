From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH v3] Introduce BEL<branch> as shortcut to the tracked 
	branch
Date: Fri, 20 Mar 2009 13:53:20 +0100
Message-ID: <237967ef0903200553v58af40b5sfbfa0bbb1f9d96eb@mail.gmail.com>
References: <200903181448.50706.agruen@suse.de>
	 <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
	 <20090320004029.GX23521@spearce.org>
	 <20090320004450.GY23521@spearce.org>
	 <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
	 <3F6729A7-76FA-43F4-9538-D644B30576D7@wincent.com>
	 <alpine.DEB.1.00.0903201053280.10279@pacific.mpi-cbg.de>
	 <adf1fd3d0903200533s2be08ee7t58a22180b1c886c0@mail.gmail.com>
	 <alpine.DEB.1.00.0903201345190.6865@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 13:54:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkeFR-0000QD-Jk
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 13:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZCTMxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 08:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbZCTMxY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 08:53:24 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:59346 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbZCTMxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 08:53:23 -0400
Received: by ewy9 with SMTP id 9so726115ewy.37
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rcjpGL79qDvsTTsIhHXcbaIxY7qMtQ4UzXMBMPsSINU=;
        b=c2Mrj+k72rKzdGybAsuLMN5jN1BYqtcQQeTXm3AwdjF7LZfYu1WXAZ1Qf1Mlgfmyvz
         FePSk5Wc3ex9/FSVlUL6wXgCHPTGTBMQZGyMo8FyNlhggqYiW+vjIZmLFLOUfhL11A0X
         tYAk3NIRAOrlPsFToGIYoHC6i4s1keb1rzp/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qf9arno5yuiTmea8G/5LCpUiRB+TrDFU23XEn8+ALJC2oGnpcPaSrt8fGDgpADhF98
         OTodkS1Dk2d+NuAlHQhxyO0RFh1wRkP99+IWUmKK93DkAphTNqyL4A81CUFQPHvoE8qi
         n7vqM7Ud0g0BjLe1+eSXhUfgYwuLGOJMJDo9E=
Received: by 10.210.67.4 with SMTP id p4mr2157495eba.50.1237553600497; Fri, 20 
	Mar 2009 05:53:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903201345190.6865@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113953>

2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Fri, 20 Mar 2009, Santi B=C3=A9jar wrote:
>
>> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>
>> > On Fri, 20 Mar 2009, Wincent Colaiuta wrote:
>> >
>> >> El 20/3/2009, a las 10:29, Johannes Schindelin escribi=C3=B3:
>> >>
>> >> >Often, it is quite interesting to inspect the branch tracked by =
a
>> >> >given branch. =C2=A0This patch introduces a nice notation to get=
 at the
>> >> >tracked branch: 'BEL<branch>' can be used to access that tracked
>> >> >branch.
>> >> >
>> >> >A special shortcut 'BEL' refers to the branch tracked by the cur=
rent
>> >> >branch.
>> >> >
>> >> >Suggested by Pasky and Shawn.
>> >>
>> >> What does BEL actually stand for? I read Shawn's suggestion, but =
it's
>> >> not immediately clear to me what "BEL" means.
>> >
>> > It is the ASCII "bell" character, 007 (I always wanted to write th=
at
>> > magic identifier into a patch).
>> >
>> > FWIW you could type it in a regular ANSI terminal using Control-v
>> > Control-g.
>>
>> Can we use branch^{origin} instead? It is longer to type, but uses t=
he
>> same syntax as the ^{tree}, ^{commit}, ^{tag} and you don't have to =
know
>> how to produce the bell character.
>
> I think I addressed that issue already. =C2=A0(Summary: I do not like=
 it)
>
> Let me spell it out if it was not obvious yet: the BEL patch was mean=
t as
> a more or less funny reminder that the issue is not solved and that I=
 need
> help.

Would :%:foo work? I thought about the reserved prefix :/! , but :/!!
isn't reserved so I don't think that would work. And it's pretty
annoying to type too.

--=20
Mikael Magnusson
