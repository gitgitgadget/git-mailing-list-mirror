From: Olivier Croquette <ocroquette@free.fr>
Subject: Re: [PATCH] Copy mergetool "bc3" as "bc4"
Date: Mon, 20 Oct 2014 22:35:51 +0200
Message-ID: <2D3655AD-CC8C-41C2-B0B7-4803176CFB31@free.fr>
References: <1413803017-30489-1-git-send-email-ocroquette@free.fr> <xmqq7fzu4rve.fsf@gitster.dls.corp.google.com> <xmqqtx2y3avx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:36:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgJgS-0002JJ-U1
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 22:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbaJTUgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2014 16:36:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53148 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbaJTUf7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 16:35:59 -0400
Received: from [192.168.1.101] (ipb21a6101.dynamic.kabel-deutschland.de [178.26.97.1])
	by mrelayeu.kundenserver.de (node=mreue006) with ESMTP (Nemesis)
	id 0Lv4go-1Y7IVu3Ry6-010MXC; Mon, 20 Oct 2014 22:35:53 +0200
In-Reply-To: <xmqqtx2y3avx.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V02:K0:7u/kK8CxBu7cOOeF0bmj30vF9qE+sZ4m3E8ri2W2WPV
 tSenk6sQEzWpsHbYeiYG80dtilVORcnlSF1K1DRDOpaSa9I8xP
 NG50pn3whgcQLwT3tjmHt1xpYNpL2AEvcDrRM/bmvN9Qi3M0ZD
 /hfVi+nBl9CNntTqfh+xgXSa6o2c0sPYdGWk30B2vXI+TVzbgY
 fV1Isk/qQHV89bXM9LanthR/8nJgMSmciiD/2hUKAdpCXuFv7i
 BQd/G5ncubMBPInr8Cmmk7ULCtH5Iyg15PZ68TY6BmDPn+wVSx
 +c67eBWpq/m6eCvxMcCdWTb2g7BB7qSuuxPyDMvRKLjqW3Rn/H
 8Mqp34OSmDjdjiXLpAwjFyabycJjxLGCa4O5wG1238ZZ5R+IZr
 3OA96ldwfcVOg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 Oct 2014, at 19:32, Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps something like this, so that existing users can still use
> "bc3" and other people can use "bc" if it bothers them that they
> have to say "3" when the backend driver works with both 3 and 4?

Thanks for the quick and great feedback.
This looks good to me. I used =93bc4" just for consistency sake and to =
preserve backwards compatibility, but introducing =93bc=94 as a generic=
 backend looks indeed as a better approach.
It=92s even future safe, because it doesn=92t prevent introducing bc5 i=
f required later on.

Olivier
