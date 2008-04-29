From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Dumb idea on git library for script languages
Date: Mon, 28 Apr 2008 23:25:51 -0500
Message-ID: <5d46db230804282125g41be08a1v1d41155fe2305dac@mail.gmail.com>
References: <1209366216.17090.4.camel@prosumer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: tsgates <tsgatesv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 06:26:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqhQb-0005Jd-O6
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 06:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbYD2E0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 00:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbYD2E0D
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 00:26:03 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:44411 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbYD2E0B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 00:26:01 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1255382ywh.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 21:25:52 -0700 (PDT)
Received: by 10.150.83.41 with SMTP id g41mr4655633ybb.191.1209443152059;
        Mon, 28 Apr 2008 21:25:52 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Mon, 28 Apr 2008 21:25:51 -0700 (PDT)
In-Reply-To: <1209366216.17090.4.camel@prosumer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80643>

On Mon, Apr 28, 2008 at 2:03 AM, tsgates <tsgatesv@gmail.com> wrote:
> Please comment on my naive idea.
>
>  When I try to use git in python, there are no fancy ways not to fork any
>  processes.  (except not active git library) I know it is design policy
>  of git, one job for one process.
>
>  Anyhow, I need to call git in python and perl, so I try to think.
>

You may be interested in Pyrite, which has a Repo class that you may find
helpful.  It is a work in progress, so there are probably bugs, but I would
be interested in fixing them.  You can find it here

http://gitorious.org/projects/pyrite

Eventually, I plan to use libgit (or libgit-thin depending on what is
appropriate) instead of subprocesses, but that is in the future.

-Govind
