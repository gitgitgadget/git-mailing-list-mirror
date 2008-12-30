From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: why still no empty directory support in git
Date: Mon, 29 Dec 2008 21:28:58 -0800
Message-ID: <3ab397d0812292128j65e2e1e1xf403a998f4653aac@mail.gmail.com>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
	 <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Asheesh Laroia" <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 06:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHXBV-0007aR-Pc
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 06:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbYL3F3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 00:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbYL3F3A
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 00:29:00 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:38457 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYL3F27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 00:28:59 -0500
Received: by qw-out-2122.google.com with SMTP id 3so4005712qwe.37
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 21:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nPA7QmvjxWDNNBCV2IkYJBQPpSHouU6pbMjJtqux8PA=;
        b=PHXb+cS9MnJM08t9SMNsguCl9rZNrJTXZXdVMAvfD/6djqfmm88C7qtniiEv4Ol5qa
         TMZNPLDL99d3q1CJBMDTPNhwWpR00xdXQ28oyouu7HJz3fFDfH+MzfOo4mGJP229vuBq
         XvMQaeHjijTv0vxPrYTkr09FeSGo7vEXyKIlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xs0wMr09aHUTwt9+sXn1N7xvT2yst6eIlLky0lEpy5T5Yvd+uoxBwsV+jnE0GNziDW
         bYUcWR3F+ZmdQUfAWTJqDw2oE1flTyBe7+7SxlcH9y63SpezLfWhpg3R1Sl47NwLCdt4
         6ixjx8cU+8V0a78scRtNDB6xVnLEaLjauyX2s=
Received: by 10.215.39.20 with SMTP id r20mr11988225qaj.216.1230614938563;
        Mon, 29 Dec 2008 21:28:58 -0800 (PST)
Received: by 10.215.41.3 with HTTP; Mon, 29 Dec 2008 21:28:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104159>

funny, i thought it was 1, by design.

but i forget why a tree object couldn't point to an empty blob.
