From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Silence iconv warnings on Leopard
Date: Fri, 7 Dec 2007 01:11:21 +0100
Message-ID: <200712070111.23283.jnareb@gmail.com>
References: <1196968023-45284-1-git-send-email-win@wincent.com> <985966520712061504s686395d6jf680363c7b3b9de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>, git@vger.kernel.org
To: "Blake Ramsdell" <blaker@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 01:08:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0QlI-0007bD-Cb
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 01:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbXLGAHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 19:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbXLGAHv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 19:07:51 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:32899 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbXLGAHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 19:07:50 -0500
Received: by mu-out-0910.google.com with SMTP id i10so102415mue
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 16:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Xj/+2jD+/1Wyr7YJSDaprEa3tA7Xgur3jnL5VuaAsfA=;
        b=S6yvmxFCWqGBKJsIBI8cQNhqXuh0aqSHe88eaeko422NLG+G92lC3eaqD0tnGPUpIBHr6WyC0IV5i+OYRrMPpS3Czzz1TZOqXDtyTkOxOTBR5raM6aUc/Q7smyPu9jIk0pVdwiaLmZs45RMWquMOgCwJKFnzvexoi8wPW6LyNyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JuB1vtJztsnebq2eM/yza0YXh0QB5hyPKkJEoZR0fuldjjzdl3HID5ffhTJNGT/JHz1qpwHrFfQoomfBSVSoqT83DKrp3hpr4CTZMUbn69wQdadHmxHHGPUw/AOOIBEHyKYeoCtaVOE569di1THDSFIIIs1zMyoRiwXHO9Erda0=
Received: by 10.86.51.2 with SMTP id y2mr1584317fgy.1196986068003;
        Thu, 06 Dec 2007 16:07:48 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.224.19])
        by mx.google.com with ESMTPS id 12sm18600fgg.2007.12.06.16.07.45
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Dec 2007 16:07:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <985966520712061504s686395d6jf680363c7b3b9de7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67357>

On Fri, 7 Dec 2007, Blake Ramsdell wrote:
> On Dec 6, 2007 11:07 AM, Wincent Colaiuta <win@wincent.com> wrote:

>> Apple ships a newer version of iconv with Leopard (Mac OS X 10.5/Darwin
>> 9). Ensure that OLD_ICONV is not set on any version of Darwin in the
>> 9.x series; this should be good for at least a couple of years, when
>> Darwin 10 comes out and we can invert the sense of the test to
>> specifically check for Darwin 7 or 8.

>> A more sophisticated and robust check is possible for those who use
>> autoconf, but not everybody does that.
> 
> I did make a patch for configure.ac that does this. If it's
> interesting, I'll send it along.

I would be interested, as I tried to make a patch to configure.ac which
does that. The problem is that it should be check that tests for compile
time _warnings_; my solution was to use '-Werror' flag to make warning
into error, and AC_COMPILE_IFELSE, but this might be gcc only solution.

  Message-ID: <1196895948-25115-1-git-send-email-jnareb@gmail.com>
  http://permalink.gmane.org/gmane.comp.version-control.git/67209

So please send it.

Thanks in advance
-- 
Jakub Narebski
Poland
