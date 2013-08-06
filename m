From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [PATCH revised] git_mkstemps: add test suite test
Date: Tue, 6 Aug 2013 14:59:22 -0400
Message-ID: <201308061859.r76IxMLl027315@freeze.ariadne.com>
References: <201308061805.r76I51If026086@freeze.ariadne.com> <7vsiymfzuh.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 20:59:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6mTh-00050C-H4
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 20:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab3HFS7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 14:59:25 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:58268
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755765Ab3HFS7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Aug 2013 14:59:25 -0400
Received: from omta07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id 9PQD1m0021GhbT851WzQNm; Tue, 06 Aug 2013 18:59:24 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta07.westchester.pa.mail.comcast.net with comcast
	id 9WzP1m00q1KKtkw3TWzPtN; Tue, 06 Aug 2013 18:59:24 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r76IxNrj027316;
	Tue, 6 Aug 2013 14:59:23 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r76IxMLl027315;
	Tue, 6 Aug 2013 14:59:22 -0400
In-reply-to: <7vsiymfzuh.fsf@alter.siamese.dyndns.org> (gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375815564;
	bh=sM0IULoEalVaBilcZj5P08qpc11gcEV/fGoQKCjf8Y0=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=REhIz8/28b0U2gBbz+T/LWdWOmENCXH0OYx/Y27uH2HkQnL+4qlGceUZz50JnHviM
	 UWVtcKCp6u6Xo/uecq+RfQy5FPM8TeP/GCG53bEmAsrkQ9AepKAWetWjYgZP0FMrgj
	 GYsRTdg2006qv9VxnBcUjc6mkD6tfH2Nkeq550Tlg1xnmgRbKVDdS6NdQOy8N1PuqH
	 5f1LNwXrT9BulKWDabpR7uxRUdGOznqY9rNx/jvmV6VjAxJEqTc9qAhWUb39F4VDjq
	 kOMlDoj3GfPEUn4xC7m+dIPUVsUqDLLr2xzP3obyECBElQAJ8hauuYCLh0jC87U4h1
	 htuZ/XNqHyePw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231776>

> From: Junio C Hamano <gitster@pobox.com>
> 
> Thanks. I thought I've already queued 
> 
> Message-ID: <7vfvuokpr0.fsf@alter.siamese.dyndns.org>
> aka 
> http://article.gmane.org/gmane.comp.version-control.git/231680
> 
> which tests
> 
>     git commit --allow-empty -m message <&-

My mistake...  I've been so intent on revising my repository and
rewriting the patch that I overlooked that you'd done the revision
already.

Dale
