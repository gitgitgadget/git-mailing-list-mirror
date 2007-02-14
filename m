From: Nicolas Pitre <nico@cam.org>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 13:03:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702141253520.1757@xanadu.home>
References: <vpq64a4bzp1.fsf@olympe.imag.fr>
 <20070214142731.GA1478@moooo.ath.cx> <45D33485.5020906@webdrake.net>
 <17875.14305.910866.273778@lisa.zopyra.com>
 <17875.14859.177000.558634@lisa.zopyra.com> <45D33D53.6040209@webdrake.net>
 <vpqbqjw65kj.fsf@olympe.imag.fr> <45D3412B.9010200@webdrake.net>
 <Pine.LNX.4.64.0702141237400.1757@xanadu.home> <45D34B17.70602@webdrake.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOTN-0001up-89
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbXBNSDN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbXBNSDN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:03:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10989 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413AbXBNSDM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:03:12 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDG00JLCSTB6TB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Feb 2007 13:03:11 -0500 (EST)
In-reply-to: <45D34B17.70602@webdrake.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39712>

On Wed, 14 Feb 2007, Joseph Wakeling wrote:

> Nicolas Pitre wrote:
> > What would be the point if you don't have GIT on the remote system?
> > 
> > Just use rsync or scp to copy your code over and be happy.
> 
> For one thing, I might be making small changes or have unversioned files
> in my local directory that I don't want to copy.  I only want to push
> across the latest code in the branch.

Try this then:

  git archive --format=tar <branch_name> | ssh <remote_machine> tar -xf -

You can also use the --prefix= argument to git-archive in order to 
specify a subdirectory on the remote machine.


Nicolas
