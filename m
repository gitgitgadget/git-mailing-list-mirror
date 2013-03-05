From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git repo on Win 2008
Date: Tue, 5 Mar 2013 09:15:35 +0100
Message-ID: <20130305081534.GC4677@sandbox-ub>
References: <5135319F.50404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 09:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCn2b-0002a5-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 09:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab3CEIPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 03:15:39 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:53723 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab3CEIPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 03:15:38 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UCn27-0000aG-GQ; Tue, 05 Mar 2013 09:15:35 +0100
Content-Disposition: inline
In-Reply-To: <5135319F.50404@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217435>

Hi,

wrong mailing list for Windows questions. This is the correct one:

http://groups.google.com/group/msysgit

On Mon, Mar 04, 2013 at 04:43:27PM -0700, J.V. wrote:
> What is the best way to host a shared git repo on a Windows 2008
> box?  I would like to create a repo on the 2008 box (that everyone
> will pull/push to), but add the initial code from my developer
> (Windows7 box).

The simplest way is: Just use a shared folder to which you push/clone a
bare clone of your repository. Everyone with access to that folder will
be able to clone from or push there.

There is even an option in Git GUI for the initial operation:

Menubar->Remote->Add, Fill in your information and choose "Initialize
Remote Repository and Push"

Cheers Heiko
