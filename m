From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5/RFC 3/6] gitweb: Add manpage for gitweb
Date: Mon, 10 Oct 2011 17:18:11 -0500
Message-ID: <20111010221811.GA21367@elie.hsd1.il.comcast.net>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
 <1318098723-12813-4-git-send-email-jnareb@gmail.com>
 <7vr52kk1jj.fsf@alter.siamese.dyndns.org>
 <201110110002.24665.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 00:18:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDOB0-0007BT-Dm
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 00:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab1JJWSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 18:18:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58703 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab1JJWSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 18:18:20 -0400
Received: by gyg10 with SMTP id 10so5812999gyg.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gpL80DY95s+Hfq+P2hdK8CdOnFoA/BSij240VBV0VHc=;
        b=gnMUDpk91l/THbf+v40A3EZ0jhmTYzGiduaU502NfJY4CkqM9u6EQJTc6XGqrmRSbA
         yLiBBpjDn3zQGTcDJA9ARRhy6vUpBH6nI+4AVu0k7vQAGPB+RipVW8G9yM8pYFB7IJ7n
         vQjWBtfNuBWqd0ENVgwnwfc+ACae384TTbwRg=
Received: by 10.146.2.5 with SMTP id 5mr4030721yab.27.1318285100015;
        Mon, 10 Oct 2011 15:18:20 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id e19sm56160718anm.6.2011.10.10.15.18.17
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Oct 2011 15:18:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201110110002.24665.jnareb@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183262>

Jakub Narebski wrote:

> The problem is that catering to old AsciiDoc (but still used by some of
> long-term-support Linux distributions) requires to have "SYNOPSIS"
> section... but there is no natural synopsis for non self-hostable web
> application, is there?

I personally think something like

	SYNOPSIS
	--------
	/usr/share/gitweb/gitweb.cgi
	git instaweb

or perhaps something like

	SYNOPSIS
	--------
	http://<site>/?p=<project>.git;a=<action>;h=<object>;<parameters>
	http://<site>/<project>/<action>/<object>?<parameters>

would be best.
