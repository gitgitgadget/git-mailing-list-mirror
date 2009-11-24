From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/2] http fixes
Date: Tue, 24 Nov 2009 09:48:10 +0800
Message-ID: <20091124094810.797341d4.rctay89@gmail.com>
References: <20091123110347.d47728f8.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Martin =?ISO-8859-1?Q?Storsj=F6?= <martin@martin.st>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 02:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCkWd-0008Iw-9t
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 02:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbZKXBsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 20:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbZKXBsW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 20:48:22 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:65334 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbZKXBsV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 20:48:21 -0500
Received: by gxk4 with SMTP id 4so12954814gxk.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 17:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=yBG+/n0LE3v/srV5JeL/CmzCxsfVcgDvAFmrF0TwKQ0=;
        b=WyEVAk8LAFkimbBnDH2IT5FFUybfN8eiq8zIQH65u/+YGlW5wcr58sBvgPwVj6kS49
         HdQBGNJDst+aNmAi0QbT9ZijJsiwI2V310zCvVEiANWIpAmW1MA+PEr7neMQqsQSCTO+
         vSTklf3j1muw4DNhFLM8B+2bbzFfE+EbcXDo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=QIv39xcpFE2yrTHS2IRe7MK2HcV5+GoyrhgIqhETifcarWUPjqxQwLDpZtqIVs9wVf
         SzGvVX302ELXRerGUSJdwNPp2R/YPwqejcO3XDIfhjcAoKnqi68DtiLH/2XNsjhcleKe
         yzGpMVCrvaXamPdFBz7TOU2zAci1W/6cuJsbs=
Received: by 10.90.14.13 with SMTP id 13mr696875agn.117.1259027304223;
        Mon, 23 Nov 2009 17:48:24 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 8sm2173972yxg.6.2009.11.23.17.48.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 17:48:23 -0800 (PST)
In-Reply-To: <20091123110347.d47728f8.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133553>

This series is a re-roll and is based on 'master'.

Patch 1 ("Do curl option disabling before enabling new options"):
 No changes from the previous version.

Patch 2 ("remote-curl.c: fix rpc_out()"):
 Focus solely on the extraneous semicolon.

 http-push.c   |    2 +-
 remote-curl.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--
Cheers,
Ray Chuan
