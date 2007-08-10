From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 13:40:28 +0200
Message-ID: <81b0412b0708100440l116f934ft22d3ac3c71e2e7cf@mail.gmail.com>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de>
	 <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de>
	 <20070810053158.GJ24573@spearce.org>
	 <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de>
	 <Pine.LNX.4.64.0708101113380.21857@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 13:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJSrM-0007Gx-TA
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 13:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763803AbXHJLkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 07:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763749AbXHJLkb
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 07:40:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:33416 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763723AbXHJLka (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 07:40:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so229495nfb
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 04:40:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p9UdBVx1PfwuF9TCmCOJsAtRyQFFOuykt2smXFHooSHnlm7oe8y3qTRDINupgmZZa6cHt2ki5WGgiMK7IidVFvObPaKhrsxhwE6tmsreGOOQI5bB7gJVBahxo55sVYw7CJIt9IurHRf+DNfht4ge3lc1jwnjaToXiw6wUq/T00Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5KIJbLQbc0yxd0VzWnSV3HKtuDaCJPz64SmMM60OQ4P5J3esBZ3LYnNxXkX/msEMzbXRlQiezfFLDAv/+WGFoff6guhqn9aofefEVXmPrMqX+4RbmNvRwo1cYi3TGVbdU1+gITtaQQSYySoqpO7mbc+gnTUpZSzbld0j7CHr30=
Received: by 10.78.149.15 with SMTP id w15mr1224047hud.1186746028489;
        Fri, 10 Aug 2007 04:40:28 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 10 Aug 2007 04:40:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708101113380.21857@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55531>

On 8/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 10 Aug 2007, Steffen Prohaska wrote:
>
> > I recognized that '.' is included in the PATH in /etc/profile.
> > I don't think this is a good idea. At least it bit me once when
> > I expected to run /bin/git but instead /git/./git was chosen.
> > Shouldn't we remove '.' from the PATH?
>
> In my experience, Windows users (not Mac users forced to use Windows)
> _expect_ "." to be in the PATH.

...because they _cannot_ know otherwise. In Windows, you cannot remove "."
from PATH, it is implicitly in it.
It is actually worse than that: the system directories are in PATH
too. Unconditionally.
Yes, the same system directories all them programs put their .exes into.
