From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] fetch-pack: objects in our alternates are available
 to us
Date: Mon, 14 Mar 2011 18:57:02 -0700
Message-ID: <AANLkTimYBZf72tjAr2s3TTFb3rSZb0_xLhFE4zLtEsN7@mail.gmail.com>
References: <1299876671-12838-1-git-send-email-gitster@pobox.com> <1299876671-12838-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 03:02:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzJaG-00046f-6q
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 03:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab1COCB6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 22:01:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33646 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab1COCB6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 22:01:58 -0400
Received: by vws1 with SMTP id 1so152639vws.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 19:01:57 -0700 (PDT)
Received: by 10.52.67.146 with SMTP id n18mr4672906vdt.232.1300154242172; Mon,
 14 Mar 2011 18:57:22 -0700 (PDT)
Received: by 10.52.169.196 with HTTP; Mon, 14 Mar 2011 18:57:02 -0700 (PDT)
In-Reply-To: <1299876671-12838-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169044>

On Fri, Mar 11, 2011 at 12:51, Junio C Hamano <gitster@pobox.com> wrote=
:
> Use the helper function split from receiving end of "git push" to all=
ow
> the same optimization on the receiving end of "git fetch".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =A0builtin/fetch-pack.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 ++++++++++++
> =A0t/t5501-fetch-push-alternates.sh | =A0 =A02 +-
> =A02 files changed, 13 insertions(+), 1 deletions(-)

I apologize for the slow response; both patches
Acked-by: Shawn O. Pearce <spearce@spearce.org>

--=20
Shawn.
