From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/9] revert: make commit subjects in insn sheet optional
Date: Fri, 9 Dec 2011 13:32:16 -0600
Message-ID: <20111209193216.GC20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:32:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6BF-0006YW-9P
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1LITcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 14:32:21 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55057 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1LITcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 14:32:20 -0500
Received: by ggnr5 with SMTP id r5so3650365ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hCzCLNb6RXdkab8CsRGuk/qIEOasxoTJt6RY4RWQAMQ=;
        b=Urp8T7m0vSkmmRTh8zWa9CIkbx2Wq31KOC6ikE4xkjo2B1L0TP9uDnl6hoQtSZvH9U
         cen5LfAA2L1f6d3Wkn3115eX+Ns7KJBexw+jfg6NpJ6BaKo8nxeOuPHK8Zv1zTXI75I3
         rxtb6R8k095n3xONIpl/klDyrecCPbAuaqkwc=
Received: by 10.101.18.16 with SMTP id v16mr2213484ani.104.1323459139938;
        Fri, 09 Dec 2011 11:32:19 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n64sm16574798yhk.4.2011.12.09.11.32.18
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 11:32:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186669>

Ramkumar Ramachandra wrote:

>                   In addition to literal SHA-1 hexes, expressions like
> the following are valid object names in the instruction sheet:
>
>   featurebranch~4
>   rr/revert-cherry-pick-continue^2~12@{12 days ago}

Glad to see this new mention.  My comment from reviewing the last
iteration doesn't seem to have been addressed, though.  Will follow
up there.
