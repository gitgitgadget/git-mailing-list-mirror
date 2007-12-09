From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: git-svn branch naming question
Date: Sat, 08 Dec 2007 21:16:09 -0800
Message-ID: <1197177369.32435.1.camel@brick>
References: <20071208010438.GE3199@genesis.frugalware.org>
	 <20071208105901.GA2844@xp.machine.xx>
	 <20071208141449.GH3199@genesis.frugalware.org>
	 <20071208165657.GC2844@xp.machine.xx>
	 <20071208235248.GK3199@genesis.frugalware.org>
	 <20071209020510.GM3199@genesis.frugalware.org>
	 <20071209022624.GA31033@soma>
	 <20071209023600.GP3199@genesis.frugalware.org>
	 <20071209032608.GB31033@soma>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 09 06:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1EWo-00080S-7W
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 06:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbXLIFQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 00:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbXLIFQL
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 00:16:11 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:49994 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbXLIFQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 00:16:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1223971rvb
        for <git@vger.kernel.org>; Sat, 08 Dec 2007 21:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=KRSmEa+/ZGGfLBef0qriS2Cj32Mxe2BBExbnfXUF64A=;
        b=RzHUSSh7T8HahRiCJYoarnzJcYw/JFtyaXPernhYf5lAdBvqVfKMqK5BZGvNH2K37jmM1D8uVvKRPWVy2mR6YKMa8fWo3iMRGJmwU9gHRShI+yXzXUxIH8RbbtU7JwKuhQeq0CnRma9nkPTo/VZuH5AAXeMxCUl9RNLguQp/sow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=OkNLcp6xoYcqcWlq4WWgDCf2LHlTjCfhwhwl+Au7uBmBMrqzHKq1gIe7sh+m0ZEti4QAgqwP3pnYxfmTUmnhVFlIDN/11xB/15qJeNo3c2OklcjEntMyng59lD9zKKgi6bUdYkzTEBn4hdfnMnolIgzewJs5j6uyOltZ778uDUw=
Received: by 10.141.193.1 with SMTP id v1mr3509002rvp.1197177367387;
        Sat, 08 Dec 2007 21:16:07 -0800 (PST)
Received: from ?192.168.1.124? ( [216.19.190.48])
        by mx.google.com with ESMTPS id l21sm2903655rvb.2007.12.08.21.16.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Dec 2007 21:16:06 -0800 (PST)
In-Reply-To: <20071209032608.GB31033@soma>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67595>

On Sat, 2007-12-08 at 19:26 -0800, Eric Wong wrote:

> 
> Perhaps git-clone could gain the ability to clone refs/remotes/ as-is
> without an extra step?
> 

Something in the spirit of --mirror perhaps?  

--mirror-remotes sounds about right

Harvey
