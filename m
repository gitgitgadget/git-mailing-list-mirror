From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/2] gitk: match ttk fonts to gitk fonts
Date: Sat, 19 Dec 2015 13:26:40 +1100
Message-ID: <20151219022640.GC422@fergus.ozlabs.ibm.com>
References: <CAPig+cSwWxLMRh7e231svhtiJQH-5WuMO+3Y5x-e9tEOyHtqDg@mail.gmail.com>
 <1449558351-15038-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 04:18:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA81x-0002DO-8V
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 04:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbbLSDRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 22:17:20 -0500
Received: from ozlabs.org ([103.22.144.67]:46102 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760AbbLSDRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 22:17:19 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7B068140313; Sat, 19 Dec 2015 14:17:17 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1449558351-15038-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282732>

On Tue, Dec 08, 2015 at 08:05:50AM +0100, Giuseppe Bilotta wrote:
> The fonts set in setoptions aren't consistently picked up by ttk, who
> uses its own predefined fonts. This is noticeable when switching
> between using and not using ttk with custom fonts or in HiDPI settings
> (where the default TTK fonts do _not_ respect tk sclaing).
> 
> Fix by mapping the ttk fontset to the one used by gitk internally.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Thanks, applied both this and the following patch.

Paul.
