From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Tue, 24 Nov 2015 16:48:42 -0500
Message-ID: <20151124214842.GA4848@sigill.intra.peff.net>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 22:48:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1LSB-00015F-M3
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 22:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbbKXVsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 16:48:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:33453 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754013AbbKXVsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 16:48:45 -0500
Received: (qmail 24863 invoked by uid 102); 24 Nov 2015 21:48:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:48:44 -0600
Received: (qmail 18664 invoked by uid 107); 24 Nov 2015 21:48:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:48:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 16:48:42 -0500
Content-Disposition: inline
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281634>

On Thu, Nov 12, 2015 at 01:14:26AM +0530, Karthik Nayak wrote:

> Karthik Nayak (10):
>   ref-filter: introduce a parsing function for each atom in valid_atom
>   ref-filter: introduce struct used_atom
>   ref-fitler: bump match_atom() name to the top
>   ref-filter: skip deref specifier in match_atom_name()
>   ref-filter: introduce color_atom_parser()
>   strbuf: introduce strbuf_split_str_without_term()
>   ref-filter: introduce align_atom_parser()
>   ref-filter: introduce remote_ref_atom_parser()
>   ref-filter: introduce contents_atom_parser()
>   ref-filter: introduce objectname_atom_parser()

Hmm, your patch 10 does not seem to have made it to the list (at least I
did not ever get it, and gmane seems to be down, so I cannot check there).

-Peff
