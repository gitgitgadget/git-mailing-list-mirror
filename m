From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 12:01:49 -0800
Message-ID: <20140121200149.GJ18964@google.com>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
 <87d2jlqp7x.fsf@fencepost.gnu.org>
 <20140121165546.GE18964@google.com>
 <874n4xqlly.fsf@fencepost.gnu.org>
 <20140121174448.GG18964@google.com>
 <87zjmpp672.fsf@fencepost.gnu.org>
 <20140121191531.GH18964@google.com>
 <87r481p0rt.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 21:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5hbd-0006Ty-1A
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 21:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaAUUHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 15:07:23 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:39900 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbaAUUHS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 15:07:18 -0500
Received: by mail-yh0-f49.google.com with SMTP id b6so2952959yha.22
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 12:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c5AdEcKYQ0zXg5yPJrNAtZl4xCceunJcz+EVO2g68uA=;
        b=pTw3PwZsKdrNvoq6p3mfgS6kjVmIQQdhHBnCLH+Z1tTeuuOKdXQ1PEmu949iTfRaD4
         fQ0GdK/OtsgOPkJLAV10XuPl14fOw1R4AQhIcSVCtzXvXSOK2bT/CqUDaRMAyrZv+Aqz
         Ys6HX4KiXEDaK3S8mN2pdNuPw8ivphegaI/BC3+ZCRCMzMo/YvXg/AzC5k822YXGoH9r
         EInWjfny2To0iFZ22Jd4eVqdhmNpNW5LB+8PJk/eIUGeBBONjHiOkPI/cLbyX9AvUEm3
         g8V0MdqxeSPiE+l7yvDmad3WouBrCAzaVnYSYKAkyzL7+oEWB/5y3SiV8PXYpFPraCbE
         /vbg==
X-Received: by 10.236.81.237 with SMTP id m73mr25306227yhe.29.1390334512462;
        Tue, 21 Jan 2014 12:01:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w8sm16111856yhg.8.2014.01.21.12.01.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 12:01:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87r481p0rt.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240770>

David Kastrup wrote:

> and contrib.  The README file states
>
>     Git is an Open Source project covered by the GNU General Public
>     License version 2 (some parts of it are under different licenses,
>     compatible with the GPLv2). It was originally written by Linus
>     Torvalds with help of a group of hackers around the net.
>
> without mentioning _which_ parts are under different licenses.

Okay, how about this patch?

diff --git i/README w/README
index 15a8e23..6745db5 100644
--- i/README
+++ w/README
@@ -21,8 +21,9 @@ and full access to internals.
 
 Git is an Open Source project covered by the GNU General Public
 License version 2 (some parts of it are under different licenses,
-compatible with the GPLv2). It was originally written by Linus
-Torvalds with help of a group of hackers around the net.
+compatible with the GPLv2, and have notices to that effect). It was
+originally written by Linus Torvalds with help of a group of hackers
+around the net.
 
 Please read the file INSTALL for installation instructions.
 
