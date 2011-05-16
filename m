From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 03/11] sha1_object_info_extended(): hint about objects in
 delta-base cache
Date: Sun, 15 May 2011 17:40:18 -0700
Message-ID: <BANLkTikZKTObbC0ng91_dfPPeCffJcyGtg@mail.gmail.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com> <1305505831-31587-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 02:40:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLlrY-0006qk-HS
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab1EPAkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 20:40:39 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56436 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1EPAkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 20:40:39 -0400
Received: by vxi39 with SMTP id 39so2832743vxi.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 17:40:38 -0700 (PDT)
Received: by 10.52.114.104 with SMTP id jf8mr5342896vdb.193.1305506438145;
 Sun, 15 May 2011 17:40:38 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 17:40:18 -0700 (PDT)
In-Reply-To: <1305505831-31587-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173695>

On Sun, May 15, 2011 at 17:30, Junio C Hamano <gitster@pobox.com> wrote=
:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OI_DBCACHED,
=2E..
> + =A0 =A0 =A0 } else if (in_delta_base_cache(e.p, e.offset)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 oi->whence =3D OI_CACHED;

Did you mean OI_DBCACHED here?

--=20
Shawn.
