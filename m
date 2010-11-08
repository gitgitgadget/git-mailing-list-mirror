From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Run global hooks from the directory at hooks.dir
Date: Mon, 8 Nov 2010 11:13:11 -0600
Message-ID: <20101108171311.GA3619@burratino>
References: <1289219520-37435-1-git-send-email-bricollins@gmail.com>
 <4CD7FB37.4050107@viscovery.net>
 <AANLkTi=kFuoaV5Ur_a7FJPg_oUs3svOpq=wEVhdpuoai@mail.gmail.com>
 <AANLkTikJACZxf6socuvXFMu7WUZ0y+s0ZRA2kYEKb19q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, s-beyer@gmx.net,
	git@vger.kernel.org
To: Brian Collins <bricollins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 18:13:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFVHj-0007PZ-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 18:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab0KHRN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 12:13:29 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46445 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab0KHRN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 12:13:29 -0500
Received: by pvb32 with SMTP id 32so1333197pvb.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zlJm0wXjnMRMFiCGhbB8G9jhFqJ9WztAlCyJQz3jgK8=;
        b=B/ZCxH2AsaTlPNCTddNESiojPEbNwWODWtS2G5hy5L8vPxR4a7NZEdt3EYtvEHpjQa
         GJjqkxD9kXO3xrXz9VlHeoGBVOG08lTAJe0nH9c3h8sqNnOYiwyEURo7ARgHJNmNF/pl
         O2Qi6ANFIt3lnFUvZy+PHixWB+2BgRcTPaE9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Od3T11P39sQBHH+Z1RuPkbCXff6OzVri06ZDdOYMAPGK+I8AljXDgqpHymcTZcmHGD
         5Sp8zAnHxTNACDKHh0xKHi8BGwdd5KSrF2M6MwfsYVci8xiewu06Uf1tA/Cg7BTpA4gQ
         otZnv+HIeFZF41qr+xXBj3BaDqBS11llp1GtQ=
Received: by 10.229.84.203 with SMTP id k11mr5345545qcl.56.1289236407900;
        Mon, 08 Nov 2010 09:13:27 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v39sm2555166yba.19.2010.11.08.09.13.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 09:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikJACZxf6socuvXFMu7WUZ0y+s0ZRA2kYEKb19q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160947>

Brian Collins wrote:

>                                                     Using templates is not
> ideal because it is system-wide and they still need to be renamed for every
> clone or init.

Why do they have to be renamed?  And can we do better?
