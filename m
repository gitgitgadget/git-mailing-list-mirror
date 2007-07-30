From: david@lang.hm
Subject: Re: merge time
Date: Mon, 30 Jul 2007 10:13:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707301007020.11330@asgard.lang.hm>
References: <28948.8052.qm@web51002.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Rogan Dawes <lists@dawes.za.net>,
	Git Mailing List <git@vger.kernel.org>
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFYoz-0005Hb-Ct
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 19:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965825AbXG3ROO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965628AbXG3ROO
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 13:14:14 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:51360
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758952AbXG3RON (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 13:14:13 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l6UHDspf019564;
	Mon, 30 Jul 2007 10:13:54 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <28948.8052.qm@web51002.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54243>

On Mon, 30 Jul 2007, Matthew L Foster wrote:

> --- Rogan Dawes <lists@dawes.za.net> wrote:
>
>> And also keep in mind that on the command line you can invoke a lot of
>> "plumbing commands" that you certainly wouldn't expect to be exposed in
>> a web interface.
>
> If the web interface requires logins over https why can't plumbing commands be exposed to the web?
> Though I agree not everything needs to be webified. What I envision is a wikipedia style interface
> front end with git remaining the backend so you can more easily browse the file system and see
> history and diff the way you can on Wikipedia. But that idea is very separate from my concern that
> right now gitweb.cgi effectively has a bug in it because it sorts using external/superset commit
> order/time rather than local commit order which causes changes to appear as if they were made
> before they were really merged locally.

what you are asking for would be a very useful piece of software, but 
that's very different from the current gitweb. you are fileing a bug about 
the software doing what it was designed to do. yes, it could be done 
differently. yes, that would be useful. but the software to do so is 
mostly a new product, not a simple tweak to the existing gitweb software.

right now gitweb isn't designed for figuring out what was merged when, 
it's just for retreiving specific versions.

if someone really wanted to do this, the right answer may be to take the 
concept of gitk and webify it (think SVG for the graphics and AJAX 
interfaces to retreive the info as needed). I think this would be a very 
useful tool, but it would be a lot of work to implement.

but without the graph showing the commits and how they are related to each 
other, you really are crippled in your ability to figure out how things 
are related to each other. Date order just doesn't cut it.

David Lang
