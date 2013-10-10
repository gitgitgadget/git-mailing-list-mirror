From: Tony Finch <dot@dotat.at>
Subject: Re: A workflow for local patch maintenance
Date: Thu, 10 Oct 2013 17:53:57 +0100
Message-ID: <alpine.LSU.2.00.1310100927270.3100@hermes-2.csi.cam.ac.uk>
References: <alpine.LSU.2.00.1310081906250.5715@hermes-2.csi.cam.ac.uk> <20131010013343.GB14429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 10 18:54:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUJUy-0002Gl-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 18:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782Ab3JJQyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 12:54:00 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:48319 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab3JJQx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 12:53:59 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:36171)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1VUJUr-0005RJ-gm (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 10 Oct 2013 17:53:57 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1VUJUr-0004b1-6O (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 10 Oct 2013 17:53:57 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <20131010013343.GB14429@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235870>

Jeff King <peff@peff.net> wrote:
>
> Do you need to keep the modifications you make on top of upstream as a
> nice, clean series of rebased patches? If not, then you can avoid the
> repeated rebasing, and just use a more traditional topic-branch
> workflow. Treat modifications from upstream as just another topic.

Thanks for the suggestion!

Our aim is to get as many patches into the upstream version as we can,
which is why my starting point is a clean rebased patch series. I am also
thinking that this will help me to know when a patch can be dropped from
the series because upstream have incorporated something like it. If
upstream works like git upstream (incorporating patches verbatim after
they pass review) then git can handle this automatically, but if the patch
gets re-worked it might be easier for me to drop it when rebasing rather
than resolve conflicts. I'm also thinking that for packages which we
update relatively infrequently, having a clean patch series makes it
easier to review whether they are all still necessary when updating. But
perhaps I am too wedded to manual patch management...

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first.
Rough, becoming slight or moderate. Showers, rain at first. Moderate or good,
occasionally poor at first.
