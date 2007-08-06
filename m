From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Mon, 06 Aug 2007 19:38:55 -0400
Message-ID: <46B7B10F.4060402@gmail.com>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>	<11864401942772-git-send-email-mdl123@verizon.net>	<Pine.LNX.4.64.0708062349460.14781@racer.site> <7vzm149s8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ren Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 01:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IICAP-0002Bx-CG
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 01:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933152AbXHFXjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 19:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933201AbXHFXjA
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 19:39:00 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:58176 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932803AbXHFXi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 19:38:59 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1588448wxd
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 16:38:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WoknXtMtGNWdb3RLsKtPQsrSyknOh4/bu1xw4gIYoMbLSmW3dFUS5+touR2+XwSv+K04VCo90ml+C4RTC03CY2RS5dfXCv+mW5K4Xm6LbVd6X0VNpTD0eSmILAgQJjqTPSLFYjIBqGCXcKViPv1oEZAMxzwACRIb8b0joK/3mJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uO8eKQ7xGZboD/qI3frxpGyIX1RHgS0mIPm3a4vrmXXcY6doDzSTfykAY1Z44yR8gHa9TO9k3f4QRksZeLgp4kWGLwXdlCrfhjZRk9/CEGPeTefiZJXqMnpjFK1Rx5iBB0ElWI1yF+gob2H5fJe+OmeYyAofiu3C4XPV+bLas8s=
Received: by 10.70.34.13 with SMTP id h13mr10655480wxh.1186443538292;
        Mon, 06 Aug 2007 16:38:58 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id h10sm6354504wxd.2007.08.06.16.38.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Aug 2007 16:38:57 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <7vzm149s8s.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55188>

Junio C Hamano wrote:
> Yes.  And 00d8c51 obviously "works for me", so there is
> something different between what Mark and I are doing.  I cannot
> tell what it is.
>   
GZ=1 make quick-install-doc

...fails because git-ls-tree is called when cwd=$mandir which is nowhere 
under or related to $GIT_DIR.

Mark
