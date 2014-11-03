From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Tue, 4 Nov 2014 00:07:02 +0200
Message-ID: <20141103220702.GA23548@wheezy.local>
References: <543D58D9.5060606@web.de>
 <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
 <20141014183431.GA8157@wheezy.local>
 <543D7EBA.4040206@web.de>
 <20141014221509.GA10580@wheezy.local>
 <543EC390.4000709@web.de>
 <20141016205453.GA8441@wheezy.local>
 <54441147.5080204@web.de>
 <20141020041109.GA5784@wheezy.local>
 <CACsJy8C34PyK4rPQC_wFgms=gVCs2FN_5aUSMfzJawErZHHwFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlPnI-0002Hp-17
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 23:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbaKCWII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 17:08:08 -0500
Received: from p3plsmtpa07-03.prod.phx3.secureserver.net ([173.201.192.232]:43957
	"EHLO p3plsmtpa07-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751591AbaKCWIG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2014 17:08:06 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-03.prod.phx3.secureserver.net with 
	id BA7s1p00K5B68XE01A7xmb; Mon, 03 Nov 2014 15:08:04 -0700
Content-Disposition: inline
In-Reply-To: <CACsJy8C34PyK4rPQC_wFgms=gVCs2FN_5aUSMfzJawErZHHwFg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 03, 2014 at 07:54:39PM +0700, Duy Nguyen wrote:
> Ping.. any idea how to go from here..

I'm sorry, I happen to have little time since the last
conversation.

As far as I understand, my patches are correct about
handling existing submodules, but they may be not enough
regarding _initialization_ of the submodules. There can be
desired changes to how 'git submodule update --init' behaves
in the linked working trees. If others agree to leave it to
some later development, and continue now with the reading
part, I would keep it all unchanged, except adding the
GIT_COMMON_DIR to local_repo_env (or would you like to do
it?) and couple of additional tests which I have drafted
during discussion. Otherwise I'll be trying but it's hard to
make any estimates.

PS: the change of 'git submodule update --init' would be
behavior change, but git anyway must support non-linked
submodules in different worktrees, so there should be no
compatibility break.

-- 
Max
