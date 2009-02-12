From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Thu, 12 Feb 2009 23:24:56 +0100
Message-ID: <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tilo Schwarz <tilo@tilo-schwarz.de>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:26:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXk0s-0004rh-O5
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 23:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976AbZBLWZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 17:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbZBLWY7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 17:24:59 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:47395 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZBLWY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 17:24:59 -0500
Received: by fxm13 with SMTP id 13so2793553fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 14:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RyyQc2xUok5vB0uMmjwL9zaDabwCaXN82PpbgiwqEHI=;
        b=gwlS631CXUAt4GTkKeXhsJ8dcWQKUnBr1oPMwmGec5mKBOW7NatleG/p7B61RyYdKT
         MIUk+9ma3FbeOSgmFDHGvLsRumnz4lXUQuH/WQ+LEJ2pkZKJc82FC+agzLXyLLquVDli
         xr3BovlaowtIzrZH/C/IKV+AGrOSLNaFhVnyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lrwzTXoir5vukFHEb0+w2fuet55SdXyvpiu/nVWJFIZbvcU+HLERSY4svZFQ0vlFtC
         J0P/KbR8JjjVB+O8ZP4wRiiOL9X26HasZjPT/ZDuhJNNS23ulvu39aERUORIyAd4TSpj
         OO+6d2mJEk5zOZM4Dn+5oBWlYZQTps6DngXzc=
Received: by 10.181.149.19 with SMTP id b19mr142070bko.82.1234477497459; Thu, 
	12 Feb 2009 14:24:57 -0800 (PST)
In-Reply-To: <op.uo9di902a8ed4e@dellschleppa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109673>

On Thu, Feb 12, 2009 at 22:48, Tilo Schwarz <tilo@tilo-schwarz.de> wrote:
> One thing came to my mind. When I use 'S' and then 'u' to stage/unstage
> files, it would be nice if I could press a key(maybe 'C') to fire up my
> $EDITOR, enter my commit message, let tig do the commit and find myself back
> into the updated status view. Does this sound reasonable?

Sure, you can achieve this very easily. For example, I have the
following bindings in my ~/.tigrc:

 bind generic + !git commit --amend
 bind generic . !git commit

With tig-0.14, you can also put bindings in your ~/.gitconfig or the
project specific .git/config file using:

 [tig "bind"]
    generic = C !git commit
    generic = w !firefox http://repo.or.cz/w/tig.git?h=%(commit)

The last one uses "browsing state variables". There is more
information about those in tigrc(5)[1]

[1] http://jonas.nitro.dk/tig/tigrc.5.html#_actions

-- 
Jonas Fonseca
