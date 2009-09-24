From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: How does gitosis know who the key belongs to
Date: Thu, 24 Sep 2009 19:26:16 +0200
Message-ID: <20090924172610.GA31309@book.hvoigt.net>
References: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 24 19:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqs5H-0002up-Bm
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 19:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbZIXR0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 13:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZIXR0O
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 13:26:14 -0400
Received: from darksea.de ([83.133.111.250]:46180 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752218AbZIXR0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 13:26:13 -0400
Received: (qmail 6063 invoked from network); 24 Sep 2009 19:26:16 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Sep 2009 19:26:16 +0200
Content-Disposition: inline
In-Reply-To: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129052>

On Thu, Sep 24, 2009 at 03:51:44PM +0100, Howard Miller wrote:
> Gitosis obviously uses keypairs but the config file addresses the user
> by name/host. How does gitosis connect the two together? Is it any
> more complicated than the user detail at the end of the public key?

Not much different. It uses the command feature of the authorized_keys
file of ssh to limit access to the 'gitosis-serve' command which is
given the username from the gitosis.conf as argument. gitosis-server
then takes care of the access control.

> The second part of my question then is is it possible to use the same
> private key on more than one host?

Yes definitely. It identifies the user not the host. Although you can
use differenty keys if you want.

cheers Heiko
