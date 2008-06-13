From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 12:07:39 +0300
Message-ID: <20080613090739.GA8265@mithlond.arda.local>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil> <20080612041847.GB24868@sigill.intra.peff.net> <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil> <20080613054840.GA27122@sigill.intra.peff.net> <CA1D4ABE-0B83-44CC-B582-1E85784330AB@wincent.com> <bd6139dc0806130153u75c53b4do8e7b63f4a7f144e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jun 13 11:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K75Ib-000696-Cb
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 11:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbYFMJJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 05:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755271AbYFMJJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 05:09:26 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:45613 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754876AbYFMJJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 05:09:25 -0400
Received: from mithlond.arda.local (80.220.180.140) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F00C12287; Fri, 13 Jun 2008 12:07:46 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K75Fz-0002AE-7Z; Fri, 13 Jun 2008 12:07:39 +0300
Content-Disposition: inline
In-Reply-To: <bd6139dc0806130153u75c53b4do8e7b63f4a7f144e7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84854>

Sverre Rabbelier wrote (2008-06-13 10:53 +0200):

> On Fri, Jun 13, 2008 at 10:41 AM, Wincent Colaiuta <win@wincent.com>
> wrote:
> 
> > For me it is quite clear that stashing something _is_ asking for Git
> > to remember it. It's an explicit user action. It's a request to
> > remember something. Whether or not this is actually the best tool
> > for the job of long-term storage is much less important than the
> > fact that the user explicitly requested it.
[...]
> I agree fully with what Wincent is saying, stashes have an explicit
> way of cleaning them up:

I agree too. I didn't even know that stashes are currently expired
automatically. I don't use them that much but I'd expect that what
I explicitly ask to save stays there until I decide otherwise.
