From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 1/7] Make is_git_command() usable outside builtin-help
Date: Sat, 26 Jul 2008 13:12:36 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807261301300.15728@harper.uchicago.edu>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 20:13:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMoH7-0001xT-Kt
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 20:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYGZSMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 14:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbYGZSMt
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 14:12:49 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:52689 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYGZSMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 14:12:48 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6QICd1C000961;
	Sat, 26 Jul 2008 13:12:39 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6QICaTp016024;
	Sat, 26 Jul 2008 13:12:37 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90267>

On Sat, 26 Jul 2008, Miklos Vajna wrote:

> +	if (!prefix)
> +		prefix = "git-";
> +       	prefix_len = strlen(prefix);

The whitespace gave me a start: the diff markup moved the prefix_len
line to the next tab stop, so at first glance it seems there are missing
braces here.  But it is an illusion.  (I mention this so others might
avoid wasting time worrying about it.)

I like the patch so far.  Thanks for the pleasant reading.
