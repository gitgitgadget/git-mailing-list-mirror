From: Mike Hommey <mh@glandium.org>
Subject: Re: use-after-free leads to git-blame writing garbage in error
 message
Date: Tue, 3 Feb 2015 18:38:43 +0900
Message-ID: <20150203093843.GA14981@glandium.org>
References: <20150203091715.GA25445@glandium.org>
 <20150203093245.3733.71523@typhoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 10:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIZwf-0002j5-PL
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 10:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbbBCJiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 04:38:54 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:43728 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbbBCJiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 04:38:52 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YIZwR-0004Z6-7r; Tue, 03 Feb 2015 18:38:43 +0900
Content-Disposition: inline
In-Reply-To: <20150203093245.3733.71523@typhoon>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263317>

On Tue, Feb 03, 2015 at 10:32:45AM +0100, Lukas Fleischer wrote:
> On Tue, 03 Feb 2015 at 10:17:15, Mike Hommey wrote:
> > Symptoms: $ git blame HEAD -- foo fatal: no such path foo in <random
> > garbage>
> > 
> > Expected output: $ git blame HEAD -- foo fatal: no such path foo in
> > HEAD
> > 
> > Bisect says this was introduced in
> > 1da1e07c835e900337714cfad6c32a8dc0b36ac3 [...]
> 
> This should be fixed by commit a46442f (blame.c: fix garbled error
> message, 2015-01-12) which is in next.

Indeed it is, I should have checked next.

Thanks.

Mike
