From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH/RFC] remove #!interpreter line from shell libraries
Date: Mon, 12 Mar 2012 22:38:47 +0100
Message-ID: <20120312213847.GA4958@ecki>
References: <20120308121403.GA16493@burratino>
 <20120309075820.GA15985@ecki>
 <4F5E4618.10102@xiplink.com>
 <7vy5r5r43s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:47:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7D5s-0003bl-Pb
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513Ab2CLVrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 17:47:36 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:25592 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756789Ab2CLVrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:47:35 -0400
Received: from bsmtp.bon.at (unknown [10.232.130.106])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 9024ACE10B
	for <git@vger.kernel.org>; Mon, 12 Mar 2012 22:47:51 +0100 (CET)
Received: from localhost (pD9FB5EE0.dip.t-dialin.net [217.251.94.224])
	by bsmtp.bon.at (Postfix) with ESMTP id B568710017;
	Mon, 12 Mar 2012 22:43:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vy5r5r43s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192956>

On Mon, Mar 12, 2012 at 12:50:15PM -0700, Junio C Hamano wrote:
> 
> > On 12-03-09 02:58 AM, Clemens Buchacher wrote:
> >> 
> >> On Thu, Mar 08, 2012 at 06:14:04AM -0600, Jonathan Nieder wrote:
> >>>
> >>> -#!/bin/sh
> >>> -# git-mergetool--lib is a library for common merge tool functions
> >>> +# git-mergetool--lib is a shell library for common merge tool functions
> >> 
> >> This breaks vim's filetype detection. It can still guess the file type
> >> from the .sh extension, but we strip the extension during the build.
> 
> Then that _is_ a feature to make it more obvious that the file is
> not something you should be editing, no?

If that really is an issue, then we should make it write-protected.
Syntax highlighting is primarily useful for reading.
