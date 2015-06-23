From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Tue, 23 Jun 2015 07:47:45 -0400
Message-ID: <20150623114745.GA3845@peff.net>
References: <20150623105042.GA10888@peff.net>
 <20150623105411.GB12518@peff.net>
 <CACsJy8AR_vZLAAKf4P+aEtKu1u35N8kAYtYLNOg55ET8DWeZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 13:47:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7MgC-0007yq-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 13:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbbFWLrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 07:47:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:50431 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932073AbbFWLrs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 07:47:48 -0400
Received: (qmail 23336 invoked by uid 102); 23 Jun 2015 11:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 06:47:47 -0500
Received: (qmail 18356 invoked by uid 107); 23 Jun 2015 11:47:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 07:47:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jun 2015 07:47:45 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AR_vZLAAKf4P+aEtKu1u35N8kAYtYLNOg55ET8DWeZUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272454>

On Tue, Jun 23, 2015 at 06:14:22PM +0700, Duy Nguyen wrote:

> > +       if (delete_redundant && repository_format_precious_objects)
> > +               die("cannot repack in a precious-objects repo");
> > +
> >         if (pack_kept_objects < 0)
> >                 pack_kept_objects = write_bitmaps;
> >
> 
> I know both commands have translatable strings that are not marked
> with _(). But if you reroll, maybe you could add _() for these new
> strings. It's even better if you mark all others in these commands
> too, if you have time.

Yeah, I agree these should be marked for translation. Thanks.

-Peff
