From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3 v2] rev-parse: add test script for "--verify"
Date: Mon, 12 May 2008 07:34:13 +0200
Message-ID: <200805120734.13353.chriscool@tuxfamily.org>
References: <20080512054142.5e524e6f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 07:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvQcR-0000IB-5u
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 07:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbYELF3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2008 01:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbYELF3d
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 01:29:33 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55854 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbYELF3c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2008 01:29:32 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6E1F81AB2C1;
	Mon, 12 May 2008 07:29:31 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4BDB61AB2C0;
	Mon, 12 May 2008 07:29:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080512054142.5e524e6f.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81832>

Le lundi 12 mai 2008, Christian Couder a =E9crit :
>
> 	Junio wrote:
> 	> > +exec </dev/null
> 	> > +. ./test-lib.sh
> 	>
> 	> Who gets stuck by attempting to read from the stdin?  I am wonderi=
ng
> 	> if that belongs to "test-lib.sh"...
>
> 	I copy pasted the setup code from "t6030-bisect-porcelain.sh" and th=
at's
> 	where "exec </dev/null" comes from.
>
> 	I removed it in this new version and added a line to the commit mess=
age.

Ooops, I just saw that you already commited the first version.

Thanks again,
Christian.
