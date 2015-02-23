From: Kevin Daudt <me@ikke.info>
Subject: Re: Identifying user who =?utf-8?Q?ran_?=
 =?utf-8?B?4oCcZ2l0IHJlc2V04oCd?= command
Date: Mon, 23 Feb 2015 17:48:33 +0100
Message-ID: <20150223164833.GA17528@vps892.directvps.nl>
References: <1424493989740-7625788.post@n2.nabble.com>
 <CAPc5daULfa8oASxvWQ7RuV9T4SXoCw_Pi0EfGkk1GGafa1r9Xg@mail.gmail.com>
 <1424495778228-7625791.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Technext <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 17:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPwBU-0003cm-5R
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 17:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbBWQsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 11:48:35 -0500
Received: from ikke.info ([178.21.113.177]:52427 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbbBWQsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 11:48:35 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id A94B81DCF6D; Mon, 23 Feb 2015 17:48:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1424495778228-7625791.post@n2.nabble.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264273>

On Fri, Feb 20, 2015 at 10:16:18PM -0700, Technext wrote:
> Thanks Junio for the prompt reply! :) Yes, that's exactly how i would like
> things to be. I'll definitely try to push this thing and see if this flow
> can be implemented.
> 
> However, can you please guide me whether there's any way i could have
> figured out about the git reset command that the developer executed on his
> local? (my first query)

git reset . is just a local working tree operation, which does not leave
something behind, just like when the user would do any other file
operations and comitted that. This created a so called evil merge, which
are not easy to detect (see [1] for some possible solutions)

> 
> Also, am i right in thinking that a check cannot be implemented using hooks
> or any other similar way? (my second query)

Because an evil merge is hard to detect, it's even harder to do it
automated in a script. Human review works much better for this (when
merging in the changes from the developer).


[1]: https://stackoverflow.com/a/27744011/20261
