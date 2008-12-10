From: rdkrsr <rdkrsr@googlemail.com>
Subject: after first git clone of linux kernel repository there are changed files in working dir
Date: Wed, 10 Dec 2008 19:22:46 +0100
Message-ID: <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 19:24:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LATjD-0004h1-Nj
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 19:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbYLJSWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 13:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbYLJSWt
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 13:22:49 -0500
Received: from po-out-1718.google.com ([72.14.252.154]:50321 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbYLJSWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 13:22:48 -0500
Received: by po-out-1718.google.com with SMTP id y22so815672pof.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PFTD6MdSNCyJOqwZPZhnoElSXu9c3qUiIFM4XBKMN0I=;
        b=V8vosEyWglOhD+qi5rstltW0bWJKfwQblfCNLQw7NG+Npb0yvpY2BIo1jaO9/bx6Lj
         vkBpTuxD6U81SV/Z7jdUTjkp6cb4snDc+x2S7b9x5dL8dArJ7G0Y9BR0PHc5tEw5bBYr
         tfS1R4+xHqUviB8jDWrkH7rOVn8AGoEaxlZYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=es2al5qJo6Z8E3x8o94DaohnrKT+yhEE3Bs056W+7w/hMoBY18Nx+Sap4wECQGfA+x
         uu83Wl3AYVAGxYfsiH4ngmX7lsahD9lidVHuynTyz0uRP1Zl+3Un1W1lsXArXJjFdV0E
         SGUQFMXrAvgTlLPAbfcZe7smL4uaE2j/1lhmY=
Received: by 10.141.195.5 with SMTP id x5mr787473rvp.168.1228933366647;
        Wed, 10 Dec 2008 10:22:46 -0800 (PST)
Received: by 10.140.172.16 with HTTP; Wed, 10 Dec 2008 10:22:46 -0800 (PST)
In-Reply-To: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just fetched the sources without changing anything, but git diff
shows, that there are changes that are not yet updated (changed but not
updated: use git add to ...). Why is it like that?

I use msysgit on windows, maybe that is one reason?
