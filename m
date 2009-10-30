From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool  option
Date: Fri, 30 Oct 2009 02:02:01 +0100
Message-ID: <200910300202.02016.markus.heidelberg@web.de>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com> <20091029221234.GB32590@hashpling.org> <76718490910291747l165baf49tab781727d010610a@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 02:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3fsL-0004tw-SB
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 02:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbZJ3BBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 21:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbZJ3BBr
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 21:01:47 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:41119 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbZJ3BBq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 21:01:46 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id A427A13B30E33;
	Fri, 30 Oct 2009 02:01:50 +0100 (CET)
Received: from [89.59.78.39] (helo=pluto.fritz.box)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N3fsE-0005nh-00; Fri, 30 Oct 2009 02:01:50 +0100
User-Agent: KMail/1.9.10
In-Reply-To: <76718490910291747l165baf49tab781727d010610a@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19DUe0/ZAM7qHXvNO6dcvJ8+TyzJIS+Vi9Dezty
	zbVQAaKQ3BWhNX5KVymrDVPxbz7sJmSd49I+MwX88aMELRufTj
	RqvMpUp4NCbXVI/t8pcA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131668>

Jay Soffian, 30.10.2009:
> On Thu, Oct 29, 2009 at 6:12 PM, Charles Bailey <charles@hashpling.org> wrote:
> > I'm not sure I understand why only p4merge on Mac OS X is special, we
> > don't seem to treat any other mergetool specially and we don't seem to
> > need absolute paths anywhere else.
> 
> On other platforms, the merge tool is very likely to be in your PATH.

He didn't mean p4merge on other platforms, but other merge tools on Mac
OS X. What about all the other merge tools already in mergetool--lib?
Should they get special handling, too?

> On OS X, p4merge is going to be installed as part of an application
> bundle (/Applications/p4merge.app or $HOME/Applications/p4merge.app).
> This is virtually never going to be in a user's PATH.
> 
> So in order to provide equivalent behavior for OS X as Linux (i.e., so
> that you can just specify p4merge as the mergetool without having to
> provide it's path), we need to look in these additional locations.

And for Windows we could add C:\Program Files\MergeToolX\tool.exe for
every merge tool.

But where will we end?

Markus
