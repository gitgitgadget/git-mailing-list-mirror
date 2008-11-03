From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH 4/4] Add support for 'namespace' history simplification
Date: Mon, 3 Nov 2008 22:45:16 +0100
Message-ID: <adf1fd3d0811031345j4582e109jaf95aede0f33eff7@mail.gmail.com>
References: <200811031439.12111.brian.foster@innova-card.com>
	 <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811031133590.3419@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811031135410.3419@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Foster" <brian.foster@innova-card.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 22:46:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx7Fw-0000Yd-Ks
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 22:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbYKCVpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 16:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbYKCVpU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 16:45:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:57421 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbYKCVpT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 16:45:19 -0500
Received: by ug-out-1314.google.com with SMTP id 39so47030ugf.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 13:45:17 -0800 (PST)
Received: by 10.103.251.3 with SMTP id d3mr290443mus.73.1225748717125;
        Mon, 03 Nov 2008 13:45:17 -0800 (PST)
Received: by 10.103.179.20 with HTTP; Mon, 3 Nov 2008 13:45:16 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99999>

On Mon, Nov 3, 2008 at 8:43 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Mon, 3 Nov 2008 11:25:46 -0800
> Subject: [PATCH 4/4] Add support for 'namespace' history simplification
>
> Maybe this is mis-named, but what it does is to simplify history not by
> the contents of the tree, but whether a commit has been named (ie it's
> referred to by some branch or tag) or not.

Maybe --simplify-refs, or --simplify-overview.

>
> This makes it possible to see the relationship between different named
> commits, without actually seeing any of the details.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> This is the actual real meat of the logic, and it's really trivial. The
> actual code is really just a simple
>
>    if (simplify-by-namespace)
>        return lookup_decoration(..) ? REV_TREE_DIFFERENT : REV_TREE_SAME;

I tried it once, but I had problems simplifying the merges, and it is trivial...

Not that it matters a lot, but if you try it on master you get some
extra merges without a ref like:

373a273 (Merge git-gui 0.11.0, 2008-08-17)
f44bc33 (Sync with 1.5.6.5, 2008-08-06)

Thanks,
Santi
