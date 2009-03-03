From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-clone.txt: document that pushing from a shallow clone
 may work
Date: Tue, 03 Mar 2009 12:57:22 +0100
Message-ID: <49AD1B22.6050201@viscovery.net>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com> <1236080017-13987-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: =?UTF-8?B?QWRlb2RhdG8gU2ltw7M=?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:59:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeTH6-0002Le-2p
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbZCCL5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 06:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbZCCL5f
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:57:35 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8218 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbZCCL5f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 06:57:35 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LeTFY-0004UO-Do; Tue, 03 Mar 2009 12:57:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 11E1D6B7; Tue,  3 Mar 2009 12:57:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1236080017-13987-1-git-send-email-dato@net.com.org.es>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112062>

Adeodato Sim=C3=B3 schrieb:
> @@ -133,8 +133,10 @@ then the cloned repository will become corrupt.
>  --depth <depth>::
>  	Create a 'shallow' clone with a history truncated to the
>  	specified number of revisions.  A shallow repository has a
> -	number of limitations (you cannot clone or fetch from
> -	it, nor push from nor into it), but is adequate if you
> +	number of limitations: you cannot clone or fetch from it,
> +	nor push into it; pushing from it into a regular repository
> +	may work correctly in some cases, but it is not guaranteed to
> +	always work.  However, a shallow repository is adequate if you

Consider a reader who wants to decide whether --depth should or can be
used in a git clone invocation. Is the new wording helpful? If you don'=
t
describe those "some cases" in more detail, then we better keep the
current wording.

-- Hannes
