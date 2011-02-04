From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Fri, 04 Feb 2011 02:49:32 -0800 (PST)
Message-ID: <m3r5bo848w.fsf@localhost.localdomain>
References: <20110202022909.30644.qmail@science.horizon.com>
	<alpine.LFD.2.00.1102030036420.12104@xanadu.home>
	<AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
	<AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com>
	<87bp2sy2mf.fsf@catnip.gol.com>
	<AANLkTinQ13b9c1=SmMSC5ThjXcsSuMO2irwW04E+K=xY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Eugene Sajine <euguess@gmail.com>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Feb 04 11:50:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlJEo-00077W-QJ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 11:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948Ab1BDKtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 05:49:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43377 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1BDKte convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 05:49:34 -0500
Received: by fxm20 with SMTP id 20so2249818fxm.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 02:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=S924GDrPZkkFJN61KdnGIdOLDzuh/wyi1m0xkiWyL4c=;
        b=RNpl6exqVW2ym5N2dJAfSlUskitDRKaGd+QfRRQgnD93/1luwuyuw7feOquBQIqC0p
         E5Atv5ApG3UNnrqpVh7YLOk5FbWsq3sgcZmFNOVfN9UhDlk71uFdBAh7lEXNNVzh1XYY
         3VipAI091q0c9oMVGojDkqsKveA/zuuV54TkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=NiufwHcQkdGS4XTl22766+vNApppDyxdkeQGDhmP/WwWIxVoITqz6s5Tj5+Xmbjm6k
         eEuQZsjbwK3UbuqY/MB0V0uMD/BHGg0+ASXki2gcz6izeKXNBoQX5u8592YezDtQKX+p
         +0UcFZtqkK3GAwNNSmaeTBmOEBrylmCMu1Iss=
Received: by 10.223.103.16 with SMTP id i16mr2016095fao.40.1296816573397;
        Fri, 04 Feb 2011 02:49:33 -0800 (PST)
Received: from localhost.localdomain (abvp12.neoplus.adsl.tpnet.pl [83.8.213.12])
        by mx.google.com with ESMTPS id j12sm159358fax.33.2011.02.04.02.49.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Feb 2011 02:49:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p14AnLGV002398;
	Fri, 4 Feb 2011 11:49:31 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p14AmVee002360;
	Fri, 4 Feb 2011 11:48:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinQ13b9c1=SmMSC5ThjXcsSuMO2irwW04E+K=xY@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166035>

Tor Arntsen <tor@spacetec.no> writes:
> On Fri, Feb 4, 2011 at 03:06, Miles Bader <miles@gnu.org> wrote:
> > Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>>
>>> Quite frankly, I'm surprised there are (presumably experienced)
>>> developers who do not immediately see the value of a little
>>> organization. Surely, given the use of code conventions, formatting
>>> rules, etcetera, the obvious one step further is to also organize
>>> where the files go?
>>
>> I think one of the problems is that what's been suggested seems like
>> window-dressing. =A0Moving everything into src/ and calling it "orga=
nized"
>> doesn't actually accomplish much other than perhaps making the READM=
E
>> file more visible to newbs; things are _still_ a mess, just a mess w=
ith
>> four more letters...
>=20
> What Miles says is my feeling as well. And having a 'bin/' as was sug=
gested
> in one post doesn't make much sense to me either - if you want your c=
ompiled
> output to go elsewhere than the source directory then the normal way =
of doing
> that is to do and out-of-tree build (so if that's not working - I hav=
e
> not checked - then that's something which would be worth looking into=
=2E)

It is about supporting 'srcdir', isn't it?

BTW. what about using 'lib/' directory?
--=20
Jakub Narebski
Poland
ShadeHawk on #git
