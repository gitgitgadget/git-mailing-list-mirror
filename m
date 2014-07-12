From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v6 26/32] checkout: detach if the branch is already
 checked out elsewhere
Date: Sat, 12 Jul 2014 15:21:25 +0300
Message-ID: <20140712122125.GC21237@wheezy.local>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1404891197-18067-27-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 14:21:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5wJJ-0002PY-0M
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 14:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbaGLMVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2014 08:21:45 -0400
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:47084
	"EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750900AbaGLMVo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2014 08:21:44 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-09.prod.phx3.secureserver.net with 
	id RQMc1o0083gsSd601QMekR; Sat, 12 Jul 2014 05:21:40 -0700
Content-Disposition: inline
In-Reply-To: <1404891197-18067-27-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253389>

On Wed, Jul 09, 2014 at 02:33:11PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> +static int check_linked_checkout(struct branch_info *new,
> +				  const char *name, const char *path)
> +{
=2E..
> +	if (!strncmp(start, new->path, end - start) &&
> +	    new->path[end - start] =3D=3D '\0') {

This also detaches if the "holding checkout" is _this_
checkout, that is, when you are checking out the currently
checked our branch.

--=20
Max
