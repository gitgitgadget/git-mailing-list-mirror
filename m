From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/5] Split .git/config in multiple worktree setup
Date: Thu, 3 Dec 2015 23:00:49 +0200
Message-ID: <20151203210049.GB10006@wheezy.local>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <20151203061505.GA4314@wheezy.local>
 <CACsJy8AOeFEKhhmH-TCK6gWZQAJX0kbTS0-=iyCji9eXwBr9QA@mail.gmail.com>
 <xmqqpoyntilw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Max Kirillov <max@max630.net>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 22:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4azq-00028B-BE
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 22:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbbLCVAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 16:00:54 -0500
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:56597
	"EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849AbbLCVAy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 16:00:54 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-04.prod.phx3.secureserver.net with 
	id p90o1r00S5B68XE0190ry9; Thu, 03 Dec 2015 14:00:53 -0700
Content-Disposition: inline
In-Reply-To: <xmqqpoyntilw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281972>

On Thu, Dec 03, 2015 at 11:52:43AM -0800, Junio C Hamano wrote:
> I actually prefer *not* to have any configurability
> to avoid confusion between users.

This could be an approach. But because of upgrade issues
which I described in the other response it looks like this
decision is not easy to change in a later version. So the
list should be decided here and now for each existing
variable, and later for any new one, and preferable never
changed after that.

-- 
Max
