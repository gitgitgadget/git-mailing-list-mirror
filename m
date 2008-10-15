From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: BUG: git rev-list segfaults
Date: Thu, 16 Oct 2008 06:22:23 +0900
Message-ID: <20081016062223.6117@nanako3.lavabit.com>
References: <Pine.LNX.4.64.0810152034040.7572@rosenkohl.springl.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Stephan Springl <springl-git@bfw-online.de>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:24:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqDqs-0004Tb-OQ
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 23:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255AbYJOVXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 17:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbYJOVW7
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 17:22:59 -0400
Received: from karen.lavabit.com ([72.249.41.33]:47066 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746AbYJOVW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 17:22:58 -0400
Received: from a.earth.lavabit.com (a.earth.lavabit.com [192.168.111.10])
	by karen.lavabit.com (Postfix) with ESMTP id BF958C7AF7;
	Wed, 15 Oct 2008 16:22:57 -0500 (CDT)
Received: from 4665.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id VJBWYCD675YZ; Wed, 15 Oct 2008 16:22:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=MXYf+RBnU20mQEGH4HICStxRlnw+jh4Foqt7cOhSLSxP5vZhHrui4E5wcNW90442t3U6ehN7PsMtv5K83KgngESmtmnHJs1Bhg4ZFrSxFCFDz1KAaQQ0swa2RdN9DVfY2c1HgyO+RZNruZm100muLaDR0KWwTJYlMOS3eedXI1s=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <Pine.LNX.4.64.0810152034040.7572@rosenkohl.springl.homeip.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98332>

Stephan Springl <springl-git@bfw-online.de> writes:

> git rev-list segfaults when crossing a merge commit when given
> --bisect-vars and --first-parent.

This is an old news, isn't it?

    http://thread.gmane.org/gmane.comp.version-control.git/93416/focus=93420

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
