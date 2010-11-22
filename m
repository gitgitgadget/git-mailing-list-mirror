From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH] contrib/svn-fe: Fast script to remap svn history
Date: Mon, 22 Nov 2010 09:01:17 -0500 (EST)
Message-ID: <15144262.32618.1290434477881.JavaMail.root@mail.hq.genarts.com>
References: <20101121051734.GA11856@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 15:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKWxa-00042h-B4
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 15:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab0KVOBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 09:01:25 -0500
Received: from hq.genarts.com ([173.9.65.1]:35682 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754604Ab0KVOBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 09:01:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id EED281E2632C;
	Mon, 22 Nov 2010 09:01:23 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id znMUY76bJBiH; Mon, 22 Nov 2010 09:01:18 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id F1D831E262F9;
	Mon, 22 Nov 2010 09:01:17 -0500 (EST)
In-Reply-To: <20101121051734.GA11856@burratino>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161894>

----- Original Message -----
> From: "Jonathan Nieder" <jrnieder@gmail.com>
> Sent: Sunday, November 21, 2010 12:17:34 AM
> Subject: Re: [PATCH] contrib/svn-fe: Fast script to remap svn history
> 
> Maybe we could benefit from including the copyfrom information in the
> fast-import stream output by svn-fe somehow?

This has been discussed (and IMO it is essentially required to achieve high accuracy in the mapping):

http://thread.gmane.org/gmane.comp.version-control.git/158940/focus=159331

Thanks,
Stephen
