From: enso <a.calhoon@gmail.com>
Subject: Re: git-difftool
Date: Fri, 16 Jan 2009 19:47:20 -0800 (PST)
Message-ID: <1232164040173-2171934.post@n2.nabble.com>
References: <20081226013021.GA15414@gmail.com> <vpqhc4kz5zh.fsf@bauges.imag.fr> <46dff0320812312338i5a3ee0cem702a6b67ef76e48c@mail.gmail.com> <200901020104.01522.markus.heidelberg@web.de> <46dff0320901011759ke7026d9hafe4fdde099e370b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 04:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO2BL-0000ql-PV
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbZAQDrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 22:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbZAQDrW
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 22:47:22 -0500
Received: from kuber.nabble.com ([216.139.236.158]:46467 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbZAQDrW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 22:47:22 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LO29Y-0006zh-5l
	for git@vger.kernel.org; Fri, 16 Jan 2009 19:47:20 -0800
In-Reply-To: <46dff0320901011759ke7026d9hafe4fdde099e370b@mail.gmail.com>
X-Nabble-From: a.calhoon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106023>




Ping Yin wrote:
> 
> Thanks. With GIT_PAGER="" it works now.
> 

Personally, I didn't like having to screw around with environment variables
directly to get vimdiff to work. So I did the following:

1) Made a simple diff script gitvimdiff.sh:

#!/bin/env sh
vimdiff "$2" "$5"

2) git config --global diff.external ~/path/to/gitvimdiff.sh
3) git config --global pager.diff ""

Now when I run git-diff it uses vimdiff (hooray) and automatically turns the
pager off for me! Now only if I could get meld to work under cygwin.
-- 
View this message in context: http://n2.nabble.com/git-difftool-tp1814817p2171934.html
Sent from the git mailing list archive at Nabble.com.
