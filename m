From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] http-push: Avoid calling setup_git_directory() twice
Date: Wed, 27 Feb 2008 16:50:13 -0800
Message-ID: <7vd4qhnbui.fsf@gitster.siamese.dyndns.org>
References: <cover.1204130175.git.pclouds@gmail.com>
 <20080227163918.GA28071@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:51:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWza-0000Q9-LY
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbYB1Aub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 19:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbYB1Aua
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:50:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbYB1Au3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 19:50:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 333BA27E1;
	Wed, 27 Feb 2008 19:50:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8F506272F; Wed, 27 Feb 2008 19:50:21 -0500 (EST)
In-Reply-To: <20080227163918.GA28071@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message of "Wed, 27 Feb 2008 23:39:18
 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75338>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  http-push.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Calling setup more than once is now an error?  I do not mind the
new restriction but is it documented clearly somewhere?
