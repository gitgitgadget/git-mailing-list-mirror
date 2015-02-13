From: Jeff King <peff@peff.net>
Subject: Re: could not verify object error
Date: Fri, 13 Feb 2015 04:56:31 -0500
Message-ID: <20150213095630.GA32009@peff.net>
References: <loom.20150212T132927-657@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Devlin <devlin-d1@email.ulster.ac.uk>
X-From: git-owner@vger.kernel.org Fri Feb 13 10:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMCzI-0004jn-VZ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 10:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbbBMJ4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 04:56:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:48604 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751932AbbBMJ4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 04:56:35 -0500
Received: (qmail 2493 invoked by uid 102); 13 Feb 2015 09:56:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 03:56:35 -0600
Received: (qmail 32640 invoked by uid 107); 13 Feb 2015 09:56:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 04:56:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2015 04:56:31 -0500
Content-Disposition: inline
In-Reply-To: <loom.20150212T132927-657@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263803>

On Thu, Feb 12, 2015 at 12:32:45PM +0000, Daniel Devlin wrote:

> tag_contents = 
> "object f849f9e28c7f36a826d4b451efb16516c0c3acc2\ntype #{type}\ntag #
> {tagname}\ntagger #{username} <#{email}> #{Time.new.to_i} +0000\n\n#{message}"
> [...]
> executecommand = "printf \"#{tag_contents}\" | git mktag"
> [...]
> I have tried to run it on a vm with git 2.0.4 but keep 
> getting char 7 could not verify object error message. 

Do you have object f849f9e28c... in the repository where you are running
mktag? If so, is it a commit object, as you are putting in the type
field? What does:

  git cat-file -t f849f9e28c7f36a826d4b451efb16516c0c3acc2

show?

-Peff
