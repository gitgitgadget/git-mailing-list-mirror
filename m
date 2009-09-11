From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] reset: add a few tests for "git reset --merge"
Date: Fri, 11 Sep 2009 07:22:13 +0200
Message-ID: <200909110722.13331.chriscool@tuxfamily.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.45063.chriscool@tuxfamily.org> <200909102259.16469.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:21:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlyZF-00068U-Ex
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbZIKFUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbZIKFUv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:20:51 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39234 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbZIKFUv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 01:20:51 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 21EFC8180D3;
	Fri, 11 Sep 2009 07:20:47 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3C53D8180E3;
	Fri, 11 Sep 2009 07:20:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200909102259.16469.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128172>

On Thursday 10 September 2009, Jakub Narebski wrote:
> Christian Couder wrote:
> > diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> > new file mode 100755
> > index 0000000..45714ae
> > --- /dev/null
> > +++ b/t/t7110-reset-merge.sh
> > @@ -0,0 +1,70 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2009 Christian Couder
> > +#
> > +
> > +test_description='Tests for "git reset --merge"'
> > +
> > +exec </dev/null
>
> What does this do?

Nothing! Yeah, this is a mistake. 

Thanks for spoting it,
Christian.
