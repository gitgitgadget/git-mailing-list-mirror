From: Tim Stoakes <tim@stoakes.net>
Subject: Re: [PATCH] git-stash: alias 'list' to 'ls' and 'clear' to 'rm'
Date: Tue, 5 Feb 2008 21:50:01 +1030
Message-ID: <20080205112000.GD29545@mail.stoakes.net>
References: <1202207899-28578-1-git-send-email-tim@stoakes.net> <D512F3C0-3354-40BB-BD8D-8B3A85196825@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 12:20:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMLqy-0003WP-Uz
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 12:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbYBELUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 06:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYBELUH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 06:20:07 -0500
Received: from hosted02.westnet.com.au ([203.10.1.213]:54767 "EHLO
	hosted02.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbYBELUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 06:20:05 -0500
Received: from hosted02.westnet.com.au (hosted02.westnet.com.au [127.0.0.1])
	by hosted02.westnet.com.au (Postfix) with SMTP id D84CD49733;
	Tue,  5 Feb 2008 20:20:03 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted02.westnet.com.au (Postfix) with ESMTP id A167B4A815;
	Tue,  5 Feb 2008 20:20:02 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id 1DE4328C034;
	Tue,  5 Feb 2008 21:50:01 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 4DC9A7F1FF; Tue,  5 Feb 2008 21:50:01 +1030 (CST)
Content-Disposition: inline
In-Reply-To: <D512F3C0-3354-40BB-BD8D-8B3A85196825@wincent.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72649>

Wincent Colaiuta(win@wincent.com)@050208-12:06:
> El 5/2/2008, a las 11:38, Tim Stoakes escribi?:
>
>> clear::
>> +rm::
>> 	Remove all the stashed states. Note that those states will then
>> 	be subject to pruning, and may be difficult or impossible to recover.
>
> Isn't "rm" a bit misleading here? Seeing as the clear subcommand really 
> does an "rm -rf".

$ git stash clear foo
git stash clear with parameters is unimplemented

It appears that 'clear' is intended to behave like 'rm', however, it
isn't implemented yet.

> Also, is there any other precedent in the command suite for abbreviating 
> subcommand names in that way (ie. not just by shortening them, but by using 
> alternative names based on filesystem commands)? It strikes me as a bit 
> inconsistent.

For example 'git remote' uses 'rm', and there exists 'git rm', 'git
ls-files', 'git ls-remotes' etc. Granted, these are not abbreviations of
other (also available) longer term. The fact that some commands use
shell command names, and others use words, appears to be the
inconsistency to me. However, renaming 'git stash list' to 'git stash
ls' would break compatibility, so seemed too heavy to me.

Tim

-- 
Tim Stoakes
