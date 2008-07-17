From: Nicolas Pitre <nico@cam.org>
Subject: Re: Contributors, please check your names
Date: Thu, 17 Jul 2008 10:59:31 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807171058000.3110@xanadu.home>
References: <7v8ww0j4ye.fsf@gitster.siamese.dyndns.org>
 <m3sku8sh01.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 17:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUy9-0005zv-B1
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 17:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbYGQO7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbYGQO7e
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:59:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56684 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbYGQO7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:59:33 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4500F9ZOB80000@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Jul 2008 10:59:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3sku8sh01.fsf@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88863>

On Thu, 17 Jul 2008, Jakub Narebski wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > There is a "mailmap" mechanism to consolidate them; it allows us to
> > specify what human-readable name should be used for given e-mail address.
> > The hypothetical Mr. Thor might want to say "I am A. U. Thor; some commits
> > from me, <author@example.xz>, are marked without abbreviating periods in
> > my name", and we can add this entry to the toplevel .mailmap file to fix
> > it:
> > 
> > 	A. U. Thor <author@example.xz>
> > 
> > It tells the shortlog (and --pretty=format:%aN in recent enough git)
> > mechanism to give huma readable name "A. U. Thor" anytime it sees
> > <author@example.xz> e-mail address, regardless of what the Author:
> > header in the commit object says.
> 
> What about if some authors use different _email_ address, instead?
> Is there any way for shortlog to consider them the same?

It already does, unless you use the -e switch.


Nicolas
