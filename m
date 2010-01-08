From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH 2/2] Pass the --in-reply-to and --no-thread options 
	to git send-email
Date: Fri, 8 Jan 2010 07:43:44 +0100
Message-ID: <b8197bcb1001072243h24e6248er79ac5a8afb6e3782@mail.gmail.com>
References: <20100107160932.3226.95737.stgit@pc1117.cambridge.arm.com>
	 <20100107160937.3226.14811.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 07:44:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT8aU-0003R5-FP
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 07:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab0AHGnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 01:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456Ab0AHGnq
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 01:43:46 -0500
Received: from mail1.space2u.com ([62.20.1.135]:35526 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab0AHGnq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 01:43:46 -0500
Received: from mail-fx0-f225.google.com (mail-fx0-f225.google.com [209.85.220.225])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id o086hcQO032122
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Fri, 8 Jan 2010 07:43:38 +0100
Received: by fxm25 with SMTP id 25so12366800fxm.21
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 22:43:44 -0800 (PST)
Received: by 10.102.214.22 with SMTP id m22mr7068560mug.33.1262933024434; Thu, 
	07 Jan 2010 22:43:44 -0800 (PST)
In-Reply-To: <20100107160937.3226.14811.stgit@pc1117.cambridge.arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136418>

On Thu, Jan 7, 2010 at 5:09 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:

> +    if options.in_reply_to:
> +        cmd.append("--in-reply-to %s" % options.in_reply_to)

Have you tested this? I'm pretty sure you need "--in-reply-to=%s", or
to add the two strings separately---since as far as I can see, this
command is never shell-expanded.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
