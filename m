From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured
	mergetool option
Date: Thu, 29 Oct 2009 22:12:34 +0000
Message-ID: <20091029221234.GB32590@hashpling.org>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com> <20091027230043.GA11607@hashpling.org> <20091028090022.GA90780@gmail.com> <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com> <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Scott Chacon <schacon@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 23:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3dEa-0000Bq-J1
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 23:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbZJ2WMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 18:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756159AbZJ2WMc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 18:12:32 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:19317 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756045AbZJ2WMc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 18:12:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEABSw6UrUnw4U/2dsb2JhbADfZYQ9BIJn
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.ptn-ipout02.plus.net with ESMTP; 29 Oct 2009 22:12:35 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1N3dER-00021v-8d; Thu, 29 Oct 2009 22:12:35 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n9TMCYS2009512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Oct 2009 22:12:34 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n9TMCYIb009511;
	Thu, 29 Oct 2009 22:12:34 GMT
Content-Disposition: inline
In-Reply-To: <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: f3dc62d93791d3d87fe3f7ef2bd781d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131662>

On Wed, Oct 28, 2009 at 02:39:32PM -0700, Scott Chacon wrote:
> p4merge is now a built-in diff/merge tool.
> This adds p4merge to git-completion and updates
> the documentation to mention p4merge.
> 
> Signed-Off-By: Scott Chacon <schacon@gmail.com>
> ---
> 
> This is the same patch, but I tested it on Linux as well as Mac and it
> works fine as long as the [difftool|mergetool].p4merge.path configs
> are set or it's in your path.

I've examined the two patches and I feel more comfortable with
Scott's, mainly due to it's simplicity.

I'm not sure I understand why only p4merge on Mac OS X is special, we
don't seem to treat any other mergetool specially and we don't seem to
need absolute paths anywhere else.

If it's a Mac OS X only thing, can we (and should we) avoid special
treatment for p4merge on other platforms?

The only other question I have is what are the merits of using
/dev/null as the base vs. a second copy of the local version in the
baseless merge case? It's the only other difference between the two
p4merge patches that I noticed.

Perhaps we could consider having both p4merge and launchp4merge as
separate options?

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
