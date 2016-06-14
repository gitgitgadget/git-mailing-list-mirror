From: Jeff King <peff@peff.net>
Subject: Re: I lost my commit signature
Date: Tue, 14 Jun 2016 04:18:55 -0400
Message-ID: <20160614081854.GA13457@sigill.intra.peff.net>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net>
 <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: ZhenTian <loooseleaves@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 10:19:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCjYv-0007pr-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 10:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbcFNITA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 04:19:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:54444 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750886AbcFNIS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 04:18:58 -0400
Received: (qmail 13232 invoked by uid 102); 14 Jun 2016 08:18:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 04:18:57 -0400
Received: (qmail 26125 invoked by uid 107); 14 Jun 2016 08:19:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 04:19:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 04:18:55 -0400
Content-Disposition: inline
In-Reply-To: <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297273>

On Tue, Jun 14, 2016 at 04:09:52PM +0800, ZhenTian wrote:

> I have tested sign my work in another project, it works fine, I have
> committed five times, all commits are signed.
> 
> I can't find encoded signature block in the output of "git cat-file
> commit HEAD", only these:
> ```
> tree 17a572e349ce2fda47470951b5011b9c2f6533b7
> parent 2c35701725d34325520acb9b45daf42f64adc536
> author TianZhen <tianzhen@honovation.com> 1465887785 +0800
> committer TianZhen <tianzhen@honovation.com> 1465887791 +0800
> 
> feat: mobile support free freight hint, closed #1417
> ```
> 
> Some of my commits are signed, for example I have committed four times
> today, only first commit is signed. Is it possible some issue with
> gpg-agent? I can't find it via `ps -Af | grep gpg`.

Possibly. If you set gpg.program "gpg -v", does it help? You could also
try setting it to "gpg | /tmp/log" to see what gpg is passing back to
git.

-Peff
