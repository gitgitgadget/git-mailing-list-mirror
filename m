From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: why no "ignore" command on git
Date: Wed, 14 Oct 2009 22:20:50 -0600
Organization: icecavern.net
Message-ID: <200910142220.51725.wjl@icecavern.net>
References: <42efdea40910141535g23a50b87p9b6c4a0fde7e842e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 06:23:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyHrk-0003Un-37
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 06:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbZJOEVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 00:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZJOEVg
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 00:21:36 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:40278 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750966AbZJOEVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 00:21:36 -0400
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 2835635A66;
	Thu, 15 Oct 2009 06:20:57 +0200 (CEST)
User-Agent: KMail/1.11.4 (Linux/2.6.28-15-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <42efdea40910141535g23a50b87p9b6c4a0fde7e842e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130375>

On Wednesday 14 October 2009 16:35:23 Ralf Thielow wrote:
> why does git don't have an "ignore" command, to ignore some files or
> directories all the time.
[...]
> I read on some pages by a google search that you can create
> a ".gitignore" directory or something like that. But you had to do
> this manually.
>
> why there is no "ignore" command on git?

You could always make your own git-ignore script, e.g.:

#!/bin/sh
echo "$@" >> .gitignore
