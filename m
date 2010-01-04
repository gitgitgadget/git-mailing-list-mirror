From: "Heiko Voigt" <hvoigt@hvoigt.net>
Subject: Re: RFC: display dirty submodule working directory in git gui and 
     gitk
Date: Mon, 4 Jan 2010 11:44:31 +0100 (CET)
Message-ID: <61083.85.16.196.198.1262601871.squirrel@archive.darksea.de>
References: <4B3F6742.6060402@web.de>
    <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jens Lehmann" <jens.lehmann@web.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Heiko Voigt" <hvoigt@hvoigt.net>, "Lars Hjemli" <hjemli@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 11:44:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRkQR-0005FQ-JO
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 11:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab0ADKof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 05:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988Ab0ADKof
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 05:44:35 -0500
Received: from darksea.de ([83.133.111.250]:60841 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752217Ab0ADKoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 05:44:34 -0500
Received: (qmail 10811 invoked by uid 33); 4 Jan 2010 11:44:31 +0100
Received: from 85.16.196.198
        (SquirrelMail authenticated user hvoigt)
        by archive.darksea.de with HTTP;
        Mon, 4 Jan 2010 11:44:31 +0100 (CET)
In-Reply-To: <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136107>

Hi,

Johannes wrote:
> The real problem is that submodules in the current form are not very well
> designed.  For example, a submodule being at a different commit than in
> the superproject's index is not as fatal as the submodule having changes.
>
> So in the long run, IMHO a proper redesign of the submodules would not
> make only a little sense (it does not help, though, that those who
> implemented and furthered the current approach over other discussed
> approaches do not use submodules themselves -- not even now).

Do you mean the complete workflow (submodules are links to other git repos)
or the current implementation? Do you have links to other design
approaches/threads? Would be nice if we could take that into account for any
decision.

cheers Heiko
