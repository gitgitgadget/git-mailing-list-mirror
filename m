From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] git-fast-import(1): combine documentation of
 --[no-]relative-marks
Date: Wed, 9 Jan 2013 13:42:46 -0800
Message-ID: <20130109214246.GA21054@google.com>
References: <cover.1357760256.git.john@keeping.me.uk>
 <cf4a4a10c1de73491048e8283582bdbf8c79c75e.1357760256.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 09 22:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt3Qp-0002WB-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 22:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221Ab3AIVnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 16:43:06 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:61341 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933157Ab3AIVnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 16:43:02 -0500
Received: by mail-pb0-f53.google.com with SMTP id jt11so1202389pbb.12
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 13:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TLewbb0Sh7bhMgeWs3N4hSf16EuIYEjUhNZNYfvRbZg=;
        b=Nkxayly1Buns9Ow03wPdBbYrhIu4OwCbycDm6r2ocQNbFYhlJciYu884MQ3LJqxASb
         KLrdxHdBW0WDcGLNGDOYi4vKkYKtgJQIcQ0JTp6BW0oukJWDg8OvfW8LgfLqAXk1PXtJ
         NcODrVca+Ty26HeaE5fFZTD5tiO8dVLkcj3WXlNHIwMR+4g3B4VSiawlQm0ph+dfMNvm
         qt1ineEa92KiBbyjQw33vMLYHSdi24vWGQ3uDGs7O7mSwkJKaTNDSegmr3loHaiOIP4k
         8yp8pkf5Gew5tVGLFOUN0p34OXOOnUh/mvbI7mheNpHagB0YxHfOQ+3vpv5DcMyqWQrm
         2Zgg==
X-Received: by 10.68.211.42 with SMTP id mz10mr215251036pbc.100.1357767781491;
        Wed, 09 Jan 2013 13:43:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id gj1sm42267085pbc.11.2013.01.09.13.42.51
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Jan 2013 13:43:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cf4a4a10c1de73491048e8283582bdbf8c79c75e.1357760256.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213107>

John Keeping wrote:

> The descriptions of '--relative-marks' and '--no-relative-marks' make
> more sense when read together instead of as two independent options.
> Combine them into a single description block.

Yep, this is easier to read.  Thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
