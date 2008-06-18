From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 21:42:58 +0200
Message-ID: <48596542.4000308@gmail.com>
References: <1213796224-995-1-git-send-email-michael@ndrix.org> <m37icmol6y.fsf@localhost.localdomain> <alpine.DEB.1.00.0806181756540.6439@racer> <200806181952.02048.jnareb@gmail.com> <alpine.DEB.1.00.0806182030200.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio Hamano <gitster@pobox.com>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:44:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K93ZY-0000YA-Kl
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 21:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbYFRTnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 15:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYFRTnE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 15:43:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:23411 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbYFRTnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 15:43:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so226215fgg.17
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=7WLWwOoJ60bwcLbXX1MqjP3+iG9X3qvxMrBLwr46pjc=;
        b=sDSN34bfh17BbXRXbtEy3yL3LL4+KcBhZPYaHYnH7Qzeo3AfutY2fdBu98saj+K/Tk
         53aVSNswjXwiA3vIOMl2n9saZWfQ+qOSySVDZcMo5Qki+o29lALzLP98HM2MCQHaiBVJ
         hk1NLDeJPZxcSNuE7xi7qChlr6d4xz50/Q790=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=QNGSoeVmKfC96CaP6uqpMgcz4pHdN2wztCaPIX6VVKzfa8jKKYMBKaiY9WH3Hwb8vJ
         pwvpXvsQsOHGjefIPO/djdEiynXcI/vgx3BBGJqEXwzZoATN0lQAXU4wHD2dGyuO/xr0
         ginUcNLji+udIrFihMT35A/Tps4ynVEHKp6ew=
Received: by 10.78.134.7 with SMTP id h7mr595424hud.94.1213818177040;
        Wed, 18 Jun 2008 12:42:57 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.248.220])
        by mx.google.com with ESMTPS id o39sm5970310hub.46.2008.06.18.12.42.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 12:42:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <alpine.DEB.1.00.0806182030200.6439@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85405>

Johannes Schindelin wrote:
> So?  Why do you want to break the _test_ on those machines where you need 
> them most?  We _know_ that a release from Junio works fine on Linux.

Goodness.  Everyone in this thread, please relax a notch.  I thought we 
had pretty clear agreement that we want to keep Perl 5.6 compatibility 
for Git.pm.  The solution is to use a temporary file in the current 
directory (and unlink it afterwards).  If nobody has done that by 
tomorrow I'll do it.  It'll take that less time than to even read this 
thread.

Now lets get back to work.

-- Lea
