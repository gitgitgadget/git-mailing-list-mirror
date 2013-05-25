From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (May 2013, #07; Fri, 24)
Date: Sat, 25 May 2013 13:05:49 +0100
Message-ID: <20130525120549.GH27005@serenity.lan>
References: <7vvc686ngc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 25 14:06:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgDEX-0005NG-3U
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 14:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab3EYMF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 08:05:57 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48831 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab3EYMF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 08:05:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D9ED8CDA57C;
	Sat, 25 May 2013 13:05:55 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HutgWIETepBW; Sat, 25 May 2013 13:05:55 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 5EAAFCDA5B5;
	Sat, 25 May 2013 13:05:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vvc686ngc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225524>

On Fri, May 24, 2013 at 02:15:55PM -0700, Junio C Hamano wrote:
> * jk/submodule-subdirectory-ok (2013-04-24) 3 commits
>   (merged to 'next' on 2013-04-24 at 6306b29)
>  + submodule: fix quoting in relative_path()
>   (merged to 'next' on 2013-04-22 at f211e25)
>  + submodule: drop the top-level requirement
>  + rev-parse: add --prefix option
> 
>  Allow various subcommands of "git submodule" to be run not from the
>  top of the working tree of the superproject.
> 
>  What's the status of this one?

As far as I'm concerned this is done.  If you're re-rolling next you
could squash the top two together but I don't think that's really
necessary.
