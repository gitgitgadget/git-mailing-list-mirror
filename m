From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 09:44:48 -0800
Message-ID: <20140121174448.GG18964@google.com>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
 <87d2jlqp7x.fsf@fencepost.gnu.org>
 <20140121165546.GE18964@google.com>
 <874n4xqlly.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 18:44:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5fNh-00006B-IT
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 18:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbaAURoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 12:44:54 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:42894 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903AbaAURox (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 12:44:53 -0500
Received: by mail-yh0-f51.google.com with SMTP id l109so2901107yhq.24
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 09:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IiYNAI8Iyj1GMOA5U2HNActVD6WnpFouS+ucw3Ol7L0=;
        b=ipHGSYji6Xgb8S6fRQ8VJ63/ffYepRW0rgtow6mQv4Po7cGRNUtzpeyVjhDz+dliaS
         KM7eQ+66ZQ0ZmKDzPTsSVHxQeEJHvNFTZo6CmoCOvDyzFNsUIjlABe4ctI9YkoYYUnf5
         EK7KQBYyMZNr9JwjpBXb9EXTq7EjUz1vZhiabkfG+gYY1D0OFNlqxxZlLoBA3NGt/vti
         ML0AdjAvD2P1RrCO/J5XDXxgp9RBRZwSE3VTcAB+VtXGIBxG8/kbsfmZEw+m3yXPR+Ym
         rFg9R19z5+7UemeZcUtZSmoUhPUoUzfFRkid4ESv6+13fFAJFB7Jt+wiVOcD10wPK/e5
         Ewew==
X-Received: by 10.236.17.34 with SMTP id i22mr2437287yhi.110.1390326291433;
        Tue, 21 Jan 2014 09:44:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w50sm15037782yhc.15.2014.01.21.09.44.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 09:44:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <874n4xqlly.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240760>

David Kastrup wrote:

> So my understanding is that when we are talking about _significant_
> additions to builtin/blame.c (the current patches don't qualify as such
> really) that
>
> a) builtin/blame.c is licensed under GPLv2
> b) significant contributions to it will not be relicensed under
> different licenses without the respective contributors' explicit
> consent.

Yep, that's how it works.

[...]
> The combination of the SubmittingPatches text with the file notices in
> builtin/blame.c is not really painting a full picture of the situation.

Any idea how this could be made more clear?  E.g., maybe we should
bite the bullet and add a line to all source files that don't already
state a license:

	/*
	 * License: GPLv2.  See COPYING for details.
	 */
