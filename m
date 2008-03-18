From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never, and only
Date: Tue, 18 Mar 2008 21:57:04 +0800
Organization: (kooxoo Corp.)
Message-ID: <20080318135704.GA11922@kooxoo235>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com> <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Hvammen Johansen <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 14:58:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbcK7-0006cG-JC
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 14:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbYCRN5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 09:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYCRN5K
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 09:57:10 -0400
Received: from mail.qikoo.org ([60.28.205.235]:39096 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750917AbYCRN5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 09:57:09 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id ED8DF470AF; Tue, 18 Mar 2008 21:57:04 +0800 (CST)
Mail-Followup-To: Sverre Hvammen Johansen <hvammen@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77500>

* Sverre Hvammen Johansen <hvammen@gmail.com> [2008-03-17 20:27:13 -0800]:

> New fast forward strategies, only, is introduced.  This new fast
> forward strategy prevents real merges.
> 
> +                               fast_forward=allow ;;
> +                       *)
> +                               die "Available fast-forward strategies
> are: allow, newer, and only" ;;

I fail to apply this patch. It seems wrapped here. Do you use "git send-email"?

> +                       esac
> +                       ;;
> +               --ff=*)
> +                       fast_forward=${1#--ff=}
> +                       case "$fast_forward" in
> +                           allow|never|only)
> +                               ;;
> +                           *)
> +                               die "Available fast-forward strategies
> are: allow, newer, and only" ;;

Wrapped again.
