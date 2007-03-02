From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Fri, 2 Mar 2007 15:09:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021419520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <87y7mhrnrc.fsf@latte.josefsson.org> <Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <87hct4roqa.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 15:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN8SK-0005nP-Fb
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 15:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992465AbXCBOJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 09:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992466AbXCBOJw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 09:09:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:45310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992465AbXCBOJw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 09:09:52 -0500
Received: (qmail invoked by alias); 02 Mar 2007 14:09:50 -0000
X-Provags-ID: V01U2FsdGVkX18GvuhBZQAGHjmmqQ+pkquoMSmCLeMp83T5pFsCoe
	3wE7cZp69N4WJI
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87hct4roqa.fsf@latte.josefsson.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41208>

Hi,

On Fri, 2 Mar 2007, Simon Josefsson wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I saw that in your mail already, and I find the style cvs2cl outputs 
> > ugly.
> 
> Well, if you don't follow the GNU ChangeLog format, then please call it 
> something else.  The format is well documented.

Well, it is still ugly. I mean, really ugly. Like in "it's easier to 
script, therefore I don't fix it" ugly.

And yes, the format is well documented. For example, it includes the 
function names in brackets, which both my patch and cvs2cl do not do. 
These function names actually got me interested, and I would have tried to 
generate them automatically, too.

> > No charset problem. In Git commit messages, the first line is special. 
> > It is the so called "oneline" description. If you wrap the oneline, 
> > it's your fault, not Git's.
> 
> But I want more than the oneline comment in the ChangeLog?  There is no 
> size limit on ChangeLog messages, and having as much information as 
> possible available is better.

With Git, it is encouraged that you write useful commit messages. There 
are commits where the patch consists of just a line change, and the 
message of a really long text. For a good example, look at commit 
v1.4.0-rc1~50: the commit message has 49 lines of text, but the patch only 
changes 5 lines.

If you are serious about "having as much information", include the 
_complete_ commit message.

> Anyway, for now I'll be settling with the (just announced) git2cl since 
> it gives me the most flexibility.

In hindsight I agree with Junio that a script is better for this purpose. 
At least I tricked you into writing it yourself.

> If/when git core includes your patch later on, and some of my pet 
> problems are fixed, and my distribution catches up, I'll be back.

FWIW I am now opposed to inclusion of --pretty=gnucl.

Ciao,
Dscho
