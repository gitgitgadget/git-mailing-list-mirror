From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 02:02:06 +0000
Message-ID: <robbat2-20140212T015847-248245854Z@orbis-terrarum.net>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 03:02:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDP9S-0004Zs-8y
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 03:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbaBLCCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 21:02:09 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:44755 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaBLCCI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 21:02:08 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id E498233F99F
	for <git@vger.kernel.org>; Wed, 12 Feb 2014 02:02:07 +0000 (UTC)
Received: (qmail 17339 invoked by uid 10000); 12 Feb 2014 02:02:06 -0000
Content-Disposition: inline
In-Reply-To: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241968>

On Tue, Feb 11, 2014 at 05:54:51PM -0800,  Stefan Zager wrote:
> We in the chromium project have a keen interest in adding threading to
> git in the pursuit of performance for lengthy operations (checkout,
> status, blame, ...).  Our motivation comes from hitting some
> performance walls when working with repositories the size of chromium
> and blink:
+1 from Gentoo on performance improvements for large repos.

The main repository in the ongoing Git migration project looks to be in
the 1.5GB range (and for those that want to propose splitting it up, we
have explored that option and found it lacking), with very deep history
(but no branches of note, and very few tags).

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
