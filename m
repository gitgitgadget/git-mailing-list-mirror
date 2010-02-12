From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH] mail: Use space rather than tab for long header 
	folding
Date: Fri, 12 Feb 2010 17:09:47 +0100
Message-ID: <b8197bcb1002120809q5eb458f7pa9e9b0562af6bcda@mail.gmail.com>
References: <20100212153905.11578.83879.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:09:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfy5e-0007bJ-QJ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab0BLQJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 11:09:53 -0500
Received: from mail1.space2u.com ([62.20.1.135]:59004 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978Ab0BLQJx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 11:09:53 -0500
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.190])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.4/8.14.3) with ESMTP id o1CG9aJW010001
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Fri, 12 Feb 2010 17:09:36 +0100
Received: by gv-out-0910.google.com with SMTP id c6so18379gvd.37
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 08:09:48 -0800 (PST)
Received: by 10.103.80.32 with SMTP id h32mr1081402mul.59.1265990988066; Fri, 
	12 Feb 2010 08:09:48 -0800 (PST)
In-Reply-To: <20100212153905.11578.83879.stgit@pc1117.cambridge.arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139717>

On Fri, Feb 12, 2010 at 4:39 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:

> The default Python implementation (at least 2.5 and earlier) fold long
> e-mail header lines by inserting "\n\t". This causes issues with some
> e-mail clients that remove both "\n\t". The RFC2822 shows that folding
> should be done with "\n ". The Python workaround is to use a Header
> object instead of a string when setting the message headers.

Aha. If this works like I think it does, it'll eliminate the problem
where patches with long subject lines pick up tab characters when
imported from e-mails. But that's not the motivation you're
describing, is it?

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
