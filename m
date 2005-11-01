From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-mv dest ending with slash would deletes file only
Date: Tue, 1 Nov 2005 23:46:42 +0100
Message-ID: <200511012346.42640.Josef.Weidendorfer@gmx.de>
References: <4366ECF1.1010401@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 01 23:07:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX4GP-0003XU-6g
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 23:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVKAWFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 17:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVKAWFu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 17:05:50 -0500
Received: from pop.gmx.net ([213.165.64.20]:37849 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751337AbVKAWFt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 17:05:49 -0500
Received: (qmail invoked by alias); 01 Nov 2005 22:05:48 -0000
Received: from p54969405.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.148.5]
  by mail.gmx.net (mp022) with SMTP; 01 Nov 2005 23:05:48 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <4366ECF1.1010401@ust.hk>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10959>

On Tuesday 01 November 2005 05:20, Ben Lau wrote:
> $ git-mv entry.c Documentation/
> Ignoring path Documentation//entry.c

Instead of mangling all destination paths, I only
would strip a trailing slash of the destination argument.
See my other mail with the patch.

Thanks for noting this bug,
Josef
