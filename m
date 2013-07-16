From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] howto: Use all-space indentation in ASCII art
Date: Tue, 16 Jul 2013 11:26:27 -0700
Message-ID: <20130716182627.GM14690@google.com>
References: <20130715164658.GA8675@bottich>
 <7v61wba3gu.fsf@alter.siamese.dyndns.org>
 <20130716082413.GA27283@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: Dirk Wallenstein <halsmit@t-online.de>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz9xM-0001Ta-7d
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702Ab3GPS0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:26:32 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64659 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933193Ab3GPS0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:26:31 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so942775pdj.36
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cjQK8thQvc0mW20i5f7xw4d/VKATZtn/QrkTq8L1IE0=;
        b=yPJP9Annw3PgMC+ig881DAZgN4AoW9rwUHjzXV/1djkAFhEAqBf3NFq/qzeA0mEf9h
         ahGSYuXoJ5apMTMLbRFiYwDE/iyvYxI+EfbjoCO27E3QEPmhdUK51LnTSBQKQwVbZqCz
         L+VTeNjnIB6Kxy+H8chbqLHfZR9OUyKGmzEcVH/QU5F6doIDq685/C5eU9rbHOLtfoj1
         M4ewivVz0AjTgk33v/uWnUvxUEy0gmKn9ibGLV50j4gf4RUmTdpwGsTKdT1ELIk5xItB
         loIyx58gycGkoLCPRjaxnFVW6SMW7miij9Ke1o5PRKvWIs5IEdZv9Ska4o7VQlPl2Tn/
         auJA==
X-Received: by 10.68.169.97 with SMTP id ad1mr2772346pbc.84.1373999190608;
        Tue, 16 Jul 2013 11:26:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ie3sm3269841pbc.13.2013.07.16.11.26.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:26:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130716082413.GA27283@bottich>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230571>

Dirk Wallenstein wrote:

> Those text files are installed as documentation (at least on my distribution).

That's probably a distribution bug (or a git makefile bug, depending
on how you look at it).  It would be better to ship the HTML
documentation, converted to text, instead of keeping the version with
markup including occasional random \ signs, linkgit:, ``, etc.

What distribution do you use?  (As maintainer of packaging for a Linux
distro, I know at least one that is guilty of this.)

Thanks,
Jonathan
