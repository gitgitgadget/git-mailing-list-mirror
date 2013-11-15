From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] add PERLLIB_EXTRA to add to default perl path
Date: Fri, 15 Nov 2013 13:06:04 -0800
Message-ID: <20131115210604.GC27781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 22:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhQam-0001rG-2H
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 22:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab3KOVGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 16:06:12 -0500
Received: from mail-gg0-f181.google.com ([209.85.161.181]:36174 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab3KOVGK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 16:06:10 -0500
X-Greylist: delayed 6360 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2013 16:06:10 EST
Received: by mail-gg0-f181.google.com with SMTP id h1so1703143gga.12
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 13:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=rZ4CZwaDUoj6gEOdawUNav0HQeKX4OyZqcsD7oYwKv4=;
        b=B0DdeTzLrOIh6+9EPfCtF/4dHgBBDGoqQlcglqzcyucWfHvz8vQs/xdRjX0jKozmUh
         CxOm5lu2BDKvEcl8U2KNdnxdpeU7yPrJcblj2MWfP5kaenAdipAF7T4v4BhTW+/+lY2l
         Du579eeeP9xaJ6sQ2JedGyb4oQ59iBfrDKQem0uKX8+cuVvvztyLYY6MiwQzYu/zozdI
         9y+6kPuRkVvCG+bEmRquYgGfbvBlqhz4yG/a5wAoeqGL/X6/h3qoCOIyq8twwdZ5xAwu
         nQPHXnXtzYqExo9Uk7+XFQAH8MJntppjSUxMs7SIAO1Tb4wh9uH/yRV0s+PXxFiMNfxU
         zImA==
X-Received: by 10.236.87.1 with SMTP id x1mr488433yhe.233.1384549569327;
        Fri, 15 Nov 2013 13:06:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 9sm7348068yhe.21.2013.11.15.13.06.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 13:06:07 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237915>

A small pair of patches, for your enjoyment.

Thoughts?

Jonathan Nieder (2):
  Makefile: rebuild perl scripts when perl paths change
  Makefile: add PERLLIB_EXTRA variable that adds to default perl path

 Makefile | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
