From: Wayne Davison <wayne@opencoder.net>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 4 Jan 2008 22:41:56 -0800
Message-ID: <20080105064156.GA6954@blorf.net>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 07:42:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB2jj-0006vA-Tb
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 07:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbYAEGl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 01:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYAEGl7
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 01:41:59 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:47884 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbYAEGl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 01:41:58 -0500
Received: by dot.blorf.net (Postfix, from userid 1000)
	id CDB0C584E; Fri,  4 Jan 2008 22:41:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69642>

On Fri, Jan 04, 2008 at 05:14:42PM +0100, Marco Costalba wrote:
> -		echo >&2 'No local changes to save'
> +		echo > 'No local changes to save'

That change and the other two following it each put a newline in a
strangely named file.  You should just drop the >&2 altogether if you
want the output to go to stdout.

..wayne..
