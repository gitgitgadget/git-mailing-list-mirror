From: Andreas Ericsson <ae@op5.se>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 15:59:19 +0200
Message-ID: <4C9CAEB7.1030606@op5.se>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>	<AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com> <AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, Tait <git.git@t41t.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 15:59:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz8oL-0001bq-FL
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 15:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab0IXN7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 09:59:25 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50313 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753337Ab0IXN7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 09:59:24 -0400
Received: from source ([209.85.215.182]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTJyuupG1pZxkoBkK0of7wemvtR28cPlQ@postini.com; Fri, 24 Sep 2010 06:59:24 PDT
Received: by mail-ey0-f182.google.com with SMTP id 24so1124010eyx.27
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 06:59:22 -0700 (PDT)
Received: by 10.213.47.76 with SMTP id m12mr3072406ebf.43.1285336762416;
        Fri, 24 Sep 2010 06:59:22 -0700 (PDT)
Received: from clix.int.op5.se (fw1-sth-pio.op5.com [109.228.142.130])
        by mx.google.com with ESMTPS id u9sm3122702eeh.23.2010.09.24.06.59.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 06:59:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156989>

On 09/24/2010 03:32 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Fri, Sep 24, 2010 at 13:08, Tor Arntsen<tor@spacetec.no>  wrote:
>> On Fri, Sep 24, 2010 at 14:56, =C6var Arnfj=F6r=F0 Bjarmason<avarab@=
gmail.com>  wrote:
>>
>>> However, I'd like to shift the discussion a bit: Do we want to supp=
ort
>>> the 5.6 line *at all* anymore? I don't think so. As you point out
>>> yourself you can just compile 5.8 or later on these machines.
>>
>> 5.8 as minimum is probably for the best. It's not that just you can
>> compile a newer version (5.8), more importantly, Perl 5.8 is availab=
le
>> as a package from those semi-official 3party repositories for most
>> systems (at least the *nix systems I have access to)
>=20
> Do those repositories also have 5.10 and 5.12?
>=20

=46edora 13 ships with Perl 5.10.0. IIRC, Fedora 12 (or possibly 11)
shipped with Perl 5.8. Let's not ask for more angry users than we
can handle. Since the current code seems to work fine with 5.8 and
later, I think that's a safe minimum to require for full git
functionality. Especially considering it was 3 years since we
decided on 5.6, which was by then 7 years old.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
