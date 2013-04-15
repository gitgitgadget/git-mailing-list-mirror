From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v1 23/45] check-ignore: convert to use parse_pathspec
Date: Mon, 15 Apr 2013 09:17:32 -0700
Message-ID: <20130415161732.GA5459@indian.linksys.moosehall>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-24-git-send-email-pclouds@gmail.com>
 <20130412150304.GH26949@pacific.linksys.moosehall>
 <CACsJy8Au4KL7msPr62bvSgGdseWFF=cUJSuB2JzGUXehDD6hng@mail.gmail.com>
 <20130414232542.GB21564@indian.linksys.moosehall>
 <CACsJy8CTZPZV6BKhLey-EZgu2gFhpNdkNVVoRALT0PyO0RS+_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URm6s-0006DH-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab3DOQSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:18:12 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:39406 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab3DOQSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:18:09 -0400
Received: from localhost (unknown [67.23.204.250])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 6798F2EACE;
	Mon, 15 Apr 2013 17:18:08 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CACsJy8CTZPZV6BKhLey-EZgu2gFhpNdkNVVoRALT0PyO0RS+_Q@mail.gmail.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221244>

On Mon, Apr 15, 2013 at 09:48:22AM +1000, Duy Nguyen wrote:
> On Mon, Apr 15, 2013 at 9:25 AM, Adam Spiers <git@adamspiers.org> wrote:
> >> > The introduction of argc also makes it possible to invoke
> >> > check_ignore() with arguments which are not self-consistent.
> >>
> >> This is the same problem with main()
> >
> > How could main() be invoked with argc inconsistent with argv?
> 
> The point is main's caller has to maintain the consistency. So do
> check_ignore's callers.

But only the system runtime calls main(), right?  So we can probably
rely on it being called in a consistent manner ;-)
