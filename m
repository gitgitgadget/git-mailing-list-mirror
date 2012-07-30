From: Bo98 <BoEllisAnderson@aol.com>
Subject: Re: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Mon, 30 Jul 2012 13:30:15 -0700 (PDT)
Message-ID: <1343680215071-7564137.post@n2.nabble.com>
References: <1343587966493-7564017.post@n2.nabble.com> <CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com> <1343637600904-7564056.post@n2.nabble.com> <CAJo=hJtynNo3SPmM4vmmsS3b7PTUwOcQpHPYh0_sPWFWL-4HMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 22:30:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svwbh-0000sq-Uj
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 22:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab2G3UaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 16:30:17 -0400
Received: from sam.nabble.com ([216.139.236.26]:52506 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195Ab2G3UaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 16:30:16 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <BoEllisAnderson@aol.com>)
	id 1SvwbX-0000oF-2u
	for git@vger.kernel.org; Mon, 30 Jul 2012 13:30:15 -0700
In-Reply-To: <CAJo=hJtynNo3SPmM4vmmsS3b7PTUwOcQpHPYh0_sPWFWL-4HMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202611>


Shawn Pearce wrote
> 
> No, a smart HTTP response looks more like this:
> 
> 1e# service=git-receive-pack
> 000000a5e7a3bcbbb8083e812ce07a5459f0e6d30edfb9fe HEAD include-tag
> multi_ack_detailed multi_ack ofs-delta side-band side-band-64k
> thin-pack no-progress shallow no-done
> 
> Looks like Apache isn't calling the smart-http CGI.
> 

Oh ok, thanks! But do you have any idea why? Everything in my config looks
okay to me. I've got my GIT_PROJECT_ROOT, my GIT_HTTP_EXPORT_ALL, my
ScriptAlias and my LocationMatch. I'm not sure why it's like this.




--
View this message in context: http://git.661346.n2.nabble.com/PROPFIND-405-with-git-http-backend-and-Smart-HTTP-tp7564017p7564137.html
Sent from the git mailing list archive at Nabble.com.
