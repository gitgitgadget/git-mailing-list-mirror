From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool  option
Date: Fri, 30 Oct 2009 16:30:29 +0100
Message-ID: <200910301630.30420.markus.heidelberg@web.de>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com> <3f4fd2640910300425q602471a6v1111a7dceee7746c@mail.gmail.com> <76718490910300817w776bde48j40de31e5532b9fd4@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Charles Bailey <charles@hashpling.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 16:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3tTj-0003pD-Ax
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 16:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbZJ3PdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 11:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbZJ3PdQ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 11:33:16 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:55109 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932452AbZJ3PdQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 11:33:16 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id C1EC0134E9ED7;
	Fri, 30 Oct 2009 16:30:30 +0100 (CET)
Received: from [89.59.69.28] (helo=pluto.fritz.box)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N3tQs-0001sZ-00; Fri, 30 Oct 2009 16:30:30 +0100
User-Agent: KMail/1.9.10
In-Reply-To: <76718490910300817w776bde48j40de31e5532b9fd4@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19IqZIyMSbD/JVAM6APzQaaAj0IGQo9BD6tJ7DP
	YwXc/mAWaxvDm8bunvKhpZXbgu8h6KCokQiOfU5JRtHJup4oMx
	S/hwmxVf/m+QfH88c5IA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131711>

Jay Soffian, 30.10.2009:
> On Fri, Oct 30, 2009 at 7:25 AM, Reece Dunn <msclrhd@googlemail.com> =
wrote:
> > =C2=A03/ =C2=A0try some intelligent guessing
>=20
> This is basically what is already done, but (3) isn't yet platform
> specific in any way

Maybe this can be considered to be implemented. But since it's not
p4merge specific, the p4merge patch should firstly be applied without
the intelligence.
The intelligence may be implemented mergetool agnostic for all at once,
if that is possible?

Markus
