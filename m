From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 7] autoconf: Add support for setting CURLDIR, OPENSSLDIR, EXPATDIR
Date: Thu, 10 Aug 2006 14:27:45 -0700
Message-ID: <7vejvouvqm.fsf@assigned-by-dhcp.cox.net>
References: <200608081834.09271.jnareb@gmail.com>
	<200608090215.10917.jnareb@gmail.com> <ebf31a$8qv$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 23:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBI4H-0005tH-2Q
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 23:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWHJV1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 17:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWHJV1s
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 17:27:48 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64650 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbWHJV1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 17:27:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810212746.UMJS12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 17:27:46 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebf31a$8qv$2@sea.gmane.org> (Jakub Narebski's message of "Thu,
	10 Aug 2006 12:50:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25211>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
>> Add support for --with-openssl=PATH and --without-openssl,
>> --with-curl=PATH and --without-curl, --with-expat=PATH and
>> --without-expat ./configure options, each setting or unsetting
>> appropriate NO_PACKAGE and if called with argument also PACKAGEDIR
>> (of which only CURLDIR is documented in Makefile)
>> 
>> All above options are supported as override to autodetection; more to
>> come in the same style (override to autodetection), so moved the bulk
>> of comments for site configuration down.
>
> Is this patch dropped?

I think it should be on "pu" but I might have missed it; it came
with a warning not to apply didn't it?
