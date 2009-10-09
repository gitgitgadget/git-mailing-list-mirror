From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Fri, 9 Oct 2009 19:21:49 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20091009152149.GA26171@tugrik.mns.mnsspb.ru>
References: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091005165802.GA24402@tugrik.mns.mnsspb.ru> <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091008132718.GA12161@tugrik.mns.mnsspb.ru> <20091008150206.GD9261@spearce.org> <20091009090958.GA4758@tugrik.mns.mnsspb.ru> <20091009144606.GT9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 17:29:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwHOx-0000ET-K3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933444AbZJIPXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 11:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933207AbZJIPXv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:23:51 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:50790 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932297AbZJIPXu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:23:50 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1MwHIm-000123-Oq; Fri, 09 Oct 2009 19:22:40 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1MwHHx-0006uG-Am; Fri, 09 Oct 2009 19:21:49 +0400
Content-Disposition: inline
In-Reply-To: <20091009144606.GT9261@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129817>

On Fri, Oct 09, 2009 at 07:46:06AM -0700, Shawn O. Pearce wrote:
> Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > On Thu, Oct 08, 2009 at 08:02:06AM -0700, Shawn O. Pearce wrote:
> > > We probably should place a quick comment here to remind folks tha=
t
> > > they need to build the script in order to test it properly.
> >=20
> > I've added some sort of protection, so that git-completion.bash.in =
can't
> > be sourced at all. Is it ok?
>=20
> Yes, looks fine.

Thanks.

> > Subject: [PATCH 2/2] bash: make git-completion.bash.generate bash a=
gnostic
>=20
> Squash this into the first patch and add the egrep change made by
> Stephen Boyd "[PATCH 1/2] completion: fix completion of git <TAB><TAB=
>".

While it is technically easy to do so, isn't this a bad idea to squash
semantic changes and fixes into something which should be as close as
code movement? Especially Stephen's fix?

Sure you are the maintainer, but maybe let's apply this 3 patches as
separate ones? I don't insist - this is just my 1=D0=BA=D0=BE=D0=BF.

Kirill
