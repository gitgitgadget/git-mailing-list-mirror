From: Andreas Ericsson <ae@op5.se>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 09:42:44 +0200
Message-ID: <48B50574.6020502@op5.se>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>	<1219664940.9583.42.camel@pmac.infradead.org>	<alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>	<20080826145719.GB5046@coredump.intra.peff.net>	<1219764860.4471.13.camel@gaara.bos.redhat.com>	<1219766398.7107.87.camel@pmac.infradead.org>	<20080826182349.0a1a75e2@hyperion.delvare>	<s5hvdxnlnzi.wl%tiwai@suse.de> <20080826192039.5ffa6eec@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Takashi Iwai <tiwai@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 09:44:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYFhB-00030p-Cs
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 09:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbYH0Hmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 03:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbYH0Hmy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 03:42:54 -0400
Received: from mail.op5.se ([193.201.96.20]:39073 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927AbYH0Hmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 03:42:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9902E1B8004E;
	Wed, 27 Aug 2008 09:47:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BpHvVFAtNQla; Wed, 27 Aug 2008 09:47:32 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.184])
	by mail.op5.se (Postfix) with ESMTP id B87E824B0B25;
	Wed, 27 Aug 2008 09:47:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080826192039.5ffa6eec@hyperion.delvare>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93865>

Jean Delvare wrote:
> On Tue, 26 Aug 2008 18:50:25 +0200, Takashi Iwai wrote:
>> At Tue, 26 Aug 2008 18:23:49 +0200,
>> Jean Delvare wrote:
>>> On Tue, 26 Aug 2008 16:59:58 +0100, David Woodhouse wrote:
>>>> On Tue, 2008-08-26 at 11:34 -0400, Kristian H=F8gsberg wrote:
>>>>> It's pretty normal to see opponents of a decision like this compl=
ain
>>>>> loudly when it lands on their system, whereas the silent majority=
 in
>>>>> favour will be happy to see the change finally implemented but re=
luctant
>>>>> to stir up the discussion again.
>>>>>
>>>>> I don't think new arguments are brought to the discussion, just n=
ew
>>>>> people, who are temporarily inconvened by a change towards sanity=
=2E
>>>> Nice emotive response, especially the subtle but unsubstantiated '=
silent
>>>> majority in favour' bit -- but you forgot the part where you were
>>>> supposed to actually point out a tangible benefit which is achieve=
d by
>>>> breaking compatibility like this.
>>>>
>>>> And no, reducing the size of /usr/bin by a tiny fraction isn't rea=
lly a
>>>> worthwhile benefit -- in reality, the 'silent majority' really cou=
ldn't
>>>> give a monkey's left testicle about that, and breakage caused by t=
he
>>>> gratuitous change _far_ outweighs any minuscule improvement.
>>> Reducing /usr/bin in size was totally worthwhile. Maybe not to you,=
 but
>>> to the silent majority I am a proud member of, it was. (I'm not say=
ing
>>> that the path that was taken to get there was optimal, just that th=
e
>>> goal was sound.)
>>>
>>> I just can't think of any other tool which installs over 100 binari=
es
>>> (or scripts, that's the same) in /usr/bin. Can you?
>> netpbm has almost 300 in /usr/bin.
>=20
> Ouch. (I guess I shouldn't have asked.)
>=20
> Does netpbm do anything convert (ImageMagick) doesn't? I'd be happy t=
o
> get rid of netpbm.
>=20

netpbm-progs (the rpm containing all the 320 programs in /usr/bin) is
required for xmlto to function properly, which in turn is necessary
to build the git documentation.

This is on Fedora 9, btw.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
