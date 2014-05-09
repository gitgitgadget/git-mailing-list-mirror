From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Thu, 08 May 2014 20:55:47 -0500
Message-ID: <536c35a3507a8_741a161d310cf@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
 <20140509015107.GA9787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 04:06:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiaCv-0000f5-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbaEICGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:06:37 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58230 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbaEICGh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:06:37 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so4047688obc.19
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=nGsKaAr8Qz9uOZnJ03g8MWoQmq0Wm1vPSUrCihpWZXA=;
        b=mDQkAcMySwxlVCKfkI3UpNArwqDVUymGH5yw1JN+lfh6zv/d6bBSIqVM/iYD4JcBlt
         4DBYw5Kh8RWLQUWvxy7JtsnCiZW+jmes9BArOP/rAxSQnLHhi4At54hq8qSPrJY4F9Qw
         Z5zsjQ96Elz6HmgUQ5u/BapRwfp3jNwdGdGIq/Deq0QFSp3RMuSQUhyUzamOgK1W+Vst
         FrvpS7V7peiNjmvp/8vedzWN3eHJBpUV84piSfeHd2D7HrgHzLj15gthsvK7rhZyKd0V
         eAB7VEVhJezL9MEYWe/68MECS7KGhlIc/TCEdV82aOG1Co9VCs0L1bO30D5zFgBisExL
         Ungg==
X-Received: by 10.182.97.1 with SMTP id dw1mr9601040obb.23.1399601196799;
        Thu, 08 May 2014 19:06:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm11064144oeb.3.2014.05.08.19.06.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 19:06:35 -0700 (PDT)
In-Reply-To: <20140509015107.GA9787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248500>

Jeff King wrote:
> On Thu, May 08, 2014 at 07:58:30PM -0500, Felipe Contreras wrote:
> 
> > No activity since 2012, no tests, no chance of ever graduating.
> 
> I don't think "no activity" is an interesting indicator. This tool _is_
> actively maintained, but it has not needed any fixes since 2012. I use
> it for every single "git log" and "git diff" invocation I do via the
> pager.* config.

If this tool is important to you, I'd say you should write tests so that
we (the rest of the world) can verify that it still works properly.

If it does, it might have a chance of graduating to the core, so it
should stay.

> If we are getting rid of contrib/ I would be happy to continue
> maintaining it out-of-tree. But I honestly cannot tell if this thread is
> serious or passive-aggressive posturing.

It is serious.

The purpose of the 'contrib/' area is not clear. The statemens coming
from Junio don't match what is on 'contrib/README'. So we have a huge
variance of quality all over 'contrib/'. Some tools in contrib have
higher quality than what is part of the core (e.g. they have tests,
while git-archimport doesn't).

So this is a serious attempt at making sure we remain consistent through
the core and contrib/.

Personally I would like to see everything in contrib/ have *at least*
some tests and documentation. Otherwise we know what's going to happen;
they are going to rot and nobody will care that the tools don't work any
more, or they won't even know what they do and how to use them.

-- 
Felipe Contreras
