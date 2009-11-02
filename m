From: Karl Wiberg <kha@treskal.com>
Subject: Re: stgit, rebasing with 100 patches
Date: Mon, 2 Nov 2009 09:22:13 +0100
Message-ID: <b8197bcb0911020022k5fefa7f5ia0901af8df0a3604@mail.gmail.com>
References: <9e4733910910011604w68cdca86l2baa2f2fe4db4a32@mail.gmail.com>
	 <9e4733910910040600g2cbd1deah6e7ae3ad9a4aa54e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 09:55:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4sh9-0008Lu-CR
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 09:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbZKBIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 03:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZKBIzI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 03:55:08 -0500
Received: from mail1.space2u.com ([62.20.1.135]:60980 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894AbZKBIzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 03:55:07 -0500
X-Greylist: delayed 1974 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2009 03:55:06 EST
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nA28M6t7030152
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Mon, 2 Nov 2009 09:22:08 +0100
Received: by bwz27 with SMTP id 27so5985566bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 00:22:13 -0800 (PST)
Received: by 10.103.48.26 with SMTP id a26mr2001562muk.83.1257150133889; Mon, 
	02 Nov 2009 00:22:13 -0800 (PST)
In-Reply-To: <9e4733910910040600g2cbd1deah6e7ae3ad9a4aa54e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131897>

On Sun, Oct 4, 2009 at 2:00 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> On Thu, Oct 1, 2009 at 7:04 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
> > Is there a better way to locate the patches the got applied?
>
> A solution to this is to make an option on rebase that walks the
> patch stack forward one commit at a time.
>
> What does the --merged option do on stg rebase? The doc is rather
> sparse.

Right, -m/--merged is what you want. Before applying any of the
patches, it tries to reverse-apply all of them in reverse
order---successful applications mean the patch was already in
upstream. It works surprisingly well.

-- 
Karl Wiberg, kha@treskal.com
   www.treskal.com/kalle
