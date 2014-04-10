From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Re: [PATCH v7 1/2] Add xpread() and xpwrite()
Date: Thu, 10 Apr 2014 21:44:04 +0300
Message-ID: <20140410184404.GA11264@abyss.hitronhub.home>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
 <xmqq7g6xxcap.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 20:44:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYJxh-0004zK-5t
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935697AbaDJSo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:44:27 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:39809 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758938AbaDJSoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:44:24 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so3309681eek.22
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DmIUfQ2kYEvoU4o4k/JDyKKFYRNy6mMj0ZSatYTMeHI=;
        b=vcTtiM1LQ2oVJ0ZssR9r3TTVUM+i96YYpk1pC+us4v4WF2B9V0rnjmgClfWlJTzVUo
         Cb7PrKeS7KrBx+/uh+jMcNS3sQAXu+pOC4FVIK19MkhGOQKm+CpOd27BfKnWnDl9EkPo
         uB4Eri26awOJOHtaoLCZ8de1D1HQ5q8lVVM/Pbb0d6s4qaFQR1rJfsRVmzl/3EVhTYjU
         TtKlN1m08DtQt2B5z0AifmsfKK6LZfY2XTYhSOhAEFkFWCEownx4WKf0iWcb6mMJOHlg
         SXnbA8v0aZDwKtntS4NZH40+0NAl5R1CkMsfIQC1Sa1/nIQxVRWKZLPmmVphAbmD2etc
         lPMg==
X-Received: by 10.15.81.135 with SMTP id x7mr5376969eey.61.1397155463142;
        Thu, 10 Apr 2014 11:44:23 -0700 (PDT)
Received: from abyss.hitronhub.home ([46.251.117.183])
        by mx.google.com with ESMTPSA id t4sm11797398eeb.29.2014.04.10.11.44.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 11:44:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq7g6xxcap.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246031>

On Thu, Apr 10, 2014 at 11:35:42AM -0700, Junio C Hamano wrote:
> We do not even use pwrite(); please don't add anything unnecessary
> and unexercised, like xpwrite(), as potential bugs in it will go
> unnoticed long after its introduction until it first gets used.

Correct, my mistake.
