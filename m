From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: catch mkdtemp errors
Date: Fri, 27 Jun 2014 16:59:24 +1000
Message-ID: <20140627065924.GB21103@iris.ozlabs.ibm.com>
References: <1403146394-9589-1-git-send-email-davvid@gmail.com>
 <xmqq4mz74cuv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 08:59:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Q8F-00074f-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 08:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbaF0G7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 02:59:31 -0400
Received: from ozlabs.org ([103.22.144.67]:46310 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbaF0G7a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 02:59:30 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E1EEB1400DD; Fri, 27 Jun 2014 16:59:28 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <xmqq4mz74cuv.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252535>

On Thu, Jun 26, 2014 at 01:47:36PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > 105b5d3fbb1c00bb0aeaf9d3e0fbe26a7b1993fc introduced a dependency
> > on mkdtemp, which is not available on Windows.
> >
> > Use the original temporary directory behavior when mkdtemp fails.
> > This makes the code use mkdtemp when available and gracefully
> > fallback to the existing behavior when it is not available.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> 
> In the meantime, I've fetched from you and merged up to your
> master~2 aka 17f9836c (gitk: Show staged submodules regardless of
> ignore config, 2014-04-08).

I have applied and pushed out this patch, along with one from Max
Kirillov, so please do another fetch.

Thanks,
Paul.
