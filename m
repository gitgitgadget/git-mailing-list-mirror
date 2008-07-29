From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Hackontest ideas?
Date: Mon, 28 Jul 2008 17:34:50 -0700
Message-ID: <905315640807281734r74d47b53oe797e4ef8193af00@mail.gmail.com>
References: <20080729000103.GH32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:35:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNdBy-0001sb-P8
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 02:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbYG2Aey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 20:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbYG2Aex
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 20:34:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:46643 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbYG2Aew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 20:34:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1606619nfc.21
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=cLfC3HTtTveiHWFi8PzTHufnjFKr8Uzf4wyDqgwodVM=;
        b=IeRBajykZdheqafTXa2HmC3RvmS+aJYWnABkFOtdrJUoZlBrwBf0WmLVn02LMgq4k1
         iWOkIt3rBTn8mL8X/kxjkhLCLz/9Gp0foshdC/Nz3DPVe1MBPIWLIUI9QI8tuTQnr1Te
         HoQlYYR7vZQyaIXuB+qlNbof2N3C6LaYO1Xl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=u0aeJJKZ2CXSRnp6s5ilNs1R7BZzcKacPN8D+xlNaSH3t5ITuAjAozhQePl/TpH0DL
         S8OoN80j8VxOJ39x9oBXDP07h7jFm0IsBe90P070CT5TDME0blHe38D+ZPjRPj8ydBHJ
         EkHsbesggw/7T55ZOs6SiN7pMSxASc+QpAWc4=
Received: by 10.210.66.1 with SMTP id o1mr6725088eba.135.1217291690806;
        Mon, 28 Jul 2008 17:34:50 -0700 (PDT)
Received: by 10.210.109.18 with HTTP; Mon, 28 Jul 2008 17:34:50 -0700 (PDT)
In-Reply-To: <20080729000103.GH32184@machine.or.cz>
Content-Disposition: inline
X-Google-Sender-Auth: d1f1ffd8d20ac4a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90537>

On Mon, Jul 28, 2008 at 5:01 PM, Petr Baudis <pasky@ucw.cz> wrote:
>  participating in this might be fun, even if there is not much time
> left to sign up:
>
>        http://www.hackontest.org/index.php?action=Root-projectDetail(120)
>
> (What feature in Git or a Git-related tool would you implement, given 24
> hours staight and unlimited pizza supply?)
>
>  P.S.: Disclaimer - yes, if someone suggests something cool enough to
> do with Git, I might apply. ;-)

It might be cool if git-daemon supported
avahi/zeroconf/bonjour/rendezvous as a server and maybe git-status(?
or maybe a new command) had a flag that could make it an avahi client
and list repositories on the local network being advertised over
avahi.

It looks like bzr has an avahi plugin.  Not sure whether it would be a
useful feature for people.  What do other folks think?

As a project, it seems fairly self-contained and well defined, and
might be doable for a small team in 24 hours.

-Tarmigan
