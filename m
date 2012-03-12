From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/11] perf improvements past v1.7.10
Date: Mon, 12 Mar 2012 09:09:19 -0700 (PDT)
Message-ID: <m3d38hztqt.fsf@localhost.localdomain>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S77oQ-0003mi-8I
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab2CLQJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:09:23 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54643 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab2CLQJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:09:21 -0400
Received: by wejx9 with SMTP id x9so3386159wej.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=PXNOGCD4wBpyg1loe0nHbrw9Id/UXxZ1KsH0cvAvJxo=;
        b=GSYjzFUeI4OQdu37DUj1OjT1QOj6BnfWZSMCT3WbUMpslfRHGWtUoMyLsnHNlIYb5b
         pyHzNjhExqeDs5JyMLXB1KErkfS3aakdKcrwMaJHnqElB1wMMyocKhFLEKV8Xh4vG/uc
         pDd0zqRPLzsF7E3FqaQY+nSpaWmi3lpliY/Yl0+ZZIAYkJzP6055ikDve5sj7zu9DVXv
         lBFurfNEVxljQ4JSCTojou8nQl4cUc9XUIFtT3bA4D/weYeQanovjtJ7JY6vif7FEv/W
         r9nAQPoyUWEZUQlnamYLYt8CrNA4ykR9p6xJyX7R9Ca8x9VR7p2Gm8LbzBilvYqLYdPq
         ltsw==
Received: by 10.180.87.8 with SMTP id t8mr28193371wiz.15.1331568560137;
        Mon, 12 Mar 2012 09:09:20 -0700 (PDT)
Received: from localhost.localdomain (abvp228.neoplus.adsl.tpnet.pl. [83.8.213.228])
        by mx.google.com with ESMTPS id t20sm59904868wiv.0.2012.03.12.09.09.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 09:09:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2CG9GUk024383;
	Mon, 12 Mar 2012 17:09:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2CG9FIK024380;
	Mon, 12 Mar 2012 17:09:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192889>

Thomas Rast <trast@student.ethz.ch> writes:

> This is what I have collected over a week of playing with the perf
> suite.  There is no rush; I am just sending them out for anyone
> interested.  If you plan on using the perf suite, I would still
> suggest you apply them.
> 
> Aside from the new tests, the main goal is the bisection script.
> [8/11] is fun too.  Try it!  You will have to install GNU R however.
[...]

>   perf/aggregate: optionally include a t-test score

By the way, have you heard about Dumbbench module on CPAN?  It is a
module that attempts to implement reasonably robust benchmarking,
trying to find and discard bad runs (outliers):

  http://search.cpan.org/perldoc?Dumbbench

It might be an easier solution (thanks to wonders of local::lib) than
GNU R statistical package.

[...]
>   perf: implement a test-selection feature
>   perf: add a bisection tool

It looks like those last two (10/11, 11/11) didn't made it to git
mailing list, probably because of anti-spam size limits of email
message on vger.

Do you have a public repository with this branch somewhere?

-- 
Jakub Narebski
