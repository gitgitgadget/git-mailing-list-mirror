From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git push refspec to specify tracking branch
Date: Tue, 30 Mar 2010 21:19:41 -0400
Message-ID: <32541b131003301819x2cab23ffu84b65a0b4c553229@mail.gmail.com>
References: <13A69FD9-234A-4E2A-B83F-096DE304FA16@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 03:20:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwmbM-0006Nf-6n
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 03:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab0CaBUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 21:20:05 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32848 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab0CaBUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 21:20:03 -0400
Received: by gwaa18 with SMTP id a18so5073169gwa.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=O6b6Cz3XxtRS3KhqHPD/ghJPdVsuQkLYxbpw76Fikr0=;
        b=T38hK2vH1gP6wztWFo6PaVhE8Mb4rawitVPfJbug8mlK8Gb9q6bCkDewBB+QbF8Kxk
         HcFu6K4rlL4EZKu8tovNC8eNZLDwfFQ03LP7XdGiZK8h/ktnAG5lFTlYp9EGfH8Izf/8
         RlPIqNR/t2hKbecOnX3o90VORWV1Nr7X4ahVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fb1Sujc/rVivqYhsCnBDvJVeSEZe8m/O1uiXo0HBd9ggKRdTV63AS6cjn0PByxbHWc
         awBjEi1HxQfNXg/iJGiNXAFTfkkkSp3YT7Ie3I9w35dR8wxZehAhTKQ3KkNhu7ieh/zx
         R/yNkb0T1Vo3IBK8pmbM9dMleUgvE93SYoQ44=
Received: by 10.150.203.4 with HTTP; Tue, 30 Mar 2010 18:19:41 -0700 (PDT)
In-Reply-To: <13A69FD9-234A-4E2A-B83F-096DE304FA16@sb.org>
Received: by 10.151.25.15 with SMTP id c15mr7114071ybj.267.1269998401091; Tue, 
	30 Mar 2010 18:20:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143632>

On Tue, Mar 30, 2010 at 9:06 PM, Kevin Ballard <kevin@sb.org> wrote:
> Is there any way in a refspec to specify the tracking branch
> corresponding to a local branch? Specifically, I want to be able to
> write some variant of `git push origin +foo` and have it push foo to
> its tracking branch. I can't find any way to do that according to
> the current documentation.

This is probably a stupid suggestion, but since you're only likely to
have a single local branch corresponding to a particular remote
branch, the easiest answer is to rename your local branch to have the
same name :)

Otherwise, what you probably want is:

   git push origin localbranchname:remotebranchname

You can also delete a remote branch:

   git push origin :remotebranchname

Have fun,

Avery
