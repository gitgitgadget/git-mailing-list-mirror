From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 04 Feb 2013 12:47:45 +0000
Message-ID: <1359982065-ner-9588@calvin>
References: <1359901085.24730.11.camel@t520>
	<510F9907.7010107@drmicha.warpmail.net> <1359980045.24730.32.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain
To: Robert Clausecker <fuzxxl@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:48:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2LT4-0003Ty-Kx
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 13:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab3BDMrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 07:47:52 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52854 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab3BDMrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 07:47:51 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so4678100wgb.35
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 04:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:subject:to:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=I5qv6WMb81YH4Affdska9BEQ+3huR7mHKpXmGfQCLO4=;
        b=cOtK8i9MIGMC9MT8ByD0ANxz8llVt8wTG7JNrpHG37JQMjpKNwPiFobyG36p8gYO0F
         Eg29GN7ob1dNgc5tq5lwtkHB69SGFioohagO5RwQAELzohmUAeDV97SXjBJ75asMTohy
         +ltViS5blk7xPWF4zP5h521fCcTlzL2/B5znorDXW6YyeXu+lUnvIPX+bq5N+pUr3CYd
         QaGAgmzpFJS2JGjAK6bbfpqiJoTzzvrxOR0+weP1TubYuMumkEZPfrQolyDugzyXq52n
         kLlMGwkq2IkskVpFyGo6qwM9AL2ZojRhUsooLrwCqWrnztt4QINvQJwlOpvb8q4ffvlm
         7OVw==
X-Received: by 10.194.94.37 with SMTP id cz5mr34987739wjb.49.1359982070570;
        Mon, 04 Feb 2013 04:47:50 -0800 (PST)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id w5sm420060wif.11.2013.02.04.04.47.46
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 04:47:48 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 9A1031B3C92; Mon,  4 Feb 2013 12:47:45 +0000 (UTC)
In-Reply-To: <1359980045.24730.32.camel@t520>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215377>

On Mon, 04 Feb 2013 13:14:05 +0100, Robert Clausecker <fuzxxl@gmail.com> wrote:
> Of course that is a possibility but it does not not feel right and is
> not intuitive. Adding this feature won't cause feature creep but would
> rather add an operation that makes sense in some scenarios and reduces
> the dependencies on other commands that might not be available on other
> platforms (If you care about that).

I'd really like to see your reply to Sitaram's email regarding the many
options that tar has. Sure, just teaching git-archive the equivalent of `|tar
-x' probably isn't feature creep. But why stop there and not add some of the
other options as well? After all, some might be equally useful in a different
situation. So where do you stop? When you've completely merged tar into git?

> Also, this functionality is in full accordance with the Unix principle
> as it is a basic operation ("put tree into files") and not something
> super special.

That's what `git checkout` is for. And I would even argue that it's the better
choice in your situation because it would delete files from /var/www/foo which
you have deleted in your repo. git archive|tar wouldn't do that.
