From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: List all SHA1 hashes in repo
Date: Sun, 23 Mar 2008 09:40:07 -0400
Message-ID: <eaa105840803230640j11ffa096x511a81b1c0b8f40e@mail.gmail.com>
References: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexander Gladysh" <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 14:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQRQ-0007fP-A2
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 14:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912AbYCWNkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbYCWNkK
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:40:10 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:29448 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538AbYCWNkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 09:40:08 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3003333fkr.5
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=wE+rbAXsnoVdSWdcQ65F1APVyTcEKFJKtvTwrQE7LXg=;
        b=DxBdpksrlnrk45LRlMu4CdeEdS9Qky6dV9pV8kCNenk2U9fpl4MgHFo8ZWI4rDPifkQLZMHflj1tei4gDHas0YWyqQYhmUNj2CNk9LuEDZh8bw0yTcw+fzd+5C/ftbhu8wGkzKL87PEm+GTpzBs5AdEqbcBCGp5U+fPemX8HApk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JvHkYb4eCcWWGkgbIj2Nz5r8x/2qyGIfkRajHxsRiNmpEeCI7iGztsMciALLsITGnEnB0fGivpX3aGMVmbQPaeSVSnXwduPWKJSLYkm2X57V/MUezr70Y7xtvZC+NfRR7N4/fGE7j0Jxuuk9o11AXsAwm8aNv7204gnnrzcVsjg=
Received: by 10.78.166.1 with SMTP id o1mr16625716hue.74.1206279607385;
        Sun, 23 Mar 2008 06:40:07 -0700 (PDT)
Received: by 10.78.107.13 with HTTP; Sun, 23 Mar 2008 06:40:07 -0700 (PDT)
In-Reply-To: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 3085574cb2bd3a84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77892>

On Sun, Mar 23, 2008 at 9:17 AM, Alexander Gladysh <agladysh@gmail.com> wrote:
>  To help testing little Git-related tool I'm writing, I need a lot of
>  pregenerated SHA1 hashes. Git repo seems to be a perfect source of
>  such. Is there an easy way to extract a list of all (well, most of)
>  SHA1 hashes in the repo?

After a "git gc" to roll everything into a single pack, you could do a
"git verify-pack -v" to list all the SHA1s in the pack.

Peter Harris
