From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit RFC PATCH 0/6] add support for git send-email
Date: Sun, 29 Nov 2009 23:05:07 +0100
Message-ID: <b8197bcb0911291405i6f052216q8717c34063320592@mail.gmail.com>
References: <20091128194056.949.88791.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 23:05:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NErtM-0002Pa-Tc
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 23:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbZK2WFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 17:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZK2WFD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 17:05:03 -0500
Received: from mail1.space2u.com ([62.20.1.135]:58335 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbZK2WFC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 17:05:02 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nATM4muq029172
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Sun, 29 Nov 2009 23:04:48 +0100
Received: by bwz27 with SMTP id 27so2123920bwz.21
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 14:05:07 -0800 (PST)
Received: by 10.204.49.79 with SMTP id u15mr3708510bkf.117.1259532307244; Sun, 
	29 Nov 2009 14:05:07 -0800 (PST)
In-Reply-To: <20091128194056.949.88791.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134040>

On Sat, Nov 28, 2009 at 8:50 PM, Alex Chiang <achiang@hp.com> wrote:

> stg mail still has some nice features over git send-email, such
> as the -v command line parameter and --prefix. Maybe at some point
> in the future, we can migrate those features into git send-email and
> continue thinning out stg mail.

Yes. But note that we tend to be conservative and not require a
too-new git, so a patch adding such a dependency would have to wait a
while. (I'm currently carrying two such patches in my experimental
branch.)

> But I wanted to get some feedback first to make sure I'm going in the
> right direction before going too much further.

I've read the patches, and it looks about right from where I stand.

Did you remember to run the regression tests? It's very helpful when
reviewing to know that the regression suite passes at every point in
the series.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
