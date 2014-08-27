From: Jeff King <peff@peff.net>
Subject: Re: [RFC] add detached HEAD to --all listing
Date: Wed, 27 Aug 2014 10:22:50 -0400
Message-ID: <20140827142249.GC31879@peff.net>
References: <CAF7_NFRKzU0_5Eq4kgtW3RChW3z5q8QBjWvvN+TSyOhORkf8hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 16:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMe88-0001KE-8r
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 16:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934799AbaH0OWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 10:22:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:60082 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934415AbaH0OWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 10:22:51 -0400
Received: (qmail 1766 invoked by uid 102); 27 Aug 2014 14:22:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 09:22:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 10:22:50 -0400
Content-Disposition: inline
In-Reply-To: <CAF7_NFRKzU0_5Eq4kgtW3RChW3z5q8QBjWvvN+TSyOhORkf8hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255998>

On Wed, Aug 27, 2014 at 05:18:21PM +0300, Max Kirillov wrote:

> Could HEAD be added to list of heads while using --all switch?

To which command?

If you mean "git branch", I think the detached HEAD is already
mentioned:

  $ git branch
  * (detached from 1290ebd)
    master

If you mean "git log", I think it is included there, too:

  $ git log --decorate --oneline --all
  685450f (HEAD) more
  1290ebd (master) foo

Is there some other command you have in mind? git-push, maybe?

-Peff
