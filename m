From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH] gitk: add a checkbox to control the visibility of tags
Date: Wed, 02 Jan 2013 09:03:14 +0100
Message-ID: <50E3E9C2.5040901@poczta.fm>
References: <1354309737-4280-1-git-send-email-stlman@poczta.fm> <7vlidhmc5i.fsf@alter.siamese.dyndns.org> <20130102071701.GG20724@iris.ozlabs.ibm.com> <7vwqvw3v3o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 09:03:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqJIj-00079j-UB
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 09:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab3ABIDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 03:03:13 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.207]:51845 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab3ABIDM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 03:03:12 -0500
Received: from [192.168.0.13] (87-207-152-6.dynamic.chello.pl [87.207.152.6])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Wed,  2 Jan 2013 09:03:06 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120825 Thunderbird/10.0.6
In-Reply-To: <7vwqvw3v3o.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.5
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
	s=biztos; t=1357113788;
	bh=Za+gtoqUtfeg2bXCxNhYnvf4edgexGVkOHcquwDC56o=;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:
	 Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:
	 Content-Transfer-Encoding:X-Interia-Antivirus;
	b=sPxDakwZgy4dXFtTmo+di8qbJ24pFgMq11T2YeRsKBWDeMxet/BHtpdQL7GvP5NcR
	 Sk0JAkxg8+WJ9kr6HipanF/nuhZnmMxoigWdSjo/JcU4vy6TP/4xYHdbVqAHFRKqhG
	 BU+tgXGmFxLA+SvRLAlrUisEKZC4T6ME5WyjgyeU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212501>

W dniu 02.01.2013 08:24, Junio C Hamano pisze:
> Paul Mackerras <paulus@samba.org> writes:
>=20
>> On Sat, Dec 01, 2012 at 06:16:25PM -0800, Junio C Hamano wrote:
>>> =C5=81ukasz Stelmach <stlman@poczta.fm> writes:
>>>
>>>> Enable hiding of tags displayed in the tree as yellow labels.
>>>> If a repository is used together with a system like Gerrit
>>>> there may be quite a lot of tags used to control building
>>>> and there may be hardly any place left for commit subjects.
>>>>
>>>> Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
>>>> ---
>>> ...=20
>> If the concern is the amount of screen real-estate that the tags tak=
e
>> up when there are many of them (which is a reasonable concern), I'd
>> rather just put a single tag icon with "tags..." inside it and arran=
ge
>> to list all the tags in the diff display pane when the user clicks o=
n
>> it.  I think that would be better than not showing the tags at all.
>=20
> Yeah, sounds very sensible.  Thanks.

I am afraid I don't really understand why tags should be listed in the
diff pane only after clicking the "tags" tag (if this is what Junio has
suggested)? How about just putting there another line saying: Tags, nex=
t
to Parent and Chindren and all the stuff?

If something should happen upon user interaction with the tag label a
toolpit would be a better choince FWIW.

--=20
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99=
ska, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziej=
ska.  (c)PP
