From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 20:28:15 +0200
Organization: Dewire
Message-ID: <200705302028.15549.robin.rosenberg.lists@dewire.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com> <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com> <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Paolo Teti" <paolo.teti@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Lederhofer" <matled@gmx.net>,
	"Junio C Hamano" <junkio@cox.net>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 20:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtSxf-0002GH-HG
	for gcvg-git@gmane.org; Wed, 30 May 2007 20:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXE3Sbr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 14:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbXE3Sbr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 14:31:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:20320 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbXE3Sbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 14:31:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D4497802817;
	Wed, 30 May 2007 20:25:19 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22523-03; Wed, 30 May 2007 20:25:19 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 429278027FA;
	Wed, 30 May 2007 20:25:19 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48779>

onsdag 30 maj 2007 skrev Nguyen Thai Ngoc Duy:
> On 5/30/07, Paolo Teti <paolo.teti@gmail.com> wrote:
> > 2007/5/30, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> > > Hi,
> > >
> > > On clearcase dynamic views (kind of virtual drives), "mv -f a b" won't
> > > work if "a" is read-only. Because git-repack.sh removes all write
> > > permission before moving packs, it fails on clearcase dynamic views.
> > >
> > > My approach is rather ugly. Does anyone have a better solution?
> >
> > I hate clearcase, but honestly I have used it forced by a customer..
> > The real problem is why you need to do a repack in a CC view, but..
> 
> I don't like it either :) But you remind me the Matthias' workdir
> patchset. With that I can move out .git to a real drive/filesystem
> (which should also give better performance).
> 
> I think it's a valid use case. Anyone remember why Matthias' patchset
> was dropped?
> It was last mentioned in
> http://article.gmane.org/gmane.comp.version-control.git/43041
> 
> Junio, Matthias? May I help?

Wasn't because it's better to make .git a link to a repository somewhere 
else? Just a guess.

ln -s /somewhere/repo/.git .git

Works fine for me (yes, in a clearcase dynamic view).

BTW, Does anyone have something like git-cvsexportcommit for clearcase?

-- robin
