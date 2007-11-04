From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add missing inside_work_tree setting in setup_git_directory_gently
Date: Sat, 03 Nov 2007 21:33:40 -0700
Message-ID: <7vir4ivdcr.fsf@gitster.siamese.dyndns.org>
References: <20071103100323.GA25305@laptop> <20071103131806.GA25109@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 05:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoXBa-0007au-0X
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 05:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXKDEdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 00:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXKDEdt
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 00:33:49 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:50709 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXKDEds convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 00:33:48 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A45632F2;
	Sun,  4 Nov 2007 00:34:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 045098F239;
	Sun,  4 Nov 2007 00:34:04 -0400 (EDT)
In-Reply-To: <20071103131806.GA25109@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message
	of "Sat, 3 Nov 2007 20:18:06 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63344>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> When both GIT_DIR and GIT_WORK_TREE are set, and
> setup_git_directory_gently() changes the current working
> directory accordingly, it should also set inside_work_tree =3D 1.
>
> Without this, work_tree handling code in setup_git_directory()
> will be activated. If you stay in root work tree (no prefix),
> it does not harm. It does if you work from a subdirectory though.

Please add automated test script for this, thanks.
