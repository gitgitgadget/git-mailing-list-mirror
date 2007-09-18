From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 08:12:42 +0200
Message-ID: <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	 <11900461843997-git-send-email-hjemli@gmail.com>
	 <20070918005013.GA6368@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Chris Shoemaker" <c.shoemaker@cox.net>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXWKH-0007Ng-UI
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 08:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbXIRGMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 02:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481AbXIRGMp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 02:12:45 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:28202 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbXIRGMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 02:12:45 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1511141rvb
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 23:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=B7EPXBTyVBTWlmAD1UrRNjeozUuTZKUvWGOusZ2dv+w=;
        b=E34Kay3xfB34CToqF6DmQdqKnmlRM3vx6EEGjdxlca83Vo4YFCNFm3MwLQJyGYgSySAlZwTzZVnUvHLZoHzrzCRFoRoyeGdCfAI+4XL0r2h7kYSJZehUsSe1y72ETQKssxxJKzRjvGxsneDnnr2Sr4qWaR+1cAJJExl8gxApsTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aI+rWWxAqfJn1q0jxBd85KJCoQ6vKxg9AtKhCyCZagkqPI+zh62MPda3cUgsfY8VuRaerJf/48W34rGau9pfSZx4Ks1eV7EihT6TjhC78gWL6bK1ORu2pfvBH8+mHVnXUu/II5NFANRIZ94MTiz6ddjd55ue6vTJNEAmPsXd/xc=
Received: by 10.114.80.4 with SMTP id d4mr3570940wab.1190095962840;
        Mon, 17 Sep 2007 23:12:42 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 17 Sep 2007 23:12:42 -0700 (PDT)
In-Reply-To: <20070918005013.GA6368@muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58527>

On 9/18/07, Eric Wong <normalperson@yhbt.net> wrote:
> Would automatically enabling --no-ff when it detects merging of two (or
> more) SVN branches be a good thing?

I'd say 'git-svn merge' as a wrapper for 'git merge --no-ff' would be cleaner.

--
larsh
