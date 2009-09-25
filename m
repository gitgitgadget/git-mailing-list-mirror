From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: is smarter bisect possible?
Date: Fri, 25 Sep 2009 09:59:33 +0200
Message-ID: <4ABC7865.7010705@viscovery.net>
References: <h9hrv3$cao$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?QXJrYWRpdXN6IE1pxZtraWV3aWN6?= <arekm@maven.pl>
X-From: git-owner@vger.kernel.org Fri Sep 25 09:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr5iT-0003dI-QA
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 09:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbZIYH7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 03:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbZIYH7g
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 03:59:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:45849 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbZIYH7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 03:59:35 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mr5iJ-000237-K7; Fri, 25 Sep 2009 09:59:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 519B09614; Fri, 25 Sep 2009 09:59:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <h9hrv3$cao$1@ger.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129066>

Arkadiusz Mi=C5=9Bkiewicz schrieb:
> I have such problem. Linus kernel tree merged some feature=20
> (94e0fb086fc5663c38bbc0fe86d698be8314f82f) that was developed in .31r=
c9 era.
>=20
> Current Linus kernel tree with that feature merged shows some regress=
ion.=20
> Tree just before that merge doesn't show regression.
>=20
> Now if I start to bisect just that feature (good=20
> b7f21bb2e23b4fec16b448a34889f467465be659, bad=20
> 94e0fb086fc5663c38bbc0fe86d698be8314f82f) then git gets me whole tree=
 back=20
> to .31rc9 era which... doesn't show any problems.
>=20
> This means that only combined current Linus tree and that feature sho=
ws a=20
> problem.

Try this:

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#bisect=
-merges

-- Hannes
