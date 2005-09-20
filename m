From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Ship our own copy of subprocess.py
Date: Tue, 20 Sep 2005 07:55:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509200753570.2553@g5.osdl.org>
References: <432F0C66.7060402@zytor.com> <20050919200222.GA11322@c165.ib.student.liu.se>
 <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com>
 <7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com>
 <20050919231704.GA19276@unpythonic.net> <432F48C7.8070405@zytor.com>
 <7v8xxsebsc.fsf@assigned-by-dhcp.cox.net> <7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>
 <20050920053024.GA12979@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 16:58:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHjXh-0000eV-Ir
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 16:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVITO4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 10:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVITO4E
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 10:56:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965024AbVITO4C (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 10:56:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8KEtkBo027213
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 07:55:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8KEtfvf020455;
	Tue, 20 Sep 2005 07:55:43 -0700
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050920053024.GA12979@c165.ib.student.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8998>



On Tue, 20 Sep 2005, Fredrik Kuivinen wrote:

> On Mon, Sep 19, 2005 at 09:39:48PM -0700, Junio C Hamano wrote:
> > Junio C Hamano <junkio@cox.net> writes:
> > 
> > >  - merge-recursive not requiring 2.4 but checking the result
> > >    from 'import subprocess', and optionally install its own
> > >    subprocess.py (I could do this myself but Fredrik could help
> > >    me);
> > 
> > I'll be cutting 0.99.7a with this, to help RHEL instalation.
> > Proofreading appreciated.
> > 
> 
> The patch looks good. I am obviously too slow for this kind of thing :)

Quick issue: the subprocess.py thing seems to be the old-style BSD license 
with the anti-advertizing clause. It's not compatible with the GPL.

Now, it's arguable that this is "mere aggregation" (git is bulding a 
mini-distribution), but still..

		Linus
