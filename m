From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Tue, 17 Feb 2009 19:17:48 +0900
Message-ID: <20090217191748.6117@nanako3.lavabit.com>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
 <1234578258-48870-1-git-send-email-git@randomhacks.net>
 <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
 <431341160902132117s1696c975mbf20dfbdc65a7df3@mail.gmail.com>
 <8c5c35580902140103o3e5dd091qe2a18ca52b6fe44a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eric Kidd <git@randomhacks.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:20:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZN3X-0004cv-UO
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbZBQKSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbZBQKS3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:18:29 -0500
Received: from karen.lavabit.com ([72.249.41.33]:58582 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbZBQKS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:18:29 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 3DD3911B8E6;
	Tue, 17 Feb 2009 04:18:28 -0600 (CST)
Received: from 1191.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id PCCX6G5EHXW3; Tue, 17 Feb 2009 04:18:28 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=FJ9snrPoj5oXnhuVoM6x+pviFa6gJlp4i9jNHYHHnU5bremgcs5rF3SjSGmvn2HtbXY+fR2xH1tCKY713NDHTX6Yl+Ltgf2p82YUvS/LlpZSQgGLdxs+7IJLGyfyM7zm//bIuJrrmZqFtdZN9GlfrY0F9Tky7p14coYZ5wHYtJM=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <8c5c35580902140103o3e5dd091qe2a18ca52b6fe44a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110351>

Quoting Lars Hjemli <hjemli@gmail.com>:

> I didn't look at the patch, but if the submodule uses a single
> module-name while moving around, the re-cloning problem would by
> solved if the submodule git-dir was stored inside the git-dir of the
> containing repository  (by using the git-file mechanism). Maybe I
> should try to finally implement this...

Is it similar to what was discussed earlier in the thread http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621 (I asked gmane for "submodule relocate")?

I think it is a good idea to resume your relocatable submodule directory design. Junio said he will keep 'next' open during the stabilization period before the release. I think he means that there is no need for you to be waiting.

I noticed that Junio hasn't taken very big changes to git-submodule and I think it is firstly because he doesn't use submodules himself heavily as he said in the past. It is understandable if he feels uneasy to take large changes that can potentially affect its existing users if he hasn't developed enough first-hand experience with the part of the system himself.

Junio doesn't get involved in git-gui discussion very much either, and I think the reason is the same (see http://gitster.livejournal.com/24080.html for example where he says he doesn't usually use GUI tools) but git-gui has Shawn who takes both initiative and responsibility in the area. git-submodule support would benefit from someobody like Shawn who takes an active role in improving it.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
