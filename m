From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Look for a commit's parents in the standard way.
Date: Mon, 21 Aug 2006 23:42:07 -0700
Message-ID: <7vd5ats24g.fsf@assigned-by-dhcp.cox.net>
References: <20060814165307.20350.63286.stgit@gandelf.nowhere.earth>
	<20060814165544.20350.41590.stgit@gandelf.nowhere.earth>
	<b0943d9e0608200343t517ec29dw2b6b49d9d69dbad5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 22 08:42:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFPxr-0007bv-L7
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 08:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWHVGmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 02:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWHVGmK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 02:42:10 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:1524 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751281AbWHVGmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 02:42:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822064208.ZKPE2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 02:42:08 -0400
To: git@vger.kernel.org
In-Reply-To: <b0943d9e0608200343t517ec29dw2b6b49d9d69dbad5@mail.gmail.com>
	(Catalin Marinas's message of "Sun, 20 Aug 2006 11:43:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25834>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 14/08/06, Yann Dirson <ydirson@altern.org> wrote:
>> This has the direct effect of taking info/grafts into account, since
>> ignoring it only causes confusion.
>
> I don't know the difference but is there any between parsing the
> commit file and using git-rev-list --parents?

If you mean parsing "cat-file commit" output vs "rev-list
--parents" output, the former shows the true parents while the
latter shows a list of parents adjusted with information in the
grafts file.

If you are using pathspec then the latter further simplifies the
parent list, but you know that already and you are not using
that form here.
