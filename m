From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] http (dumb): end urls with slash
Date: Fri, 19 Nov 2010 13:18:10 -0600
Message-ID: <20101119191810.GD26187@burratino>
References: <1290125163-31065-1-git-send-email-gabriel.corona@enst-bretagne.fr>
 <AANLkTikM8mNv+GiVyDWEJxsf0o3FYaaJj+jdYyiuXnov@mail.gmail.com>
 <20101119051047.GA4201@burratino>
 <1290170790-2200-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 20:19:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJWUF-0001BI-Ex
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 20:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab0KSTTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 14:19:01 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40090 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003Ab0KSTTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 14:19:00 -0500
Received: by eye27 with SMTP id 27so2958168eye.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gkjLN8ocZu857lXkmETztSmX1xSAc3XFU7LYooOMPVE=;
        b=SuieEmOhnLNo4vIiuYzYDbycQ0sPX24wqKnuJHVNDQnr8D4CMiObtbxgM/s5V2letz
         kU9FidnWvSMPoQSi/xpVtNwN+/IfaxBBXAhKtpYojQCinACyXYfuNV14rS6LL9IdG9+9
         x+TqCJ2O6HYyniz4wKE1ZMAA3w4S6VIYTCebk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R/jWSP5LlqfwfyoP/74qgfXQzPmFFb056BhUkT1NFSxdb6E3ZX3wjjlWn2cVNJY0G6
         zoKiDT564Np6R6SwALK6HjYRaLdDKlTANcarOMm5ZNByGLLSRzDo/ExV+6p+bXoFPHPp
         HJM3PN5sE27EDsxc9B0wUGFyN6G3BFg1Wm2N0=
Received: by 10.216.142.199 with SMTP id i49mr2113259wej.96.1290194338912;
        Fri, 19 Nov 2010 11:18:58 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x28sm966886weq.16.2010.11.19.11.18.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 11:18:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161776>

Hi Ray Chuan,

Tay Ray Chuan wrote:

> This patch series contains Gabriel's fix, as well as some related work I did in
> the area while looking through the code paths.

Thanks!  The code is quite readable.  I don't know enough to say
anything about the functional changes, but I assume you have that
covered.
