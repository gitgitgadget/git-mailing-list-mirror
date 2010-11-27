From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Patchbombing or not, that is the question
Date: Sat, 27 Nov 2010 12:34:21 -0600
Message-ID: <20101127183421.GA2131@burratino>
References: <AANLkTi=C4opog2SfU9R_=dSOGY_5+0WYtFL8BNqcOwUw@mail.gmail.com>
 <20101127172757.GA1858@burratino>
 <AANLkTimKdwrsYQHGL=KaoQEmv3FLJzS+M=5xdQi+A5Ny@mail.gmail.com>
 <AANLkTik2WXj3kN2859_iSLQWarkR9ugJQiL2TwiNj109@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, Git List <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 19:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMPbW-00026h-KX
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 19:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab0K0Se3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 13:34:29 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41216 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab0K0Se2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 13:34:28 -0500
Received: by ywl5 with SMTP id 5so1395131ywl.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zMbevuuNAzhx2Hl/1iIx9hw2o40mWpAHNvF4naJo3UA=;
        b=f5iB/VMB4/28/+NwLihJZSsFUX+j2JbL6VH095Cd89G9EMkQ/jSq+78M05t41iYCVT
         ksVMi+IleMvkNiu3WZIUlFw60WRq/7SdaeaOx9XMzF+yuZQ9pZ4BkEPzzZqRqcq/VSPH
         di4X2b86gNbN0L+Av9qnvLbSj1ZJ81X8vDLOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OYJgKaOHmoGLN2g/yE33QRIvfynacpdpTi4HVYg2XJWFWYEOZekFg2S8d4YdviGm1H
         MdcOPTo9FLPhkzjt2mSmtjrC3knW8Cw6UW8IyH/DZbT8RgNBoKkHSVL0vUN609X3WaaC
         Z+Tv8ml2jjaPeXY3md5DxDRPks3BIpI74HeKk=
Received: by 10.100.211.15 with SMTP id j15mr2727915ang.55.1290882867918;
        Sat, 27 Nov 2010 10:34:27 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.ameritech.net [68.255.101.216])
        by mx.google.com with ESMTPS id x31sm3187284ana.29.2010.11.27.10.34.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 10:34:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik2WXj3kN2859_iSLQWarkR9ugJQiL2TwiNj109@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162321>

Giuseppe Bilotta wrote:

> Actually I think that in this case the 'chromimu' configuration should
> look for chromium-browser if chromium is not found.

Even better might be to go straight for chromium-browser, to avoid
confusion with ancient versions of chromium-bsu.

Anyway, I hadn't noticed the new support for chromium.  Thanks for
pointing it out.
