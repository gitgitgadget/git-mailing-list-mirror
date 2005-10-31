From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: git objects directory
Date: Mon, 31 Oct 2005 17:08:03 +0100
Message-ID: <20051031160803.GB15802@puritan.petwork>
References: <dk5dgq$isv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 31 17:11:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWcCk-0004ZW-T0
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 17:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVJaQII (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 11:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVJaQII
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 11:08:08 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:43411 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932282AbVJaQIH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 11:08:07 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep02.bredband.com with ESMTP
          id <20051031160801.HPCM16437.mxfep02.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Mon, 31 Oct 2005 17:08:01 +0100
Received: by puritan.petwork (Postfix, from userid 1000)
	id AAD38ADFE2; Mon, 31 Oct 2005 17:08:03 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <dk5dgq$isv$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10861>

Lexington Luthor wrote:

> Can someone please explain why git puts its objects in 256 
> sub-directories of objects instead of directly in the objects directory 
> itself? I am trying to learn git (actually cogito), but I still don't 
> understand  why this structure is used.

Because otherwise there would be a lot of objects (files) in the
objects subdirectory, which would cause a lot of problems with many
filesystems.

Anyway, you best leave that directory be, but I understand your desire
to understand :-).

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
