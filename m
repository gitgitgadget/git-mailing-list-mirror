From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 9/9] submodule: teach unpack_trees() to update submodules
Date: Fri, 07 Feb 2014 22:25:52 +0100
Message-ID: <52F54F60.3040103@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com> <52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de> <52EFF3E9.2060403@web.de> <20140203201900.GC16057@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:26:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBsvv-0003qQ-Nd
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbaBGVZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Feb 2014 16:25:55 -0500
Received: from mout.web.de ([212.227.17.11]:52789 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbaBGVZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:25:55 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MSJC3-1Vnun41CHb-00TQqL for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 22:25:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140203201900.GC16057@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:KdYDsRzXWMIxmcPD5CdV/mXhYJh9fwAWimRp81hhdX5783tyO/p
 HNRRBD0Sa21FVsZDJsntf77GgN2GJr5JhLkUqDam82p9L0pRvKm1QbpBsDeTpAo8Iq7w20B
 rM6bzg1Al0jGQI7p7Tz7fqb8HlnV3a+Vr8p8+S9CUICDBG4b9xeyhm++mRWxBS2DvezbA4T
 jAagjpdN+J/f2Nq50miZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241804>

Am 03.02.2014 21:19, schrieb W. Trevor King:
> On Mon, Feb 03, 2014 at 08:54:17PM +0100, Jens Lehmann wrote:
>> Implement the functionality needed to enable work tree manipulating
>> commands so that an changed submodule does not only affect the index=
 but
>> it also updates the work tree of any initialized submodule according=
 to
>> the SHA-1 recorded in the superproject.
>=20
> How about:
>=20
>   =E2=80=A6so that *a* changed submodule ** updates the index and wor=
k tree of
>   any initialized submodule according to the SHA-1 recorded in the
>   superproject.  Before this commit it updated neither; users had to
>   run 'submodule update' to propagate gitlink updates into the
>   submodule.
>=20
> I'm pretty sure that's accurate anyway ;).

And I like it better ;-)
