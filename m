From: Pascal Obry <pascal@obry.net>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Thu, 29 Sep 2011 14:03:55 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E845EAB.2060002@obry.net>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7v7h5d2wd3.fsf@alter.siamese.dyndns.org> <CABPQNSae3MU34pRw87CNkEUBbTpE5h9UVT3cqv3iFnWs1wQ5FQ@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 29 14:04:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9FLS-0008Vf-3g
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 14:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab1I2MEA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 08:04:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56406 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab1I2MEA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 08:04:00 -0400
Received: by wwf22 with SMTP id 22so931382wwf.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 05:03:59 -0700 (PDT)
Received: by 10.227.12.15 with SMTP id v15mr10477864wbv.77.1317297838887;
        Thu, 29 Sep 2011 05:03:58 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-56-48.w83-199.abo.wanadoo.fr. [83.199.38.48])
        by mx.google.com with ESMTPS id p2sm2153652wbo.17.2011.09.29.05.03.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 05:03:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <CABPQNSae3MU34pRw87CNkEUBbTpE5h9UVT3cqv3iFnWs1wQ5FQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182393>

Le 13/09/2011 11:46, Erik Faye-Lund a =E9crit :
> On Tue, Sep 13, 2011 at 12:56 AM, Junio C Hamano<gitster@pobox.com>  =
wrote:
>> Junio C Hamano<gitster@pobox.com>  writes:
>>
>>> [Stalled]
>>>
>>> * po/cygwin-backslash (2011-08-05) 2 commits
>>>   - On Cygwin support both UNIX and DOS style path-names
>>>   - git-compat-util: add generic find_last_dir_sep that respects is=
_dir_sep
>>
>> Honestly I lost track of this one. How would we want to proceed on t=
his
>> topic after 1.7.7?
>>
>> Asking help from Windows folks.
>
> I believe Hannes pointed out that there were some work left to be don=
e
> on it ("enable backslash processing in setup.c:prefix_filename()"),
> and I didn't spot a new version after that. He also pointed out that
> enabling backslash processing would cause you to lose the ability to
> escape special characters, but it sounds to me like this is something
> that simply "comes with the territory" of supporting win32-paths in a
> POSIX-ish environment, and is already the governing convention in
> Cygwin. But I'm not an expert on this topic; Cygwin is not something =
I
> usually care much about.

Same here, not expert. I just can say that this at least fixes a real=20
problem and the patches (provided by Theo and I) are going in the right=
=20
direction. They may be some other issues about Windows backslash (my=20
experiences show that there is very entertaining issues with this!) but=
=20
I don't think we should hold those patches except if someone prove them=
=20
to be wrong.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
