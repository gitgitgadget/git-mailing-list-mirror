From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-archive and submodules
Date: Fri, 20 Apr 2012 10:11:24 +0200
Message-ID: <4F911A2C.4070306@web.de>
References: <CALKBF2gwVr0rPn0y8=cvwqOsUb7eQPH7EdK5U+gfZMzh=RpiKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?QW5kcsOpIENhcm9u?= <andre.l.caron@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 10:12:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL8wh-0003cD-V7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 10:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab2DTILy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Apr 2012 04:11:54 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:45413 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab2DTILq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 04:11:46 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate05.web.de (Postfix) with ESMTP id AC0F16DE40A4
	for <git@vger.kernel.org>; Fri, 20 Apr 2012 10:11:27 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.174.29]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Lm4TR-1RloFi1rub-00ZdgI; Fri, 20 Apr 2012 10:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CALKBF2gwVr0rPn0y8=cvwqOsUb7eQPH7EdK5U+gfZMzh=RpiKw@mail.gmail.com>
X-Provags-ID: V02:K0:yMk2IDQzOVhtygIIAKazRpR8Jl219+mUbCcDydHg86/
 5LlBIGiN/69eOWojQH8CDfOtft5nK3icwlrbrxUgJROX8/6WTX
 lZjCyuhwLHOtfu/ErF9bDIhh6gFD+wvwQaI0KcLbPk+n9Gpfoz
 SMz3SfThmLNB0cdz5oX1criP37hop0MZY6S33Mwbs/quFJ81vr
 rDYfeckGc5mlnsds35kXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195984>

Am 19.04.2012 22:10, schrieb Andr=C3=A9 Caron:
> Hi,
>=20
> I've recently needed to create a source code archive as part of a
> custom build target.  This repository uses submodules and I need to
> include the submodlule's source code in the archives too.  However,
> git-archive does not have any option to do so.
>=20
> I've taken a quick look at the GMANE mailing list archives and it
> seems this provoked quite a discussion in 2009 and that Lars Hjemli
> even wrote a patch (in several flavors) for archive.c to include
> submodule-aware processing.  The lastest source code at
> `git.kernel.org` does not contain any traces of this patch (or
> submodule aware logic for that matter).  The mailing list archives ar=
e
> not very convenient to browse and I can't figure out what the status
> on this submodule-aware git-archive idea is.  Has this idea been
> completely rejected, or is it still work in progress?

The idea is not rejected, this would be a worthwhile addition. It has
been brought up again last May, but as far as I know it is stalled
since then:
http://comments.gmane.org/gmane.comp.version-control.git/172851
