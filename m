From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Mon, 12 Sep 2005 16:06:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121603490.3266@g5.osdl.org>
References: <20050912181101.GA22221@vrfy.org> <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org>
 <20050912195947.GA28502@vrfy.org> <Pine.LNX.4.58.0509121316030.3266@g5.osdl.org>
 <20050912210006.GA32211@vrfy.org> <Pine.LNX.4.58.0509121438150.3266@g5.osdl.org>
 <20050912225032.GA8360@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EExNS-0001Ke-Dy
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 01:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVILXGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 19:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVILXGP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 19:06:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932339AbVILXGO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 19:06:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CN6DBo029210
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 16:06:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CN685t026701;
	Mon, 12 Sep 2005 16:06:10 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050912225032.GA8360@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8449>



On Tue, 13 Sep 2005, Kay Sievers wrote:
> 
> But why does --pretty=raw mangle the text with spaces?
> Well the output of this  weird word combination may be "pretty" but definitely
> not "raw". :)

git-rev-list always makes sure that the header is clearly separated. We 
could have a "really-raw" format, of course, but..

> And I would prefer --pretty=raw with '\0' termination instead of '\n' so I can
> replace the output from --header with --pretty=raw and can still use the same
> parsing routine.

Dang. That's one of the few programs that don't take -z.

We could add it, but then you'd have to wait for that to percolate out 
again..

		Linus
