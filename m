From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: `ab | (cd cd && git apply -)' fails with v2.0.0
Date: Thu, 24 Jul 2014 16:22:49 +0200
Message-ID: <53D116B9.3050809@drmicha.warpmail.net>
References: <20140724142945.iERQ798d%sdaoden@yandex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Steffen Nurpmeso <sdaoden@yandex.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 16:23:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAJvI-0002rZ-LT
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 16:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758983AbaGXOXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 10:23:03 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48732 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758830AbaGXOXC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2014 10:23:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by gateway1.nyi.internal (Postfix) with ESMTP id E4EB822CCE
	for <git@vger.kernel.org>; Thu, 24 Jul 2014 10:22:59 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 24 Jul 2014 10:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=+rxGQAoH0DyvDewmZ4mtYZ
	GmvPA=; b=q8Gr6rRsR6TNdSiCRXgLElXwJ8pKhlktS8pdueX73XlZRaYFsuAfOV
	P4HyPnc096oklbmTY3VZ0UXMCzhep+0Of3asi5ZWYJnjZtjNDEVMd6XdIwkalWNI
	Pl68B7wLFn1BTf1gy7+AUmxKFfcAwLUki66GIh+tkAyRtHt0J5/Do=
X-Sasl-enc: dg6gCoqv/CDNhPaM6J9r2YjgL+bjJv0lNoWPkR8t6usz 1406211778
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A4D02C007B9;
	Thu, 24 Jul 2014 10:22:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140724142945.iERQ798d%sdaoden@yandex.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254159>

Steffen Nurpmeso venit, vidit, dixit 24.07.2014 15:29:
> Hello (again, psssssst, after a long time),
> 
> it happened yesterday that i needed to do
> 
>   $ git diff HEAD:FILE COMMIT:SAME-FILE |
>   > (cd src && git apply -) 
> 
> but found that didn't work with v2.0.0 (silently succeeds?, doing
> nothing).  It works without the subshell and the cd(1); i had to
> use `(cd src && patch -p2)' instead to keep in going.
> Just in case that is not known yet (i've updated my git(1) repo,
> but in the 1466 commits in between nothing sprung into my eye
> regarding apply, and a Gmane search didn't, too).
> No need to Cc: me, please just fix it; thank you.
> Ciao,
> 
> --steffen
> 

Ah little more context would help. Are you diffing files in the subdir
src, or a file at the root which happens to be present in the subdir src
as well?

Michael
