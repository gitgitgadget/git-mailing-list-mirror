From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Git ticket / issue tracking ERA: Git shouldn't allow to push a new
 branch called HEAD
Date: Tue, 22 Nov 2011 15:04:06 +0100
Message-ID: <1321970646.3289.19.camel@mastroc3.mobc3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 15:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSqvP-0008Hw-RZ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 15:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab1KVOCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 09:02:09 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49820 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab1KVOCI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 09:02:08 -0500
Received: by qyk2 with SMTP id 2so60157qyk.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 06:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:to:cc:date:content-type:x-mailer
         :content-transfer-encoding:mime-version;
        bh=ChYUf1phJl7J0sZBHB+tDQlr7+QmUAaFrWYrRoKCQ98=;
        b=bj5QJkqWwgzQtMJQl/quPleEmKEDeed2dTRSqi5otLJzBDNHyJfWINNyhV9H74MAd5
         aL6lG/e2ql8ixfPZ10+tUcI21WGiuRUIdCAm0CiGRa50oyFfpv4LYf9LYEcpu8WYFT4z
         1A/O8fKlwmpq7R/er9WZPXNXgKZlzDfKDT9g4=
Received: by 10.152.144.136 with SMTP id sm8mr11967280lab.33.1321970527312;
        Tue, 22 Nov 2011 06:02:07 -0800 (PST)
Received: from [192.168.1.64] (host244-74-dynamic.0-79-r.retail.telecomitalia.it. [79.0.74.244])
        by mx.google.com with ESMTPS id po16sm12832993lab.2.2011.11.22.06.02.04
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 06:02:06 -0800 (PST)
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185792>

On Mon, 2011-11-14 at 15:26 -0500, Jeff King wrote:
On Mon, Nov 14, 2011 at 12:22:59PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > So one solution is to block fetching of remote branches called
HEAD
> > > (which I would be OK with). But another is...
> > > ... Obviously there's a lot more to it than just tweaking the
default fetch
> > > refspecs. The ref lookup rules need to be changed to take this
into
> > > account. There was some discussion about this over the summer
(under the
> > > subject of possible "1.8.0" changes), but I don't think any work
has
> > > been done.
> > 
> > I would say discussing and ironing out the kinks of the design
counts as
> > work, but I agree nobody was seriously interested in laying out a
sensible
> > transition plan and discussion died out before anything concrete
happened.
> 
> Yeah, I should have said "...has been done since then".
> 
> > Regardless of the layout chanage, which probably is a 2.X topic, I
think a
> > good first step would be to start forbidding anything that ends with
_?HEAD
> > as a branch or tag name, on top of Michael's "enforce the refname
rules more
> > vigorously when a ref is created" series.
> 
> Agreed. Changing the layout is a long-term fix, and I think
disallowing
> HEAD is a reasonable stop-gap measure.

Hi,

I pretty much agree with you that this is the right solution in the
long-term.

But how are you going to remember this?
Is there an issue tracking?
Do you use some other kind of ticketing system?

Since the *official* repo is now hosted on github, why don't making use
of the github ticketing system? [1]

You probably already discussed this tons of times but I can't figure out
how you are gonna remember to do something if you don't have a roadmap
and a ticketing system that allow you to trace the bugs and features.

Do you have to dig into the mailing list archive to look for the
previous discussion?

This is actually just out of curiosity, sorry if this hurt someones
feeling.


Thanks and regards,
Daniele Segato


[1] according to http://git-scm.com/ the link on "Git source repository"
is https://github.com/gitster/git
