From: "Shun Kei Leung" <kevinlsk@gmail.com>
Subject: Re: [PATCH] Fix regression in fast-import.c due to strbufs.
Date: Mon, 29 Oct 2007 10:59:02 +0800
Message-ID: <e66701d40710281959q517eabecm87bcf54c7fe47741@mail.gmail.com>
References: <de47e4420710251726nb45a19fk15b3105b735a74f8@mail.gmail.com>
	 <de47e4420710251729j5858481cg69146385a2ed798d@mail.gmail.com>
	 <20071026065301.GL14735@spearce.org>
	 <20071026075912.GA25365@artemis.corp>
	 <20071026172523.GB5496@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git ML" <git@vger.kernel.org>
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 03:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImKqW-0008A2-VJ
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 03:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbXJ2C7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 22:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbXJ2C7F
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 22:59:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:45165 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbXJ2C7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 22:59:03 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1604118wxd
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 19:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qfTzTJTq+oPNwe8qooJ4jfFZ35COYqVClPqtETbS5t8=;
        b=Sn2QIOt/r/85cCrnN2+5VzZrPvkZffHhVJFL3ZP0sJrr8RDBS2eiga7OBVmuCR08iT1kYfZjKMV8/ciAV8+LmhPlK5dPXfo54E2fmptJhQj+BrIJUOIb7NB1f7/4dvoowboXX+G5dwrYP/7ccTncbph9jPX4NF01Aa9AiAc9UjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ayMbwIBiGj8u0nN0SrdO0epTxLpLLGWBaNovLbY+9P1n2paFLQJpFuWsb8bXE29+dpzkjVe/7dwlbYHHMmTg7nk5SI03tkt6qn1WKDW2Yq2rOf477kjLpKF971JMWbr5237MUTfuQIlwhBXhqQEosu5dgsHnuNHUzo9ETLvD65s=
Received: by 10.70.117.3 with SMTP id p3mr465083wxc.1193626742750;
        Sun, 28 Oct 2007 19:59:02 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Sun, 28 Oct 2007 19:59:02 -0700 (PDT)
In-Reply-To: <20071026172523.GB5496@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62595>

Hi Pierre,

Thanks. You are the man! It works perfectly now.

Regards,
Kevin
