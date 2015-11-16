From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] Add git-grep threads param
Date: Mon, 16 Nov 2015 16:17:31 -0500
Message-ID: <CAPig+cQMV-VJDff=VCeBqRLZC7Q42mu7T78_NK2TWLjEN-=cpw@mail.gmail.com>
References: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA1F@mail.accesssoftek.com>
	<20151116135614.GA13471@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Victor Leschuk <vleschuk@accesssoftek.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"john@keeping.me.uk" <john@keeping.me.uk>,
	Victor Leschuk <vleschuk@gmail.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:17:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyR9d-0008KO-3E
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 22:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbbKPVRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 16:17:33 -0500
Received: from mail-yk0-f193.google.com ([209.85.160.193]:35807 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbbKPVRc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 16:17:32 -0500
Received: by ykba77 with SMTP id a77so26104229ykb.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 13:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W0joD+eyGc/+zQDnOJ5kqpXBuRUarxPLi0LF8WYhaOE=;
        b=vrdOFsjBLS2k0xo4hKI0s/ix17hrEYr54NDWCz/3TofkOGIeXCVBM0271ha+RJSRjV
         uRx0aQxh1LASpUFdKvg2RLGa1mHgVRTbKbbTuwFMdh3ByrYvv1yysvsh0zZ27OiBMR4f
         LSa8X6toZK+zLBINtZqiZxksmYVe50J4O7CFK7ZFGlVkX20NwKZvIcAZX0+L/EbOU5Xl
         2nU3jgJD21USknDja5STtYJQtdbsWEYUvwIkcUrRbJsbjOGfDsuHlzVMgTV2IaNoBUKz
         6e4T1+vSi5YxN2Cg0SjZ/Rb0hhY18bp/G+uIGmLyD7cmNLMOjZ/2Irrvpq4Yl1JTxgYU
         1niA==
X-Received: by 10.13.244.129 with SMTP id d123mr1635338ywf.242.1447708651980;
 Mon, 16 Nov 2015 13:17:31 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 16 Nov 2015 13:17:31 -0800 (PST)
In-Reply-To: <20151116135614.GA13471@sigill.intra.peff.net>
X-Google-Sender-Auth: JCQfIgLZ86Skofwtnsm9lmNg9zI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281357>

On Mon, Nov 16, 2015 at 8:56 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 16, 2015 at 05:11:16AM -0800, Victor Leschuk wrote:
>
>> The earlier version of this patch is already included in /pu branch,
>> however as we all agreed ($gmane/280299) we have changed the default
>> behavior and the meaning of "0". The question is: what is the right
>> way to include changes from patch v6 (this one) into already merged
>> patch to pu?
>
> Merging to "pu" does not really mean anything; it is simply that the
> maintainer has picked it up as a possible topic of interest. Patches can
> (and often are) still re-written in that state.
>
> Junio is on vacation for a few weeks, and I'm acting as maintainer in
> the interim. I've added your v6 to my pile of patches to look at, but I
> haven't gone over it carefully yet.

To be perfectly explicit: Patches in 'pu' get replaced wholesale by
newer versions, so you would simply send the new version of the patch
in its entirety (as you did with v6).
