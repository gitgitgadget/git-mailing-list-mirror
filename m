From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: The ciabot hook code in contrib/ is obsolete - delete it
Date: Tue, 2 Oct 2012 19:39:35 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121002233934.GA21819@thyrsus.com>
References: <20120928024045.E0D6F42F19@snark.thyrsus.com>
 <7vr4pg5vn4.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 01:40:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJC4Z-0002N0-JS
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 01:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724Ab2JBXkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 19:40:06 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54321
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab2JBXkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 19:40:05 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 171C642F19; Tue,  2 Oct 2012 19:39:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vr4pg5vn4.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206852>

Junio C Hamano <gitster@pobox.com>:
> Seeing the above without a signed-off patch and then this on cia.vc
> 
>     We intend to have the CIA.VC Site running soon then bring the
>     service back at a later date!  We currently do not have an ETA for
>     the Service but hope to have it functioning soon!
> 
> I am not sure what the right course of action at this moment.

Then leave things as they are and we'll await developments.

Yes, Ilkotech is expressing a hope to revive CIA.  For various reasons
both technical and political I am near certain the effort will go
nowhere.  From #cia:

[17:19]	Talad	Hi
[17:19]	Talad	the CIA bot in our channel is gone
[17:20]	Talad	how to restore it ?
[17:20]	shadowm	/topic
[17:20]	shadowm	(Old news at this point, really.)
[17:21]	Talad	what is the problem?
[17:21]	AI0867	the server was deleted
[17:21]	AI0867	the version running on it was never checked into version control, nor was it backed up
[17:22]	AI0867	in short, CIA is *gone*
[17:22]	AI0867	for a replacement, see #irker or http://www.catb.org/~esr/irker/
[17:25]	The_Tick	BearPerson: do we know if there was a backup of the database holding all the configs?
[17:26]	BearPerson	There might be one on a hard drive somewhere in my apartment, but it'd be at least 2 years old at this point
[17:26]	BearPerson	haven't gotten around to digging up that box yet
[17:26]	The_Tick	might be worth pulling the emails out and shooting everyone an email explaining the situation
[17:27]	The_Tick	so they stop coming in here asking about it
[17:30]	Talad	"the server was deleted" <- by the owner?
[17:32]	Talad	maybe CIA was discussed/agreed with freenode staff
[17:32]	Talad	and they have a copy of it?
[17:32]	The_Tick	doubt it
[17:33]	Talad	I guess they are careful about widespread bots like CIA
[17:33]	shadowm	No, freenode had nothing to do with running CIA.vc.
[17:34]	shadowm	And the server was deleted by the hosting company, while the current owners did not have a backup plan at all.
[17:36]	Talad	I see
[17:36]	Talad	ok, thanks

On the other hand contrib/ciabot isn't taking up a lot of space in
your tree, either, so there's little harm in leaving it in place.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
