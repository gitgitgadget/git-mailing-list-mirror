From: Dave Abrahams <dave@boostpro.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Fri, 21 Jun 2013 16:33:19 +0000 (UTC)
Message-ID: <loom.20130621T183212-109@post.gmane.org>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com> <1331184656-98629-1-git-send-email-davidbarr@google.com> <20120308070951.GA2181@burratino> <7vty1zdp2b.fsf@alter.siamese.dyndns.org> <20120310031228.GA3008@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 18:33:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4HQ-0003er-RL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423294Ab3FUQdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:33:41 -0400
Received: from plane.gmane.org ([80.91.229.3]:50524 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423252Ab3FUQdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:33:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Uq4HI-0003Tp-H5
	for git@vger.kernel.org; Fri, 21 Jun 2013 18:33:36 +0200
Received: from 107-219-149-247.lightspeed.sntcca.sbcglobal.net ([107.219.149.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 18:33:36 +0200
Received: from dave by 107-219-149-247.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 18:33:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 107.219.149.247 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/536.30.1 (KHTML, like Gecko) Version/6.0.5 Safari/536.30.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228628>

Jonathan Nieder <jrnieder <at> gmail.com> writes:

> 
> After sleeping on it, here are two patches for 'maint'.  One plugs a
> memory leak.  The other makes my above comment actually true, so
> trying to use this missing feature results in an error message that
> can help the frontend author instead of the silently broken conversion
> Andrew found.
> 
> Then we can carefully add 'ls ""' support in 1.7.11.

The support for 'ls ""' was nevre actually added, was it?
