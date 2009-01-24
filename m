From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: diff settings
Date: Sat, 24 Jan 2009 21:33:59 +0200
Message-ID: <87ocxwv6qg.fsf@iki.fi>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sat Jan 24 20:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQoI0-00026r-L5
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbZAXTeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbZAXTeI
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:34:08 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:56262 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060AbZAXTeF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:34:05 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B89042B340A; Sat, 24 Jan 2009 21:34:01 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LQoGV-0001FT-ES; Sat, 24 Jan 2009 21:33:59 +0200
In-Reply-To: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> (Keith Cascio's message of "Sat\, 24 Jan 2009 09\:38\:18 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106995>

Keith Cascio (2009-01-24 09:38 -0800) wrote:

> How do I configure my local git so that diff always obeys a particular
> option, e.g. "-w", without needing to type it on the command line each
> time?

It seems that the answer is "no", but aliases are a work-around:

    git config --global alias.dff "diff -w"

Then "git dff" is your new "git diff -w". :-)
