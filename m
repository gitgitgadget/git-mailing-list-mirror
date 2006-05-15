From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/3] Handle branch names with slashes
Date: Mon, 15 May 2006 12:58:10 +0200
Message-ID: <20060515105810.GA27077@diana.vm.bytemark.co.uk>
References: <20060510060040.GA3034@diana.vm.bytemark.co.uk> <20060515095440.GA11412@backpacker.hemma.treskal.com> <b0943d9e0605150322w684785d5n9b17dccda6b29ac1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wartan Hachaturow <wartan.hachaturow@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 12:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfamK-0005m1-W1
	for gcvg-git@gmane.org; Mon, 15 May 2006 12:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWEOK6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 May 2006 06:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWEOK6R
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 06:58:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:58629 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S964878AbWEOK6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 06:58:17 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FfamA-00074o-00; Mon, 15 May 2006 11:58:10 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0605150322w684785d5n9b17dccda6b29ac1@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20047>

On 2006-05-15 11:22:08 +0100, Catalin Marinas wrote:

> There is one problem with killing "/" entirely (or maybe we could
> use other character than "#"). I tend to write quite often "stg diff
> -r /bottom" to see how the whole patch looks like before refreshing.
> With "#", the shell ignores "#bottom" as being a comment.
>
> Otherwise, I'm OK with changing "/" with something else or just
> keeping both (though I prefer to have a singe way of specifying it).
> It looks like ^ and ~ are already used by GIT. It leaves us with %
> and !. Do you have any preference? The exclamation mark looks OK to
> me.

Ah, right. Well, I would prefer %, since ! is used for some kind of
shell history searching, but % is not touched by the shell, I think.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
