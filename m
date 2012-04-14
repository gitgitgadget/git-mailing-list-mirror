From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Explain how svn-fe parses filenames in SVN dumps
Date: Sat, 14 Apr 2012 13:13:57 -0500
Message-ID: <20120414181357.GA4560@burratino>
References: <4F89ADCD.6000109@pileofstuff.org>
 <20120414171431.GA4161@burratino>
 <4F89B5C5.3030606@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 20:14:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ7UB-0003Up-JP
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 20:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab2DNSOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 14:14:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53933 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab2DNSOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 14:14:04 -0400
Received: by iagz16 with SMTP id z16so5634644iag.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ROYbkf2qcpNW+RoxTzJHohKiFoWMoFbdjtcmZv9OI+0=;
        b=zKxhA+9/nd8A3L+1OkQG/WLGwBNQBva6TkwkmTxLbBhyChZycPe/tVlS75biL5/6tu
         t0x4wjx+QtcCDuY31y7n3XQTxWa1NksXVjgVxHevuatn8friMv/inifNVQwVeJPtjb5b
         ZHpnlABFFKb6yH9P0ggBaHothpawg0mnL4+a2IIpIKzP5v20p07zqG8LGr1KO3TBTX8w
         sqZHP87d4/2t5sCJDF4N45GZQ5Q2YBJ5rz+4wW9NgE2/FhFNLVig/nbQgJlor/ue1eBj
         VtRFgZY0tHGgoRsIVvQ6s7ln7J4UMK+dL6RqOGGFrwHTR9TH6O8BP+W94M72B64YnaTd
         89Fg==
Received: by 10.50.40.228 with SMTP id a4mr1659985igl.60.1334427243485;
        Sat, 14 Apr 2012 11:14:03 -0700 (PDT)
Received: from burratino (remote.soliantconsulting.com. [67.109.75.130])
        by mx.google.com with ESMTPS id c2sm7892555igj.1.2012.04.14.11.14.02
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 11:14:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F89B5C5.3030606@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195499>

Andrew Sayers wrote:

> If this were a man page

This is a man page.  "git log contrib/svn-fe/svn-fe.txt" has details.
