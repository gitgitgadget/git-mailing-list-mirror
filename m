From: Andreas Ericsson <ae@op5.se>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Sun, 26 Sep 2010 12:09:29 +0200
Message-ID: <4C9F1BD9.2080902@op5.se>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>	<AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>	<AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com>	<4C9CAEB7.1030606@op5.se> <AANLkTimOpyvO+GZsKJPPWktVJTR1khLD2izyCKqNXwvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, Tait <git.git@t41t.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 12:09:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzoB0-0003ET-Tu
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 12:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701Ab0IZKJf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 06:09:35 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33383 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756456Ab0IZKJf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Sep 2010 06:09:35 -0400
Received: from source ([209.85.215.51]) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTJ8b3cGSbZyIn43wKRVzPgGskFIZ/y7B@postini.com; Sun, 26 Sep 2010 03:09:34 PDT
Received: by ewy21 with SMTP id 21so1047495ewy.38
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 03:09:32 -0700 (PDT)
Received: by 10.213.17.7 with SMTP id q7mr4960081eba.23.1285495772804;
        Sun, 26 Sep 2010 03:09:32 -0700 (PDT)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id a48sm6425480eei.6.2010.09.26.03.09.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 03:09:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <AANLkTimOpyvO+GZsKJPPWktVJTR1khLD2izyCKqNXwvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157216>

On 09/24/2010 09:10 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Fri, Sep 24, 2010 at 13:59, Andreas Ericsson<ae@op5.se>  wrote:
>> On 09/24/2010 03:32 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>> On Fri, Sep 24, 2010 at 13:08, Tor Arntsen<tor@spacetec.no>    wrot=
e:
>>>> On Fri, Sep 24, 2010 at 14:56, =C6var Arnfj=F6r=F0 Bjarmason<avara=
b@gmail.com>    wrote:
>>>>
>>>>> However, I'd like to shift the discussion a bit: Do we want to su=
pport
>>>>> the 5.6 line *at all* anymore? I don't think so. As you point out
>>>>> yourself you can just compile 5.8 or later on these machines.
>>>>
>>>> 5.8 as minimum is probably for the best. It's not that just you ca=
n
>>>> compile a newer version (5.8), more importantly, Perl 5.8 is avail=
able
>>>> as a package from those semi-official 3party repositories for most
>>>> systems (at least the *nix systems I have access to)
>>>
>>> Do those repositories also have 5.10 and 5.12?
>>>
>>
>> Fedora 13 ships with Perl 5.10.0. IIRC, Fedora 12 (or possibly 11)
>> shipped with Perl 5.8. Let's not ask for more angry users than we
>> can handle. Since the current code seems to work fine with 5.8 and
>> later, I think that's a safe minimum to require for full git
>> functionality.
>=20
> I didn't mean to suggest we bump to 5.10 now. I just thought I'd ask
> for the record in case we have this discussion again 3-4 years from
> now.
>=20
>> Especially considering it was 3 years since we decided on 5.6, which
>> was by then 7 years old.
>=20
> Do you happen to have a link to that discussion? I can't find it.

I was writing from memory, and I was wrong. Commit messages seems to
point to february 2006 as the "let's be Perl 5.6 compatible" time.

  git log --grep=3D"Perl.*5.6"

might prove useful. 4.5 years then, and not 3. My, how time flies.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
