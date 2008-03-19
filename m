From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH,RFC] make it easier for people who just want to get rid of
 'git gc --auto'
Date: Wed, 19 Mar 2008 19:29:58 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803191916590.2947@xanadu.home>
References: <alpine.LFD.1.00.0803191703280.2947@xanadu.home>
 <7vzlsu1ikt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 00:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc7lV-0004IX-TD
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 00:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764731AbYCSXaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 19:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756373AbYCSXaB
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 19:30:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10755 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762112AbYCSX37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 19:29:59 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JY000HQO3XYD951@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Mar 2008 19:29:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vzlsu1ikt.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77589>

On Wed, 19 Mar 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > +Some git commands may automatically run `git-gc`; see the `--auto` flag
> > +below for details. If you know what you're doing and all you want is to
> > +disable this behavior permanently without further considerations, just do:
> 
> I sense certain amount of distaste on the writer's part in the later part
> of this sentence.  Did you have to say "without further considerations" to
> hint "you are idiot not to consider downsides?"

That was more a "I don't care at all -- I just want to disable this 
thing right away" type of hint.  And the "if you know what you're doing" 
should normally exclude idiots. But you may as well just remove the 
"without further considerations" part.

> Maybe we would want to warn what kind of downsides the user might be
> dismissing without thinking, which can come back and haunt him later?

Maybe.  But my concern is more for users like Jens who are annoyed 
enough and just want this behavior to get out of their way.


Nicolas
