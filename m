From: Chris Wright <chrisw@osdl.org>
Subject: Re: Ship our own copy of subprocess.py
Date: Mon, 19 Sep 2005 23:14:13 -0700
Message-ID: <20050920061413.GP8041@shell0.pdx.osdl.net>
References: <432F0C66.7060402@zytor.com> <20050919200222.GA11322@c165.ib.student.liu.se> <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com> <7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com> <20050919231704.GA19276@unpythonic.net> <432F48C7.8070405@zytor.com> <7v8xxsebsc.fsf@assigned-by-dhcp.cox.net> <7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 08:16:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHbOp-0003kG-6w
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 08:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVITGOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 02:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVITGOV
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 02:14:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932587AbVITGOU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 02:14:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8K6EDBo007924
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 23:14:13 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8K6EDfI006092;
	Mon, 19 Sep 2005 23:14:13 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8K6EDbA006091;
	Mon, 19 Sep 2005 23:14:13 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8979>

* Junio C Hamano (junkio@cox.net) wrote:
> I'll be cutting 0.99.7a with this, to help RHEL instalation.
> Proofreading appreciated.
> ------------
> so people without the latest Python could run merge-recursive.

Sorry I don't think this one will work.  It's not going to install
compat/subprocess.py, and if it did, I don't think it'd be able to import
(how will it find subprocess.py?).

thanks,
-chris
