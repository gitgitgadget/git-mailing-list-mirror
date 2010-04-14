From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Document ls-files -t as obsolete.
Date: Wed, 14 Apr 2010 16:58:52 +0200
Message-ID: <vpqeiii13o3.fsf@bauges.imag.fr>
References: <1271252704-21739-1-git-send-email-Matthieu.Moy@imag.fr>
	<z2hd2d39d861004140747u5980eeach66b58102cd5ede25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Apr 14 17:03:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O247W-00028Z-FM
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 17:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957Ab0DNPC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 11:02:56 -0400
Received: from imag.imag.fr ([129.88.30.1]:55911 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744Ab0DNPCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 11:02:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o3EEwrjj014423
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Apr 2010 16:58:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O243J-0005JN-31; Wed, 14 Apr 2010 16:58:53 +0200
In-Reply-To: <z2hd2d39d861004140747u5980eeach66b58102cd5ede25@mail.gmail.com> (Tor Arntsen's message of "Wed\, 14 Apr 2010 16\:47\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 14 Apr 2010 16:58:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144882>

Tor Arntsen <tor@spacetec.no> writes:

> Sorry for being stupid and a bit off-topic, but..
>
>> =A0-t::
>> + =A0 =A0 =A0 This feature is deprecated. Authors of scripts should =
use
>> + =A0 =A0 =A0 linkgit:git-status[1] `--porcelain`, [...]
>
> I've always understood 'porcelain' as for users, and 'plumbing' for
> scripts.. so, if the option is meant for scripting (as opposed to
> --short), why wasn't it called --plumbing? There's obviously somethin=
g
> I'm not getting here! -:)

There's prior art ("git annotate --porcelain" at least). I disagree
with the rationale, but --porcelain means "to be used by porcelain
scripts", hence "behave like plubing".

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
