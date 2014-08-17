From: Jeff King <peff@peff.net>
Subject: Re: Not able to create feature branch Git
Date: Sun, 17 Aug 2014 04:37:52 -0400
Message-ID: <20140817083752.GK23808@peff.net>
References: <10058843.3H3SQKIfkQ@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 10:38:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIvyW-00029I-Kf
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 10:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbaHQIhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 04:37:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:53593 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751092AbaHQIhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 04:37:54 -0400
Received: (qmail 10714 invoked by uid 102); 17 Aug 2014 08:37:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 03:37:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 04:37:52 -0400
Content-Disposition: inline
In-Reply-To: <10058843.3H3SQKIfkQ@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255360>

On Wed, Aug 13, 2014 at 01:32:56AM +0630, Arup Rakshit wrote:

> arup@linux-wzza:~/Ruby/yzz> git push origin posward
> Warning: Permanently added the RSA host key for IP address '192.30.252.131' to 
> the list of known hosts.
> ERROR: Permission to boris-s/yzz.git denied to aruprakshit.
> fatal: Could not read from remote repository.

It looks like you are pushing to GitHub here. You are fetching from user
boris-s, but you do not have write permission to push to his repository.

If boris-s is somebody you are working with and he would like to use a
shared repository workflow with you, ask him to follow this guide:

  https://help.github.com/articles/adding-collaborators-to-a-personal-repository

However, the normal workflow for most open-source projects is to make
your own fork with your changes, and then send a pull request to
boris-s. You can follow this guide:

  https://help.github.com/articles/fork-a-repo

-Peff
