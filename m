From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Third try at documenting command integration
 requirements.
Date: Mon, 26 Nov 2012 16:41:34 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121126214134.GA1713@thyrsus.com>
References: <20121126053557.E56434065F@snark.thyrsus.com>
 <7vzk24qgjx.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:41:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td6R6-0006jW-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab2KZVli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 16:41:38 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:51809
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab2KZVlh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:41:37 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 25FC34065F; Mon, 26 Nov 2012 16:41:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vzk24qgjx.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210500>

Junio C Hamano <gitster@pobox.com>:
> I'll reword the title (readers of "git log" output 6 months down the
> road will not care if this is the third try or the first one) and
> tweak things here and there before queuing.

Result looks good from here.
 
The next things on my git to-do list are 

1. Audit the in-tree Python for version dependencies.  Add floor-version checks.

2. Submit a doc patch containing guidelines that (a) Python scripts should
   check for their floor version and error out gracefully if they won't
   run with the host's interpreter, and (b) Python scripts sbould be
   2.6-compatible.

3. Submit the git-weave integration patch.  I could do that now, but while my
   regression test speaks TAP it doesn't presently use the test library. I plan
   to re-work it to do that.

Do you have any other pending tasks for which you think my expertise would
be useful?  I refer specifically to the facts that (a) I find writing and 
editing documentation easy and can do it rapidly, (b) I'm a Python expert, 
and (c) I am very interested in, and know a lot about, tools for repository
surgery and import/export.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
