From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 6/6] web--browse: look at the BROWSER env var
Date: Mon, 6 Dec 2010 11:59:14 -0600
Message-ID: <20101206175914.GD6272@burratino>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291657790-3719-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 18:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfLV-0002xc-5z
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab0LFR7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:59:23 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38679 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab0LFR7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:59:22 -0500
Received: by vws16 with SMTP id 16so2768871vws.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3IyctmqXMn/JWHTB+BGDDZ/6hxC76roKJLz9IdFmPFM=;
        b=gF9CBpKCq19Fis5KqQw2/ZhsnEeqCA6YqvLyqBIlUSQdtJvWg4eoAlQ2ydRHhi8fD8
         wlOvKw9Z3J6V9yeGjXvsF2KPfHLRWTNrMm+80hbQVTS3bk5DFC1iuCjSGx9kNbDlMlbN
         3y0zrGQY+UGcThpc8TczdW5C2mYNr5v7JVErE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jCD/vv79aUwyrMmudEblZXtxpfM1pmH5CziWJ5JVRz79Cgo1wTleCnsew4CARWcnST
         l9pA2/L4+9ymooPhWjULpEIXpCgScK+qi0bXwMnb9jhFgN4SJk6SlGPcxXxzkR+dIue+
         DMG+SGVc55RAkTUeEgjs6JeMjD7OkUOaxdQnw=
Received: by 10.220.183.11 with SMTP id ce11mr1621815vcb.35.1291658360375;
        Mon, 06 Dec 2010 09:59:20 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id p30sm577455vcf.26.2010.12.06.09.59.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:59:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291657790-3719-7-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163012>

Giuseppe Bilotta wrote:

> The BROWSER environment variables is used in Debian-based systems to set
> the user-preferred browser(s).

I _thought_ BROWSER was not Debian-specific, but I cannot find any
evidence of that online.  See:

 http://www.catb.org/~esr/BROWSER/
 http://www.dwheeler.com/browse/secure_browser.html

At least xdg-open implements a variant on it, and I had assumed
apps preceding xdg-utils did, too.
