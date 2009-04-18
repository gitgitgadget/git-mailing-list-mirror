From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: integrating make and git
Date: Sat, 18 Apr 2009 08:03:13 +0100
Message-ID: <efe2b6d70904180003k1ef1afdbi98e21193fb61895@mail.gmail.com>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 09:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv4bw-00044v-Hn
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 09:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbZDRHDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 03:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755208AbZDRHDc
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 03:03:32 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:6335 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbZDRHDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 03:03:31 -0400
Received: by fk-out-0910.google.com with SMTP id 18so534161fkq.5
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4ck/Zs0ywoXhCf8jRgQKB/p76s/3b1SM8cAOW1MYSkY=;
        b=OXCj2bi4RSppptR+gLYVnVqgOVt7AbQGBvJMn5lYnx4ibxovO9Z5OetJOQ8Q8MpU1q
         rpNQOxGN1qkqh6/l8qiR0kkJ3R7cnWWHQeyRHf1Ox0EfinZYLA/n067we+DlAkhqbYNg
         UEo5NuwKU0kcfWAqrMTeHzOc3vZQ2xb07W9l0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HG1jWkjGrQ9RAKjyfAwuBbGeNhu0oM3F0cw+VQK4KfVNNRty0H2bMGBvvS68PoRZ9O
         VMabeY6d2CVPrIEnv7g9h06EScjl2vBtXAnddl8oLMmJL8K7l+tvMdNjhAz7WCdLWmU6
         oPvvaiU75dgpBt7ieOwRd+rwZUUL7xtURLe4A=
Received: by 10.223.122.15 with SMTP id j15mr1006504far.10.1240038208120; Sat, 
	18 Apr 2009 00:03:28 -0700 (PDT)
In-Reply-To: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116814>

This idea sounds very much like vesta (http://www.vestasys.org) -
except that vesta has its
own version control system, rather than using git. It has its own
filesystem (actually a user-mode nfs server). It's GPL, so in theory
you could swipe its filesystem code, or replace its
vcs with git. Don't know how hard that would be, though - doesn't
sound trivial. It's worth looking at vesta for ideas, though, even if
you don't use the code. The owners are fairly responsive on their IRC
channel, too.

Ealdwulf
