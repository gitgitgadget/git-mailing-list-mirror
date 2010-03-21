From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 19:08:08 +0200
Message-ID: <20100321170808.GA15512@LK-Perkele-V2.elisa-laajakaista.fi>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>
 <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
 <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
 <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
 <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de>
 <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
 <alpine.LNX.2.00.1003201724270.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 21 18:08:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOdv-0008MR-Nx
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab0CURIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:08:46 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:51511 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab0CURIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 13:08:45 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id B079818CCD9;
	Sun, 21 Mar 2010 19:08:43 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A07519AE23D; Sun, 21 Mar 2010 19:08:43 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 610F0E51A6;
	Sun, 21 Mar 2010 19:08:36 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1003201724270.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142836>

On Sat, Mar 20, 2010 at 05:58:34PM -0400, Daniel Barkalow wrote:
> On Sun, 21 Mar 2010, Ramkumar Ramachandra wrote:
> 
> > Due to a licensing conflict, the details of which can be found here
> > [1], git-remote-svn will link to libsvn, but will NOT link to Git. It
> > will simply use a thin wrapper to call compiled Git executables
> > (referred to as remote helper in article).
> 
> It should be possible to avoid calling any git executables (directly or 
> otherwise); git should call you with all the information you need.

Don't know about importer modes, but in native connection mode it is
possible to avoid calling or linking to git in any way (been there, done
that).

And if one doesn't need git APIs, its completely possible to avoid
linking into git (this may mean some mode coding effor however).

-Ilari
