From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git gc and kernel.org
Date: Tue, 20 Oct 2009 14:46:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910201442480.21460@xanadu.home>
References: <4ADD6026.8070203@zytor.com>
 <7veioyqzeo.fsf@alter.siamese.dyndns.org>
 <200910201054.48315.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:41:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LWL-0003qh-Ge
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbZJTUlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 16:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbZJTUlU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:41:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13799 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZJTUlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 16:41:18 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRT009IFTGQE6J0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Oct 2009 14:46:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200910201054.48315.johan@herland.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130841>

On Tue, 20 Oct 2009, Johan Herland wrote:

> On Tuesday 20 October 2009, Junio C Hamano wrote:
> > At one point, update-server-info used to compute a lot more than what we
> > currently compute and it made some sense to oppose against it on
> > performance ground.
> > 
> > But these days it only lists the refs and packs and does nothing else;
> > the performance impact should be immeasurable and it adds only two files
> > to the repository.  It cannot be a big deal, unless you oppose to http
> > transport on a non-technical ground.
> 
> FYI, update-server-info takes ~0.7 seconds in a repo with one pack and 
> ~50000 refs, so I guess it's acceptable to enable it by default, even in 
> those kinds of repos.

Still... Hopefully this is going to become redundant information in the 
future with the eventual deployment of smart protocol over HTTP.  So I 
think that as a config option being off by default this is a good 
compromize.  Site administrators can turn it on by default in 
/etc/gitconfig.


Nicolas
