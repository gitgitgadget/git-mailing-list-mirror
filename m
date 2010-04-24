From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a' when no
 changes were added)
Date: Sat, 24 Apr 2010 15:44:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004241539270.7232@xanadu.home>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock> <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
 <20100424164247.GM3563@machine.or.cz>
 <alpine.LFD.2.00.1004241430300.7232@xanadu.home>
 <20100424185433.GN3563@machine.or.cz>
 <r2y8c9a061004241235n77ca3925q8fde8fc3b01e4e80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Wincent Colaiuta <win@wincent.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 21:45:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5lHf-0006cW-VC
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 21:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab0DXToy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 15:44:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38340 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0DXTox (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 15:44:53 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L1E00M8NC6SDW90@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Apr 2010 15:44:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <r2y8c9a061004241235n77ca3925q8fde8fc3b01e4e80@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145700>

On Sat, 24 Apr 2010, Jacob Helwig wrote:

> On Sat, Apr 24, 2010 at 11:54, Petr Baudis <pasky@suse.cz> wrote:
> > Are there valid user scenarios where you customize your index, then want
> > to override that using -a without thinking twice?
> >
> 
> Depends on what you consider "customizing your index".  I add files to
> the index all the time as I'm working on things, then commit -a at the
> end "without thinking twice".
> 
> For example:
> 1) Hack on something.
> 2) git add $thing
> 3) Run full test-suite.
> 4) Fix a failing module.
> 5) git add $fixed-module-and-tests
> 6) Repeat 3-5 until there's only one module failing.
> 7) Fix last failing module.
> 8) git commit -a
> 
> I doubt I'm the only one that stages things as a way of marking them
> as "done", and using git commit -a to "check-off" the last "todo"
> item.

Sure.  But do you happen to often "commit -a" more changes to an already 
previously modified and staged (but not committed yet) file?


Nicolas
