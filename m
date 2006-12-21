From: "Terje Sten Bjerkseth" <terje@bjerkseth.org>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Thu, 21 Dec 2006 02:35:08 +0100
Message-ID: <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	 <86ac1iyyla.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	 <86wt4mximh.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	 <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	 <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
	 <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com>
	 <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net>
	 <86vek6vyc7.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 02:35:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxCq4-0001Q3-Rr
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 02:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWLUBfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 20:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWLUBfL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:35:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:31614 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161097AbWLUBfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 20:35:10 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2199656wxd
        for <git@vger.kernel.org>; Wed, 20 Dec 2006 17:35:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=saXew6hwfYpn5slm22revgTPzXQP3irjG7AmqIp712sQ2kkVR1r94LKuFQxSYiH8fX06wd4ltN6nP8gMUs81QojmDE9wy2Zx5XVuQO4WKknavn1PDSPksCZM5Z151w+Vd7EV9dqT74bV6rYTzIEsfScJRcQZqLLAWzGl63Gvo8g=
Received: by 10.90.105.19 with SMTP id d19mr6632364agc.1166664909384;
        Wed, 20 Dec 2006 17:35:09 -0800 (PST)
Received: by 10.90.36.7 with HTTP; Wed, 20 Dec 2006 17:35:08 -0800 (PST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86vek6vyc7.fsf@blue.stonehenge.com>
Content-Disposition: inline
X-Google-Sender-Auth: 50dec42b7af01894
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35002>

On 20 Dec 2006 17:20:40 -0800, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> Junio> Thanks for clarifying this; will apply.
>
> But don't because it doesn't help. :(

It definitely works here with it. This is on Mac OS X 10.4.8 (Intel)
with default GCC 4.0.1 from Developer Tools.

Which version are you using? Does it work if you change from testing
__APPLE_CC__ to just __APPLE__? That also works here, and is probably
better anyway. (Perhaps you are using an earlier version and the
former define was introduced with gcc 4.0 to separate gcc compiler
versions.)
