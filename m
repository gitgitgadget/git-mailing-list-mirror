From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 0/8] gitweb: gravatar support
Date: Thu, 25 Jun 2009 14:55:32 +0200
Message-ID: <200906251455.32953.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 14:55:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJoUT-0001Kk-3a
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 14:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbZFYMze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 08:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbZFYMze
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 08:55:34 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:50067 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbZFYMzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 08:55:33 -0400
Received: by fxm9 with SMTP id 9so1425905fxm.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m5kcy781CfZFA2tLg5z2LE9T6pdpNhdCdVr/wJt4xmk=;
        b=vFPRsAjy7dVDsMA/JNyGk5hUt0L6D7NFYGJ8i1PfFj9RUIaj8/lLCsgAdHzI/4PGMP
         nI2+AyBFQgFjRHSM7uPnEKvSMqH/ctfTFWkYahRXsVzqJvyPpPQZXCbidyWLLwD6xmC2
         CrnrU+WHpRXzmYn6/vkNfMroABXAQPNjd1jH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tIJj9S85XrGPuaCyTopeVmfvU+9/V+TQ5b6KIGqujo/TFofhx0Zii22Fg8UskAo+U1
         brVQZCZWWAG70LTPmCSx9O+ikuNxGFFFG2R/ZR3e2iNxLEr8AUUGNTgmH97mCHW2V6Jl
         yMUknh7pzgqUZJbXpOt8zRgxsPJeGRXOjhkQI=
Received: by 10.103.214.13 with SMTP id r13mr1547816muq.37.1245934534922;
        Thu, 25 Jun 2009 05:55:34 -0700 (PDT)
Received: from ?192.168.1.13? (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id s11sm1054829mue.41.2009.06.25.05.55.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 05:55:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122204>

Giuseppe Bilotta wrote:

> Significant changes from the previous iteration are:
> 
> * the feature has been renamed to 'avatar', and 'gravatar' is a possible
>   value for it (currently the only sensible value, other than '');

By the way, I think it might be better solution to provide picon URL
as 'default' attribute for gravatar URL, so it is used if there is no
gravatar for given email.

> * the last patch adds avatars to signoff lines.

Perhaps it would be better to add gravatars at beginning of line?


I'll try to post my comments today (i.e. within 24 hours)... but it
looks good.

-- 
Jakub Narebski
Poland
