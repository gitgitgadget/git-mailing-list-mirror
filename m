From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 22:09:11 -0800
Message-ID: <20130211060911.GH15329@elie.Belkin>
References: <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <CAE_TNim2wrL3SWxy_2ugyGmEFDngBJ8+z04y2tJFzMo4N8mUug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4maF-0005LE-4s
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 07:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab3BKGJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 01:09:20 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:42828 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3BKGJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 01:09:19 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so2892246pad.25
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 22:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RYoAaq59pYD1FKX1A5/RM5yS6zIZdQZ2s12LyKa/U9A=;
        b=nBJ/YEgJ66xYEXIjS6+qRZ87VrYICBt3OYowULjPNJeQnhqpPGalC0mGmhRESMOu/d
         fKMfnMOtau7EpSCQ317L0l3lmY7jmDcKexZy7mDmACo2UN8uKoxZLfigByo5qpv6u0az
         h47+zNMT94rn6E8R26L2CfU/99V57K17z00nadz5UqPuF5ChhqRpPHKXHhI/Sx9PusTP
         TtqlcqY/AoQHammgkBNNoqaRh0dEsWgz/ccJBJYk7Qs8KATcRgZyc2H/wQx1RykGpZMJ
         tK9gSdDU8FyAKyIAlkK3WJ+aQHeKPc6ZXVHVAXGrd9p5a0pmWZr8u1CzWe1m2O93MQmO
         fbEA==
X-Received: by 10.68.138.133 with SMTP id qq5mr15963303pbb.152.1360562959056;
        Sun, 10 Feb 2013 22:09:19 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ju13sm6618047pbb.7.2013.02.10.22.09.16
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 22:09:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAE_TNim2wrL3SWxy_2ugyGmEFDngBJ8+z04y2tJFzMo4N8mUug@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215999>

Ethan Reesor wrote:

>                        That way, there's a default setting, there can
> be a system-wide message, there can be a user specific message, and
> those messages can be set via `git-commit`.

That won't let me imitate gitolite's behavior without a lot of
config file churn:

	$ ssh git@localhost
	Hello, jrn.  This is git@elie running git-shell 1.8.1.3.

	 R W	path/to/one/repo
	 R	path/to/another/repo
	$
