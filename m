From: John Koleszar <john.koleszar@on2.com>
Subject: Re: git notes: notes
Date: Mon, 25 Jan 2010 13:08:04 -0500
Organization: On2 Technologies
Message-ID: <1264442884.14641.33.camel@cp-jk-linux.corp.on2.com>
References: <20100120050343.GA12860@gnu.kitenet.net>
	 <201001201148.11701.johan@herland.net>
	 <20100120182438.GB31507@gnu.kitenet.net>
	 <201001210305.05309.johan@herland.net>
Reply-To: john.koleszar@on2.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <joey@kitenet.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZTMf-00061n-Vo
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 19:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0AYSIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 13:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646Ab0AYSId
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 13:08:33 -0500
Received: from mail.on2.com ([66.162.65.131]:42028 "EHLO on2.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754510Ab0AYSId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 13:08:33 -0500
In-Reply-To: <201001210305.05309.johan@herland.net>
X-Mailer: Evolution 2.26.3 
X-On2-MailScanner-i: Found to be clean
X-On2-MailScanner-From: john.koleszar@on2.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137975>

On Wed, 2010-01-20 at 21:05 -0500, Johan Herland wrote:
> On Wednesday 20 January 2010, Joey Hess wrote:
> > Johan Herland wrote:
> > > > PS, Has anyone thought about using notes to warn bisect away from
> > > > commits that are known to be unbuildable or otherwise cause bisection
> > > > trouble?
> > >
> > > No, I haven't thought of that specific use case. Great idea! :)
> > 
[...]
> 
> In any case, I would not use "git notes" to maintain the bisect hints. 
> Rather, I'd add subcommands to "git bisect" that would take care of 
> maintaining the notes tree @ "refs/notes/bisect". Much more user-friendly 
> than telling the user to write their own bisect-notes by hand.
> 

I haven't read up on notes more than enough to know its in the pipe, but
I had a similar idea for using them to store bisect hints. I've been
doing a lot of bisecting lately into a range that had a couple dormant
bugs where I'm trying to bisect bug B but bug A prevents me from making
a determination. Rather than skip what I know is an interesting commit,
I cherry-pick the bugfix commit(s) A' and test that, then reset and
continue bisecting.

Teaching bisect to consistently skip a commit, or to automatically
squash in A' if we have A and not A', would be a desirable feature. I
will have to read up some more on notes.
