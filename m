From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 22/28] git-remote-mediawiki: Modify strings for a better coding-style
Date: Mon, 10 Jun 2013 19:30:28 +0200
Message-ID: <vpqa9mxeuvf.fsf@anie.imag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr>
	<vpqk3m2qs2r.fsf@anie.imag.fr>
	<7vhah5kje8.fsf@alter.siamese.dyndns.org>
	<CAETqRCh2OLq=gj-fEGrO1vyQQfTJNAFp_z_Bf0sirbBgRKPrdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:30:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5vU-0000Jr-EY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab3FJRag convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 13:30:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36193 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061Ab3FJRaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:30:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AHUQMq028457
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 19:30:26 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um5vI-00060V-HA; Mon, 10 Jun 2013 19:30:28 +0200
In-Reply-To: <CAETqRCh2OLq=gj-fEGrO1vyQQfTJNAFp_z_Bf0sirbBgRKPrdw@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Mon, 10 Jun 2013
 19:18:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 19:30:26 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227331>

Please, don't top-post. Quote the part of the message you're replying
to, and reply below.

Beno=EEt Person <benoit.person@ensimag.fr> writes:

> Well, I think next step would be to replace all those calls with
> Git.pm `command`, `command_oneline` and `config``which take an array
> of arguments after the "command". In the preview tool we use those bu=
t
> I don't know if we will find the time to clean that up too in
> git-remote-mediawiki :) .

Agreed. run_git was written to avoid having to depend on Git.pm, but no=
w
that we do, we should do it the Git.pm way (although this is not a
high priority for now).

> Don't know though if it's better to mix that with this serie which is
> mainly based on what perlcritic returns.

If you go this way, I'd rather have it on top (i.e. a separate patch
series).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
