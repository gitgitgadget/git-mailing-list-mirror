From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/4] Support working directory located at root
Date: Tue, 9 Feb 2010 20:19:44 +0100
Message-ID: <201002092019.45134.j6t@kdbg.org>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com> <1265734950-15145-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 20:21:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neve7-0001Yf-IT
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 20:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab0BITVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 14:21:10 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50868 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751651Ab0BITVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 14:21:09 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 785262C4006;
	Tue,  9 Feb 2010 20:21:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2C97119F6B8;
	Tue,  9 Feb 2010 20:19:45 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1265734950-15145-3-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139436>

On Dienstag, 9. Februar 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 wrote:
>  I said I would have code change for DOS drive too. But I take it bac=
k.
>  Supporting GIT_DIR=3DC:\.git might be easy, GIT_DIR=3DC:.git is not.

One does not set GIT_DIR=3DC:.git; it would be insane because it means =
".git in=20
an unpredictable directory somewhere on drive C". It would be great to=20
support GIT_DIR=3DC:/.git

-- Hannes
