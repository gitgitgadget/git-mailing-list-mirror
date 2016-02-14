From: Max Horn <max@quendi.de>
Subject: Re: Announcing git-cinnabar 0.3.0
Date: Sun, 14 Feb 2016 22:57:16 +0100
Message-ID: <1484E384-530B-41A3-80B6-9F2F20059E86@quendi.de>
References: <20160115085658.GA15539@glandium.org> <alpine.DEB.2.20.1601151022050.2964@virtualbox>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 23:15:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV4xN-0003Eh-QO
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 23:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbcBNWPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 17:15:50 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:59020 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751476AbcBNWPt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 17:15:49 -0500
X-Greylist: delayed 1111 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Feb 2016 17:15:49 EST
Received: from ip-178-201-28-152.hsi08.unitymediagroup.de ([178.201.28.152] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1aV4fN-00085e-1m; Sun, 14 Feb 2016 22:57:17 +0100
In-Reply-To: <alpine.DEB.2.20.1601151022050.2964@virtualbox>
X-Mailer: Apple Mail (2.3112)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1455488149;b73f8d99;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286163>

Hi there,

> On 15 Jan 2016, at 10:25, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Mike,
> 
> On Fri, 15 Jan 2016, Mike Hommey wrote:
> 
>> Git-cinnabar is a git remote helper to interact with mercurial
>> repositories. It allows to clone, pull and push from/to mercurial remote
>> repositories, using git.
> 
> Great news! I was really sad when Sverre's work on remote-hg was basically
> ignored and replaced (and he went away after that),

I have a bit of a different recollection of that story; in particular, his tool was quite limited, and quickly broke down when used. 

> and then the replacement was not maintained properly.

If you are talking about felipe's git-remote-hg: I am maintaining a fork of that, and it works quite well for me (I use it daily, and so do many other people):

<https://github.com/fingolfin/git-remote-hg>

That said, I certainly am not putting much energy into it, so I am very happy to see that Mike is active on his new tool :-).

Cheers,
Max

> 
> So I am personally very happy that there is a well-maintained alternative
> now.
> 
> Hopefully I will get a chance to test this soon, but I already have one
> comment: at
>> 1. https://github.com/glandium/git-cinnabar/wiki/Windows-Support
> 
> ... it is mentioned that...
> 
> 	Git for Windows 32-bits is untested, but assumed to have the same
> 	issue as MSys2 32-bits
> 
> ... but as is mentioned here:
> 
> 	https://github.com/git-for-windows/git/wiki/32-bit-issues
> 
> Git for Windows executes the rebaseall step as part of the installation,
> so it should not have the same issue as MSys2 32-bits ;-)
> 
> Ciao,
> Dscho
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
