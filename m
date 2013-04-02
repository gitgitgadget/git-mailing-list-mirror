From: Garrett Cooper <yaneurabeya@gmail.com>
Subject: Re: [PATCH 2/5] branch: factor out "upstream is not a branch" error messages
Date: Tue, 2 Apr 2013 12:36:42 -0700
Message-ID: <CAGHfRMDqmQHBrML84iUnh8TE0Lz5EunUB-t9bCASSXOo25i3pQ@mail.gmail.com>
References: <20130402190134.GA17784@sigill.intra.peff.net>
	<20130402190355.GB32316@sigill.intra.peff.net>
	<CAGHfRMC6mRSzdrY-iL3bvCETd5eY4D1-T85zMFcJg5tyNK7ciw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:37:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN719-0003ub-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943Ab3DBTgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:36:44 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56222 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644Ab3DBTgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:36:42 -0400
Received: by mail-ie0-f181.google.com with SMTP id 17so835481iea.40
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ARI0qYFmAqL2K8UDO+/9l2cUkE3Rr7uVN7xgjXRwJ/s=;
        b=w+1lqCkmQXv8g0kqN9ULqYHoErc+fNJZtlSw4q6v3v8M018ntW55OlUt82lWzzR29R
         5SwY2eY7EBKmuc+OP4TVvGbk0mYR1znF5pCO4ihUog+DBbrj1Hh9+vrgU/pc6xvu9bd2
         N26E0IoGiurgi/XhvMbMV0CyLpaYScB5iEuwgVf/n9YNQKZDG8PXS6ZqGKggeJPo4YHi
         KT7nohUdhLbMRkK+2Hk9rgOf9jFp+wS06nJDKIn18a1muspKpxa/K7/tJpEv4thfdV0b
         nVAKXDSm5bqzLdYlrj2YbkZgmzqdlvf8cwzc3xxrWCLDyOUhiJ0oXpN0TpJKSNK05HsD
         AxWQ==
X-Received: by 10.50.36.169 with SMTP id r9mr5676419igj.96.1364931402159; Tue,
 02 Apr 2013 12:36:42 -0700 (PDT)
Received: by 10.64.30.99 with HTTP; Tue, 2 Apr 2013 12:36:42 -0700 (PDT)
In-Reply-To: <CAGHfRMC6mRSzdrY-iL3bvCETd5eY4D1-T85zMFcJg5tyNK7ciw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219863>

On Tue, Apr 2, 2013 at 12:36 PM, Garrett Cooper <yaneurabeya@gmail.com> wrote:
> On Tue, Apr 2, 2013 at 12:03 PM, Jeff King <peff@peff.net> wrote:
>>
>> This message is duplicated, and is quite long. Let's factor
>> it out, which avoids the repetition and the long lines. It
>> will also make future patches easier as we tweak the
>> message.
>>
>> While we're at it, let's also mark it for translation.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>
> LGTM!
>
> Signed-off-by: Garrett Cooper <yaneurabeya@gmail.com>

Sorry, meant...

Reviewed-by: Garrett Cooper <yaneurabeya@gmail.com>
