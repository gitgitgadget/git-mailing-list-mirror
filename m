From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH 60/68] prefer memcpy to strcpy
Date: Mon, 28 Sep 2015 09:09:46 +0200
Organization: D03
Message-ID: <87fv1zf29x.fsf@rasmusvillemoes.dk>
References: <20150924210225.GA23624@sigill.intra.peff.net>
	<20150924210818.GE30946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 09:15:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgSeX-0004L5-VT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 09:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbbI1HPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 03:15:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:43650 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbbI1HPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 03:15:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZgSeO-00046o-0d
	for git@vger.kernel.org; Mon, 28 Sep 2015 09:15:04 +0200
Received: from 130.225.20.51 ([130.225.20.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 09:15:03 +0200
Received: from rv by 130.225.20.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 09:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 130.225.20.51
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:mMBbZ57ZIxhsGu1vPEV/yQWYAnI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278712>

On Thu, Sep 24 2015, Jeff King <peff@peff.net> wrote:

> This also eliminates calls to strcpy, which make auditing
> the code base harder.

Maybe may English parser is broken, but this doesn't immediately sound
like what you meant to say. Also, in 29/68 you say "We drop calls to
strcpy, which makes auditing the code base easier." Maybe it's all ok,
since on second reading the first "make" probably refers to the plural
"calls for strcpy", while in the second case "makes" refers to "[the
dropping of] calls to strcpy".

Rasmus
