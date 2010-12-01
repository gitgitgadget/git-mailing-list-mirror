From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Wed, 1 Dec 2010 15:57:29 +0100
Message-ID: <201012011557.30849.jnareb@gmail.com>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net> <m3eia14mu7.fsf@localhost.localdomain> <20101201142920.GB6537@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 15:57:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNo7u-0004Fl-Tj
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 15:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab0LAO5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 09:57:42 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61375 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab0LAO5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 09:57:41 -0500
Received: by bwz15 with SMTP id 15so6196141bwz.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VpHDa7+7IQgTZxLGw8ARJy9VnQ1iU4sesP0VCj5vqU8=;
        b=vxQQHS3ZceDvTCJC6wexqjrVaXsvVWg8iNBNEulJojsJxbeU2gnzsYHzZJ1ln9SVG2
         rw9dgTWms2gJylWoq35cYQd6NcKG+qcFOiFcxHt1mAU38nyTrfsSRIOfEqD7SzPyAGuc
         AiRXdHYdh7uRMCyHrxzfxPRpS+qJSbVCOYotU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ibzh5wWQuR8bRSVhFkrRczwaO/EUCb5VIslWsqfS+sCP/KnL43jUCbc+LbfCFhVjO0
         88loKJk8FO5tFqkgNDGzvDjPFdboRFvJkopkSWauyhPFTRhp8L6bvaGgRF1yWBCXXmaE
         3cqLERYTe3hF3+lx3XSUVv3ZHMpIOiRsMjRUc=
Received: by 10.204.54.65 with SMTP id p1mr4759542bkg.100.1291215459727;
        Wed, 01 Dec 2010 06:57:39 -0800 (PST)
Received: from [192.168.1.13] (abvl90.neoplus.adsl.tpnet.pl [83.8.209.90])
        by mx.google.com with ESMTPS id a24sm899704fak.1.2010.12.01.06.57.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 06:57:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101201142920.GB6537@picasso.cante.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162524>

On Wed, 1 Dec 2010, Jari Aalto wrote:
> On 2010-12-01 05:58, Jakub Narebski wrote:
> | jari.aalto@cante.net writes:
> | 
> | > From: Jari Aalto <jari.aalto@cante.net>
> | > 
> | > 
> | > Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> | > ---
> | >  Documentation/config.txt | 1698 +++++++++++++++++++++++-----------------------
> | >  1 files changed, 852 insertions(+), 846 deletions(-)
> | 
> | Why?  What such large change is for?
> | 
> | Note that currently config variables are grouped by functionality: for
> | example core.eol and core.safecrlf, or core.compression and
> | core.loosecompression are close to each other.

What about the above?
 
> The phone books have an index where to up information.
> 
>     - When you see script and it use VARIABLE, you look it from
>       manual page

Manpages (and 'git <cmd> --help') are displayed in pager, so you can
always search for option in a pager (e.g. '/' in 'less', the default
pager).

> 
> It is same as putting option in alphabetical order. See GNU cp(1),
> ssh(1) etc.

In git documentation command line options are not in alphabetical order,
but grouped by functionality, therefore your argument is invalid.

See also GNU tar(1), rpm(8), uname(1) from coreutils, etc.

> 
> There are zillion values and for a reference, alphabetical order makes
> sense.

I agree that alphabetical order makes sense for glossary; I disagree that
it makes sense here.


Sidenote: we can always sort variables alphabetically using a script, but
reverse operation cannot be automated.
-- 
Jakub Narebski
Poland
