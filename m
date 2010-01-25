From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Issues that need to be resolved before 1.7.0-rc1
Date: Mon, 25 Jan 2010 22:17:42 +0100
Message-ID: <201001252217.42501.j6t@kdbg.org>
References: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org> <7vsk9u2g3k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZWKo-00064m-VB
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 22:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab0AYVSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 16:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595Ab0AYVSx
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 16:18:53 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:22147 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750824Ab0AYVSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 16:18:52 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 919CFCDF89;
	Mon, 25 Jan 2010 22:18:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 97BE019F5B2;
	Mon, 25 Jan 2010 22:17:42 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7vsk9u2g3k.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137994>

On Montag, 25. Januar 2010, Junio C Hamano wrote:
> There also is a discussion on //server/share path on msysgit, that wa=
s
> started since 288123f (ignore duplicated slashes in make_relative_pat=
h(),
> 2010-01-21). =A0If that commit _breaks_ use case on msysgit that used=
 to
> work, I think the sanest course of action is to revert it...

IFAICS, this patch is not a regression w.r.t. //server/share paths.

The discussion is about that support of //server/share paths in msysgit=
 is=20
poor in general. For example, it is not possible to

  git clone //server/share/repo.git

with different failure modes depending on whether forward slashes or=20
backslashes are used.

-- Hannes
