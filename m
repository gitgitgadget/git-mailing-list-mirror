From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 2/3] ident.c: check explicit identity for name and email 
	separately
Date: Fri, 8 Jan 2010 23:33:16 +0100
Message-ID: <adf1fd3d1001081433g4168ae52w901a1ceceebad043@mail.gmail.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
	 <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
	 <xuu2zl4tfuij.fsf@nowhere.com>
	 <20100106073806.6117@nanako3.lavabit.com>
	 <7v4omz17xz.fsf@alter.siamese.dyndns.org>
	 <xuu28wc9xd42.fsf@nowhere.com>
	 <7vskagh9fg.fsf@alter.siamese.dyndns.org>
	 <7vbph4eg63.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Adam Megacz <adam@megacz.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 23:33:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTNOV-0007zD-Eh
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 23:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab0AHWdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 17:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104Ab0AHWdS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 17:33:18 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:48694 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab0AHWdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 17:33:18 -0500
Received: by fxm25 with SMTP id 25so13087917fxm.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 14:33:16 -0800 (PST)
Received: by 10.102.237.27 with SMTP id k27mr2304064muh.93.1262989996270; Fri, 
	08 Jan 2010 14:33:16 -0800 (PST)
In-Reply-To: <7vbph4eg63.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136484>

On Fri, Jan 8, 2010 at 5:04 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> bb1ae3f (commit: Show committer if automatic, 2008-05-04) added a log=
ic to
> check both name and email were given explicitly by the end user, but =
it
> assumed that fmt_ident() is never called before git_default_user_conf=
ig()
> is called, which was fragile. =A0The former calls setup_ident() and f=
ills
> the "default" name and email, so the check in the config parser would=
 have
> mistakenly said both are given even if only user.name was provided.
>
> Make the logic more robust by keeping track of name and email separat=
ely.
>

It's a good improvement, thanks.

Acked-by: Santi B=E9jar <santi@agolina.net>

Santi
