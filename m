From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 15:52:07 +0200
Message-ID: <552E6D07.5030903@drmicha.warpmail.net>
References: <552E628C.7040809@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Pirate Praveen <praveen@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 15:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiNjm-0003vS-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 15:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbbDONwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 09:52:14 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41279 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753248AbbDONwN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2015 09:52:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id D6CC320F02
	for <git@vger.kernel.org>; Wed, 15 Apr 2015 09:52:08 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 15 Apr 2015 09:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=nmzFiApb6Rcnms0735he0pQdBP4=; b=Rdaf2C
	BzL33CwvaDkn91fQTB6UkukWvBxAYwKTXob0/xtcRvfPTVpmfiAbm7vV6H0jrHkL
	ULAzcCRXXm3U1NWqdyWZyw5PGlRN7ERXtlEDBCcs61osr8hCkppsF6d+H9hg3G15
	hpxKc7zXmaD4KdMGMMUrA33SvkG7LEeR+3Hpc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=nmzFiApb6Rcnms0
	735he0pQdBP4=; b=Ni+URK8wFCp4zRoKqGYz4I8cXttGqcU94T+xuaA5Jvv2gko
	Kl21tsW8FqEqDqRh+LWlmMPeD86/BD5yh4Qh2PPxChQjbdbHpS53Z6/UT6m48xcg
	2DixoKDriGq4qLD5E6GKbFQu/AA15xHuduylHJKaUPz90x2XU0qKyKlPqh44=
X-Sasl-enc: /flT5Ecqq5HFuhAKyN3hFVtUnn37L5hGWhj98AqcuxKE 1429105928
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 611B768023E;
	Wed, 15 Apr 2015 09:52:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <552E628C.7040809@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267199>

Pirate Praveen venit, vidit, dixit 15.04.2015 15:07:
> Hi,
> 
>  When working with big projects over a slow, unreliable connection,
> currently there is no way to resume a clone or pull when the connection
> breaks. mosh is a better replacement for ssh over unreliable
> connections. supporting git+mosh protocol will go a long way in
> supporting people who work with unreliable, mobile networks, especially
> in developed countries (I personally have to try many times when working
> with large projects as my 3g mobile connection keeps dropping. I
> recently discovered mosh and it works like a charm. More about mosh
> https://mosh.mit.edu/

What would that require git to do, beyond taking whatever you tell it
(using GIT_SSH or _GIT_SSH_COMMAND) to use as a drop in replacement for ssh?

Michael
