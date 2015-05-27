From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: add `--seed` shorthand
Date: Wed, 27 May 2015 12:35:25 -0700
Message-ID: <xmqqoal5lsoy.fsf@gitster.dls.corp.google.com>
References: <20150521041435.GA18978@peff.net> <20150521041619.GC5196@peff.net>
	<8895881cd3f324d2b8a827e311296a48@www.dscho.org>
	<3516DC60279A42188EE2AA394921FC70@PhilipOakley>
	<1be7702fa53d1705e913aff2e00eac21@www.dscho.org>
	<20150522064922.GA27716@peff.net>
	<xmqqtwv1bxpy.fsf@gitster.dls.corp.google.com>
	<20150527081909.GA10008@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 21:35:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxh6z-0003mg-4c
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbbE0Tf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:35:28 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35725 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbbE0Tf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:35:27 -0400
Received: by igbyr2 with SMTP id yr2so94211904igb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ocAmnycvV8z2bdwL7OvMcqcF6xQQx8lC/htuptieJSw=;
        b=IAuU8jhZhyhM71sYZRRYga1Svj+XHqPc3kPNVH+OANd6DAobH8kKhFbSp4E5NBInSh
         m+m771kS7HMo+HvCff8l5A2u8Zx4qYKS0zNifW4bQaiEKcsT9mYz2oOsK7U3iGk8mgLK
         lp3U7tMetKFFcSydkSetaHt3wBwMU6neE/EW0d5c2fR18aDLboOSDhNW7qecmyJnQilD
         eK3/NSq72ZNUFR/5twwLJmAAu9N1NiQvFBlbupTclsrTeSsHig855jSlB50DK4SLbs7Y
         W02WkmZSEoVu8b+ZNMaP66XbkO/aJHwcPZOsmlUwcZ3b4nqrBxFzTMVKYeblbgWtqGYf
         p1lg==
X-Received: by 10.50.73.198 with SMTP id n6mr38971141igv.32.1432755327130;
        Wed, 27 May 2015 12:35:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id qh1sm294966igb.17.2015.05.27.12.35.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 12:35:26 -0700 (PDT)
In-Reply-To: <20150527081909.GA10008@peff.net> (Jeff King's message of "Wed,
	27 May 2015 04:19:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270071>

Jeff King <peff@peff.net> writes:

> On Sun, May 24, 2015 at 12:07:53PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Having slept on it, I really think "--seed" should be "fetch from the
>> > seed into temp refs", and not what I posted earlier.
>> 
>> Yeah, I think that is the right way to do it.
>
> In the meantime, do you want to pick up patches 1 and 2? I think they
> are cleanups that stand on their own, whether we do patch 3 or not.

Thanks for reminding.  Let me take a look.

Thanks.
