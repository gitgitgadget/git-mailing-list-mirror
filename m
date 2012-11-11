From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Help requested - trying to build a tool doing whole-tree commits
Date: Sun, 11 Nov 2012 08:47:22 -0600
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121111144722.GA3593@thyrsus.com>
References: <20121109182024.81074BC66D4@golux>
 <7vlie9pf96.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 16:06:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXZ6p-0000Xn-82
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 16:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab2KKPFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 10:05:47 -0500
Received: from adsl-76-243-231-121.dsl.chcgil.sbcglobal.net ([76.243.231.121]:2009
	"EHLO golux" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752577Ab2KKPFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 10:05:46 -0500
Received: by golux (Postfix, from userid 1000)
	id C2814BC66D4; Sun, 11 Nov 2012 08:47:22 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7vlie9pf96.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209391>

Junio C Hamano <gitster@pobox.com>:
> Perhaps not exactly what you are looking for, but don't we have
> import-tar somewhere in contrib/fast-import hierarchy (sorry, not on
> a machine yet, and I cannot give more details).

If I recall correctly, that can only be used for original import.

I think Andreas Schwab's suggestion (git add -A && git write-tree &&
git commit-tree && git update-ref) is probably the right thing. I'm
going to try that.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
