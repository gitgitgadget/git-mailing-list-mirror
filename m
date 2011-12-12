From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Mon, 12 Dec 2011 08:33:15 +0100
Message-ID: <1kc5m38.m71ik21ytxkhbM%lists@haller-berlin.de>
References: <hbf.20111211x512@bombur.uio.no>
Cc: gelonida@gmail.com (Gelonida N), git@vger.kernel.org
To: h.b.furuseth@usit.uio.no (Hallvard B Furuseth)
X-From: git-owner@vger.kernel.org Mon Dec 12 08:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra0O2-0002Oq-OK
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 08:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab1LLHdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 02:33:18 -0500
Received: from server90.greatnet.de ([83.133.96.186]:37806 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab1LLHdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 02:33:17 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id CEC602A01F3;
	Mon, 12 Dec 2011 08:31:42 +0100 (CET)
In-Reply-To: <hbf.20111211x512@bombur.uio.no>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186877>

Hallvard B Furuseth <h.b.furuseth@usit.uio.no> wrote:

> Stefan Haller writes:
> >Gelonida N <gelonida@gmail.com> wrote:
> > 
> >> What is the best way to fastforward all fastforwardable tracking
> >> branches after a git fetch?
> > 
> > Here's a script that does this.  It isn't very well tested, I hope I
> > didn't miss any edge cases. Use at your own risk.
> 
> Local branches can track each other.  So the script needs to toposort
> the branches, or to loop until either nothing was done or an error
> happened.  (The latter to prevent an eternal loop on error.)

Is this just theoretical, or are there real use cases for this? What
would be a workflow with such a local tracking branch?

For me personally, the script is good enough, because I only ever have
branches that track an 'origin' branch with the same name.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
