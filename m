From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: Re: [PATCH v3 2/3] http.c: Use timeout suggested by curl instead of
 fixed 50ms timeout
Date: Fri, 4 Nov 2011 18:55:31 +0100
Message-ID: <CAOs=hRL1vUFRwAGihi3GBmOrRV5mSXzrbx=T94UuHXW6g47JLw@mail.gmail.com>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-3-git-send-email-mika.fischer@zoopnet.de>
 <7vehxndd4q.fsf@alter.siamese.dyndns.org> <CAOs=hRKxc9SdE_HTnfs+WdnxZEY6yF9MBV_K1FX2=7B7xtj7-w@mail.gmail.com>
 <20111104175127.GA26118@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 04 18:56:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMNzj-000312-0T
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 18:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab1KDRzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 13:55:55 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:34931 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab1KDRzy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 13:55:54 -0400
Received: from mail-yw0-f46.google.com (mail-yw0-f46.google.com [209.85.213.46])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 6726C249C2BB
	for <git@vger.kernel.org>; Fri,  4 Nov 2011 18:55:53 +0100 (CET)
Received: by ywf7 with SMTP id 7so2745984ywf.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 10:55:52 -0700 (PDT)
Received: by 10.236.75.167 with SMTP id z27mr22168111yhd.53.1320429352096;
 Fri, 04 Nov 2011 10:55:52 -0700 (PDT)
Received: by 10.236.60.135 with HTTP; Fri, 4 Nov 2011 10:55:31 -0700 (PDT)
In-Reply-To: <20111104175127.GA26118@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184792>

On Fri, Nov 4, 2011 at 18:51, Jeff King <peff@peff.net> wrote:
>> Ah yes, that's good. I would have done it this way in C++, but I
>> wasn't sure whether C99 is OK for git.
>
> C99 is not OK. But this is not C99, as the conditional opens a new
> block.

Oh I see, thanks for clarifying!
