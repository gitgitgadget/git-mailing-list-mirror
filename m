From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to reorganize git tree
Date: Thu, 26 Jan 2012 15:27:32 -0800 (PST)
Message-ID: <m3ehumdoxs.fsf@localhost.localdomain>
References: <20120126133505.it34vehs0044o848@webmail.xnet.com>
	<1327604128-sup-1697@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Edwards <kae@xnet.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Jan 27 00:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqYjE-0005ic-3A
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 00:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab2AZX1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 18:27:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51710 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2AZX1f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 18:27:35 -0500
Received: by eaal13 with SMTP id l13so41658eaa.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 15:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kej40ANmFLbB0eOyLAQbrVg7UOoBIpSEaS2XnhKF3lg=;
        b=nDZHcKubthE/ibofUgXOhN8wWWQaFGTbrEtLxZcWhNUowCw7HjZW4zidl+RYazgMs+
         SLB/SPaN3GJdDvmnkA8fcSO05B03ddEkdNzjrCVr2JgtUaAl7+9QmLbiETbtDLpEo4ap
         +3M6iSakpPOPpOuxekoZIgCV8EGByOyE/UCGY=
Received: by 10.213.16.142 with SMTP id o14mr774167eba.144.1327620453842;
        Thu, 26 Jan 2012 15:27:33 -0800 (PST)
Received: from localhost.localdomain (abwp232.neoplus.adsl.tpnet.pl. [83.8.239.232])
        by mx.google.com with ESMTPS id w46sm21739464eeb.0.2012.01.26.15.27.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jan 2012 15:27:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0QNS03s015208;
	Fri, 27 Jan 2012 00:28:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0QNRxFE015205;
	Fri, 27 Jan 2012 00:27:59 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1327604128-sup-1697@pinkfloyd.chass.utoronto.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189173>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Excerpts from Alan Edwards's message of Thu Jan 26 13:35:05 -0500 2012:
> 
> Hi Alan,
> 
> > Any one have any suggestions?
> 
> I think that git filter-branch is going to be your friend here.  I
> won't prescribe the details as you should definitely read and
> understand the docs for this one, but things like
> --subdirectory-filter and/or --tree-filter will be of great use to
> you, I think.

Third-party git-subtree tool can also help here, I think.

-- 
Jakub Narebski
