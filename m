From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/10] i18n relative dates, help, remote, apply,
 index-pack and bundle
Date: Wed, 25 Apr 2012 11:11:14 -0500
Message-ID: <20120425161114.GA32019@burratino>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <20120424121953.GA25944@do>
 <xmqqobqggb8e.fsf@junio.mtv.corp.google.com>
 <CACsJy8AsmvfTLhAKWfijNcuz868L+KvdJuw5CPUj7KDBVKrL8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 18:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN4oY-00065V-Vh
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 18:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab2DYQLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 12:11:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41498 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab2DYQL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 12:11:29 -0400
Received: by iadi9 with SMTP id i9so255758iad.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FuGIa99gBwcf8qPHj6/inepi3AqzA8Fc0WPAIgHSEyE=;
        b=M71tDr5p8IRXANqzyK6oU6u0rHbbfEfnujucXAplWSNi0Gse8QKfH85UoQfx3n898A
         wEFufCoI80BJUCWk9CueTtgqK+6F7NMZpRvrkRPqpe9/gzXrS4KnPS+DZrMlxJ+MviBy
         YE2Ui4vKznwt22i/71tRC6BMm1UQrwhF/dqZOWldGxKnFt+a3X0jgEPMz9ADb+P4E0me
         Q+V5QHPG7MTB5LIuE65nrnExtNZhKzaNYbm1ajwjBa3zPFg0oTLxJvvdjt8kGs0jSBg/
         yJpqT+9nwELb2DHX9pXEw1evkjjuGqK+MqP/ZWeAoXeQvRqFEGoEeVM72OfMy9linoBK
         dOTA==
Received: by 10.43.131.201 with SMTP id hr9mr2984982icc.8.1335370289095;
        Wed, 25 Apr 2012 09:11:29 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gs4sm259485igc.8.2012.04.25.09.11.21
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 09:11:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8AsmvfTLhAKWfijNcuz868L+KvdJuw5CPUj7KDBVKrL8A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196320>

Nguyen Thai Ngoc Duy wrote:

> Good. What burned your eyes though? Are you ok with an approach that
> does not change source code (much) and still marks strings using an
> external tool?

I'd like the translated messages to be marked in the source code if
possible so future coders know to be careful when changing them.

If the change can be made and checked by an automated process, that
would be great, of course.
