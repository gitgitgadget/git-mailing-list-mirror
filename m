From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Splitting a repository but sharing the common parts of the
 object database
Date: Mon, 13 Dec 2010 17:25:08 -0600
Message-ID: <20101213232508.GB32103@burratino>
References: <4D066873.4020208@cfl.rr.com>
 <20101213192053.GA30315@burratino>
 <4D06A98B.1060408@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Bash <bash@genarts.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 00:25:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSHlk-0003Uu-NM
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 00:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab0LMXZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 18:25:18 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59841 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab0LMXZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 18:25:17 -0500
Received: by qyj19 with SMTP id 19so4074145qyj.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 15:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TVcUec2yiHXrx52cPYYajOPSPIL8VK+JE+iXNanNBag=;
        b=vB5Orst43M+vmaQ0R1x7KNvx13yC4IDoASd7gGIqfIyqLTQZifkAFHtRmmnqoZUx+p
         oq291EvdLp4rJ4tbnICzlBBg7gUAiPrqlQAqULFwfTgjXS9SsGn5UhPYA76dV3QHJ1GR
         iSG1+Qpw0wgkdI79jWYUmjG5+8m169qD0nzXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EirmqOecJZwL6L9kSWSkN7cGkSUS3f1qtqRxXw7n4rNwcrSzVfdblJMvYQWJem6Pgi
         tXHOssuzJivk4pgprMbOC2kj3PLbKZIwK7/UQLnTs/5FhcIA8AM72mWJ9smMTsyrEBTr
         f0rh2AZJNSp9NN9JQ83ulTUMgIbL77WcT0HMc=
Received: by 10.224.73.137 with SMTP id q9mr4619728qaj.53.1292282716306;
        Mon, 13 Dec 2010 15:25:16 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id t17sm4364431qcp.26.2010.12.13.15.25.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 15:25:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D06A98B.1060408@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163604>

Phillip Susi wrote:

> Yes, -l looks like exactly what I need.  Now I don't suppose there
> is a way to make it sticky so I don't have to remember to use it
> when repacking every time?  :)

Maybe

	[alias "repackfork"]
		repack -a -d -f -l ...whatever other options are wanted...
