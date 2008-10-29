From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 18:22:15 +0800
Message-ID: <49083957.2060702@gmail.com>
References: <49082514.9050405@gmail.com> <49083166.7090804@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 29 11:23:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv8D9-0002vz-3G
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 11:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbYJ2KWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 06:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbYJ2KWV
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 06:22:21 -0400
Received: from ti-out-0910.google.com ([209.85.142.185]:49299 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbYJ2KWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 06:22:21 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1650773tic.23
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DdtodMAcD+YDlp24ZRQckWRjPrPgYkTCciyIf0lLeLg=;
        b=bCT4QNK0i+QBLVVIRcpV0T7p4phsTjztAH7gREXOwdljo4uvK4rSpiah1uDH0MqP32
         6PAGLhaWiuhyJHPrJnv5IlAsElGEmSIWmjmrfdv8Q4G7XCHnYhgQmTgijkjQlYFH+n1O
         Zhk9zZcEUoVoqi0znRDQl9oRLN3EWAKsoGwVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=RPWw4ZZEOPipeN8kLne6Pv9K7NvKf8Z6m1TtYOQ1BjgwLrUtghuUSXyQSLT6KzGKZx
         8KizoAfC10L7r9TULc5xCKqcLI0OPr4aEhPzuUzSVf3qmKdMZgdneeDTfoiWaSISZDYd
         8aamt7D8zgreBDvOfCP2f8v179vsHE1kE158E=
Received: by 10.110.47.17 with SMTP id u17mr5618548tiu.49.1225275738922;
        Wed, 29 Oct 2008 03:22:18 -0700 (PDT)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id a4sm5537210tib.4.2008.10.29.03.22.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 03:22:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <49083166.7090804@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99357>

Andreas Ericsson wrote:
> Liu Yubao wrote:
> 
> Use "git fetch" instead of "git pull" and you won't need the 'my' branch.
> If you use "git pull --rebase" you won't need to bother at all.
> 
Thank you very much, I didn't know the "--rebase" option, now I learn
the 'branch.<name>.rebase' configuration too by "git help pull".

[...snip...]

> 
> I can't understand why you're working so hard for a linear history, but
> perhaps
> that's just an effect of only having leaf developers. I also can't
> understand
You got it exactly, we are leaf developers and make enhancement mostly,
we don't want the upstream branch full of merging commit for many
not so major changes. I remember keeping linear history is recommended
in git's documentation.

> why you'd want to sync with upstream at all if you're just working on a
> single
> feature/bugfix at the time, since you'd probably be better off by just
> completing
> that single feature in your own time and doing "git pull --rebase && git
> push"
> when you're done.
I only sync when I have finished my enhancement, I don't like merging
when pull.

Yes, I'd better use "git pull --rebase", "pull" is a wonderful command:
pull = fetch + merge, pull --rebase = fetch + rebase, wow!
