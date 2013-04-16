From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 00/13] nd/pretty-formats
Date: Tue, 16 Apr 2013 16:47:02 +0200
Message-ID: <516D6466.1080906@web.de>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com> <1366100702-31745-1-git-send-email-pclouds@gmail.com> <516D57BD.7080208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 16:48:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US7At-0004mq-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 16:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935780Ab3DPOry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 10:47:54 -0400
Received: from mout.web.de ([212.227.15.4]:51541 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935614Ab3DPOry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 10:47:54 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0M6V2p-1UmHoS04eR-00xm4E; Tue, 16 Apr 2013 16:47:03
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516D57BD.7080208@web.de>
X-Provags-ID: V02:K0:GfAD6mgZ/ri8Ppg2k8U3cXAuNUEb8IZRw1NOBZ7HHC1
 5mCcZTAIS03R8T5T9HMj1I4ongSJM35l/qo6Qkc02tdyGjVDrf
 Fp6FhBx4TWaHI10GKWcoAuvoFrtnQDRE5tGjFM6PfZovFt9XTw
 gIpsZxcC3QW8GtOnuDUqM42jcmHsigPkbu5dt1ryIaEQjFd4cO
 EWKfyL82UOQX/PJENsTpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221422>

The short version:
all applied, compiled and test OK.

Possible minor nits from apply:
applying: pretty: support padding placeholders, %< %> and %><
/Users/tb/projects/git/tb.duy/.git/rebase-apply/patch:253: indent with =
spaces.
                             message two$
/Users/tb/projects/git/tb.duy/.git/rebase-apply/patch:254: indent with =
spaces.
                             message one$
/Users/tb/projects/git/tb.duy/.git/rebase-apply/patch:255: indent with =
spaces.
                                 add bar$
/Users/tb/projects/git/tb.duy/.git/rebase-apply/patch:256: indent with =
spaces.
                                 initial$
/Users/tb/projects/git/tb.duy/.git/rebase-apply/patch:292: indent with =
spaces.
              message two               $
warning: squelched 3 whitespace errors
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
And a possible micronit: what happened to that?

On Sun, Mar 31, 2013 at 12:06 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:

> On 30.03.13 10:35, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> [...]
> The short version of a review:
> Would it make sense to leave  reencode_string() as it is,
> and add a new function reencode_string_len()

Hmm.. yeah.

/Torsten
