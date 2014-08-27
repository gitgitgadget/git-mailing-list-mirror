From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] clean up author parsing
Date: Wed, 27 Aug 2014 10:18:32 -0400
Message-ID: <20140827141832.GB31879@peff.net>
References: <20140827075503.GA19521@peff.net>
 <CAP8UFD3Zk-Z+OWaCSfetSASYLBJ3kkDKYo2bB9QLJw8APTQPAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 16:19:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMe4T-00071V-AW
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 16:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934960AbaH0OSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 10:18:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:60075 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934828AbaH0OSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 10:18:34 -0400
Received: (qmail 1539 invoked by uid 102); 27 Aug 2014 14:18:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 09:18:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 10:18:32 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Zk-Z+OWaCSfetSASYLBJ3kkDKYo2bB9QLJw8APTQPAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255997>

On Wed, Aug 27, 2014 at 11:06:27AM +0200, Christian Couder wrote:

> On Wed, Aug 27, 2014 at 9:55 AM, Jeff King <peff@peff.net> wrote:
> >
> >   [2/6]: record_author_info: fix memory leak on malformed commit
> >   [3/6]: record_author_info: use find_commit_header
> 
> s/record_author_info/record_author_date/

Thanks. I think I just had determine_author_info on the mind when I
wrote the commit messages.

-Peff
