From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Sat, 13 Aug 2005 10:54:21 +1200
Message-ID: <46a038f905081215547618441c@mail.gmail.com>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	 <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	 <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
	 <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
	 <pan.2005.08.10.21.15.41.143251@smurf.noris.de>
	 <pan.2005.08.10.22.11.25.242201@smurf.noris.de>
	 <7vd5olqtvp.fsf@assigned-by-dhcp.cox.net>
	 <20050810235436.GW28270@kiste.smurf.noris.de>
	 <7vpssiucss.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:55:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3iQC-0001BT-Ge
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 00:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVHLWyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 18:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVHLWyW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 18:54:22 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:31383 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751298AbVHLWyW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 18:54:22 -0400
Received: by rproxy.gmail.com with SMTP id i8so524215rne
        for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:54:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N4DFnwziFBLNueAQ/9Va2DuZg9ClDIbVL2OsNk5Kzo7U5ZlJykXVdPvHha/1+Dc6VmidHreVYVywuTuBtHjLVl5lMkJpJ7Z6sJ2EBoGA3KdwO2YEufBn1oMR92vl7Th9fnxfVI7e6HHqg68sYL3QtKj0gLVrDLz3zvYswskimcs=
Received: by 10.38.75.11 with SMTP id x11mr972372rna;
        Fri, 12 Aug 2005 15:54:21 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 12 Aug 2005 15:54:21 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpssiucss.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> I just noticed from "dpkg --info" output that the generated
> git-tk has "Architecture: i386".  Shouldn't it read "all" and
> resulting package also named git-tk_${VERSION}_all.deb, instead
> of whatever architecture I happened to build it?

It is correct to have Architecture: i386, as you'd naturally have
multiple binary packages. When this is uploaded to the Debian archive,
all the other architectures are built in the "buildd" farm. That's why
the source package 'native' arch is 'any'.

Packages with arch 'all' are interpreted languages. The cogito package
will probably be for 'all' arches, and just be one binary package.

cheers,


martin
