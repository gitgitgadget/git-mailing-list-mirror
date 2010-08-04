From: Alejandro Riveira =?iso-8859-1?q?Fern=E1ndez?= 
	<ariveira@gmail.com>
Subject: Re: Inspecting a corrupt git object
Date: Wed, 4 Aug 2010 09:48:11 +0000 (UTC)
Message-ID: <i3bd0r$g2l$1@dough.gmane.org>
References: <20100804092530.GA30070@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 11:48:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgaaL-0005U5-H0
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 11:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756968Ab0HDJsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 05:48:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:53081 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756266Ab0HDJsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 05:48:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OgaaD-0005Rn-6r
	for git@vger.kernel.org; Wed, 04 Aug 2010 11:48:21 +0200
Received: from 83.42.12.91 ([83.42.12.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 11:48:21 +0200
Received: from ariveira by 83.42.12.91 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 11:48:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 83.42.12.91
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152568>

On Wed, 04 Aug 2010 11:25:30 +0200, Magnus B=C3=A4ck wrote:

[ ... ]
>=20
> From what I gather from the community book and Pro Git, a git object
> file is a deflated representation of the object type as a string, the
> payload size, a null byte, and the payload. Is there a standard tool =
for
> inflating the file back so that I can inspect what the actual differe=
nce
> between these two are? Short of writing a tool utilizing zlib, at lea=
st.

 Maybe

 git cat-file -p <sha1>
=20
 ?

>=20
> Any other ideas why we would see such a difference? Hardware malfunct=
ion
> or memory corruption I guess, but something else? I can supply the
> actual object files if necessary.

Alejandro
