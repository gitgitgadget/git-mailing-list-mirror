From: Russ Allbery <rra@stanford.edu>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 00:20:06 -0700
Organization: The Eyrie
Message-ID: <87r7f9xsux.fsf@windlord.stanford.edu>
References: <E1DgodI-0003ov-Fl@highlab.com>
	<7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
	<E1DgyW0-0004PE-Ct@highlab.com>
	<2cfc403205061023346c03a25b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 11 09:16:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh0Di-0006uS-TV
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 09:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVFKHUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 03:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVFKHUM
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 03:20:12 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:60861 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261630AbVFKHUI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 03:20:08 -0400
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.64.19.147])
	by smtp3.Stanford.EDU (8.12.11/8.12.11) with SMTP id j5B7K6WL004133
	for <git@vger.kernel.org>; Sat, 11 Jun 2005 00:20:07 -0700
Received: (qmail 28403 invoked by uid 1000); 11 Jun 2005 07:20:06 -0000
To: git@vger.kernel.org
In-Reply-To: <2cfc403205061023346c03a25b@mail.gmail.com> (Jon Seymour's
 message of "Sat, 11 Jun 2005 16:34:36 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jon Seymour <jon.seymour@gmail.com> writes:

> What is the justification for removing it?

The conflict with the existing GIT package is painful for distributions.
Packagers try hard to avoid any file conflicts between packages, since it
means that both packages cannot be used at the same time, and it turns out
in discussion on the Debian mailing lists that people actually do use GIT.

Managing the conflict between two programs that do completely different
things and are named the same thing is really annoying.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
