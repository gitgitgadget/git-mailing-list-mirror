From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Re-Transmission of blobs?
Date: Fri, 13 Sep 2013 12:23:16 +0200
Message-ID: <20130913102316.GF14259@raven.wolf.lan>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
 <871B6C10EBEFE342A772D1159D132085571A7A1B@umechphj.easf.csd.disa.mil>
 <20130912195654.GE32069@sigill.intra.peff.net>
 <871B6C10EBEFE342A772D1159D132085571A7E5C@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 13 12:30:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKQdp-0003Za-Mg
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 12:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab3IMKaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 06:30:17 -0400
Received: from quechua.inka.de ([193.197.184.2]:46043 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab3IMKaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 06:30:16 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1VKQdj-0005BO-Lh; Fri, 13 Sep 2013 12:30:15 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 2D5A27638E; Fri, 13 Sep 2013 12:23:16 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871B6C10EBEFE342A772D1159D132085571A7E5C@umechphj.easf.csd.disa.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234740>

On Thu, Sep 12, 2013 at 08:06:35PM +0000, Pyeron, Jason J CTR (US) wrote:

> Yes, but it is those awfully slow connections (slower that the looping
> issue) which happen to always drop while cloning from our office. And the
> round trip should be mitigated by http-keep-alives.
[ ... ]
> But, again if the connection drops, we have already lost the delta
> advantage. I would think the scenario would go like this:
> 
> git clone url://blah/blah
> [fail]
> cd blah
> git clone --resume #uses normal methods....
> [fail]
> while ! git clone --resume --HitItWithAStick
> 
> replace clone with fetch for that use case too

Last time I checked, cloning could not be resumed:

http://git.661346.n2.nabble.com/git-clone-and-unreliable-links-td7570652.html

If you're on a slow/unreliable link, you've lost.

:-( :-( :-(

-- 
Josef Wolf
jw@raven.inka.de
