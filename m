From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui console app ?
Date: Sat, 04 Aug 2007 11:38:19 -0700
Message-ID: <7vhcnfgn6s.fsf@assigned-by-dhcp.cox.net>
References: <20070804101058.GA520@Mac2.local>
	<Pine.LNX.4.64.0708041225520.14781@racer.site>
	<20070804115331.GA2962@Mac2.local>
	<20070804120342.GC9716@coredump.intra.peff.net>
	<20070804123834.GA3036@Mac2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Colson <eco@ecocode.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 20:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHOWG-0000jW-Hz
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 20:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933002AbXHDSi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 14:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932974AbXHDSiZ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 14:38:25 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41136 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870AbXHDSiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 14:38:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804183820.BQZO2095.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 14:38:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XueK1X0081kojtg0000000; Sat, 04 Aug 2007 14:38:19 -0400
In-Reply-To: <20070804123834.GA3036@Mac2.local> (Erik Colson's message of
	"Sat, 4 Aug 2007 14:38:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54896>

Erik Colson <eco@ecocode.net> writes:

> On Sat, Aug 04, 2007 at 08:03:42AM -0400, Jeff King wrote:
>> On Sat, Aug 04, 2007 at 01:53:31PM +0200, Erik Colson wrote:
>> 
>> > Thanks for the very fast answer. I'm currently trying it out. However
>> > I can't figure out how to view the 'changed but not updated' in diff
>> > format...
>> 
>> git-diff ?
>> 
>> By default, it will show the changes between your working tree and the
>> index (i.e., changed but not updated). You can show the diff of "updated
>> but not commited" with "git-diff --cached".
>
> Peff,
>
> yep that is the info I would like to browse in a way git-gui does it...
> showing a list of the files in the diff, and letting the user select a
> file to show the part of the diff for that file.

Since you are an Emacs user, perhaps contrib/emacs/* would be
more to your taste?
 
