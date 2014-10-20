From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] use env_array member of struct child_process
Date: Mon, 20 Oct 2014 02:19:49 -0700
Message-ID: <20141020091949.GB12913@peff.net>
References: <54390DC0.8060302@web.de>
 <20141012015321.GA15272@peff.net>
 <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
 <54439D0C.1070308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:19:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg989-0005Du-MB
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 11:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbaJTJTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2014 05:19:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:60160 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752871AbaJTJTx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 05:19:53 -0400
Received: (qmail 5055 invoked by uid 102); 20 Oct 2014 09:19:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 04:19:53 -0500
Received: (qmail 10435 invoked by uid 107); 20 Oct 2014 09:19:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 05:19:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2014 02:19:49 -0700
Content-Disposition: inline
In-Reply-To: <54439D0C.1070308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 19, 2014 at 01:14:20PM +0200, Ren=C3=A9 Scharfe wrote:

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -726,14 +726,14 @@ static void wt_status_print_changed(struct wt_s=
tatus *s)
>  static void wt_status_print_submodule_summary(struct wt_status *s, i=
nt uncommitted)
>  {
>  	struct child_process sm_summary =3D CHILD_PROCESS_INIT;
> -	struct argv_array env =3D ARGV_ARRAY_INIT;
>  	struct argv_array argv =3D ARGV_ARRAY_INIT;

I don't think it belongs in this patch, but a follow-on 3/2 might be to
give argv the same treatment.

-Peff
