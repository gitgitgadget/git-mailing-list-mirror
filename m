From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 21:01:44 +0200
Message-ID: <20050427190144.GA28848@cip.informatik.uni-erlangen.de>
References: <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com> <871x8wb6w4.fsf@deneb.enyo.de> <20050427151357.GH1087@cip.informatik.uni-erlangen.de> <426FDFCD.6000309@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Weimer <fw@DENEB.ENYO.DE>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
	mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 20:59:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQrj9-0007nl-8w
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 20:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVD0TC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 15:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVD0TC2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 15:02:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:59094 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261961AbVD0TCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 15:02:14 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3RJ1jS8007136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 19:01:45 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3RJ1ixM007135;
	Wed, 27 Apr 2005 21:01:44 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Florian Weimer <fw@DENEB.ENYO.DE>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
	mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <426FDFCD.6000309@zytor.com>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Directory hashing slows down operations that do linear sweeps through 
> the filesystem reading every single file, simply because without 
> dir_index, there is likely to be a correlation between inode order and 
> directory order, whereas with dir_index, readdir() returns entries in 
> hash order.

thank you for the awareness training. Than mutt should be slower, too.
Maybe I should repeat that tests.

	Thomas
