From: Eric Wong <e@80x24.org>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and
 reply to
Date: Tue, 24 May 2016 21:23:56 +0000
Message-ID: <20160524212356.GA2649@dcvr.yhbt.net>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
 <20160523195504.GA8957@dcvr.yhbt.net>
 <0285f901-a1d1-2715-4207-68c7d103da5e@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, erwan.mathoniere@grenoble-inp.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Tue May 24 23:24:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Jo2-0001ZZ-V2
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 23:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbcEXVX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 17:23:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53138 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbcEXVX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 17:23:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31E31FCC4;
	Tue, 24 May 2016 21:23:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <0285f901-a1d1-2715-4207-68c7d103da5e@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295535>

Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
> On 05/23/2016 09:55 PM, Eric Wong wrote:
> >Cool!  There should probably be some help text to encourage
> >trimming down the quoted text to only relevant portions.
> 
> What kind of help text would you want to see?
> 
> Maybe something like this:
> 
>   GIT: Quoted message body below.
>   GIT: Feel free to trim down the quoted text
>   GIT: to only relevant portions.
> 
> As "GIT:" portions are ignored when parsed by `git send-email`.

Yes, given we have instructions for diffstat and table of contents;
I think it'd be useful to discourage quoting irrelevant parts of
the message (especially signatures and like).
