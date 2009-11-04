From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Accessing the reflog remotely
Date: Wed, 04 Nov 2009 12:46:48 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911041243350.10340@xanadu.home>
References: <vpqljimpr95.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 04 18:48:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5jyL-00062t-4V
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 18:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbZKDRqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 12:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbZKDRqp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 12:46:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11521 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbZKDRqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 12:46:44 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSL00JQNIQ04KD0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Nov 2009 12:46:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqljimpr95.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132099>

On Wed, 4 Nov 2009, Matthieu Moy wrote:

> Hi,
> 
> I guess the answer is "no", but I'll still ask in case ...
> 
> Is it possible to access the reflog of a remote repository other than
> logging into this repository?

No.

> My use-case is the following: I want to checkout "the last revision
> pushed in master on ssh://host/repo/ on day D at midnight" (to fetch
> the project of my students ;-) ). If it were locally, I'd do
> 
>   git checkout 'origin/master@{Nov 3 00:00:00}'
> 
> But this tells me where _my_ local master was on that date (i.e. the
> last revision I had pulled).

You could checkout the first revision which committer's date is older 
than midnight.  Of course that means you have to trust that students 
didn't mess up with time stamps.


Nicolas
