From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Improve --patch option documentation in git-add
Date: Mon, 14 Sep 2009 06:13:16 -0700
Message-ID: <BLU0-SMTP18292B09CCFD873F4A6DF6AEE40@phx.gbl>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
	<87ab1gaol2.fsf@jondo.cante.net>
	<7vbplw28js.fsf@alter.siamese.dyndns.org>
	<87y6p08lz5.fsf@jondo.cante.net>
	<7vmy5fy2hz.fsf@alter.siamese.dyndns.org>
	<87ab0zny27.fsf_-_@jondo.cante.net>
	<237967ef0909130648l36b592aft9c50ccff5d03d1b1@mail.gmail.com>
	<87vdjnlywo.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 15:13:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBNC-0004XM-UF
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbZINNN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437AbZINNNY
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:13:24 -0400
Received: from blu0-omc3-s18.blu0.hotmail.com ([65.55.116.93]:39695 "EHLO
	blu0-omc3-s18.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755518AbZINNNR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2009 09:13:17 -0400
Received: from BLU0-SMTP18 ([65.55.116.73]) by blu0-omc3-s18.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Sep 2009 06:13:20 -0700
X-Originating-IP: [66.183.97.179]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([66.183.97.179]) by BLU0-SMTP18.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Sep 2009 06:13:20 -0700
In-Reply-To: <87vdjnlywo.fsf@jondo.cante.net>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.5; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 14 Sep 2009 13:13:20.0181 (UTC) FILETIME=[21527650:01CA353D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128476>

On Sun, 13 Sep 2009 17:09:11 +0300
Jari Aalto <jari.aalto@cante.net> wrote:

> An update. Thanks,
> Jari
> 
[...]
>  -p::
> --patch::
> -	Similar to Interactive mode but the initial command loop is
> -	bypassed and the 'patch' subcommand is invoked using each of
> -	the specified filepatterns before exiting.
> +	Interactively choose hunks of diff between the index and the
> +	work tree and add them to the index. This gives a change to
> +	review the differences before adding modified contents to the
> +	index.
> +
> +	This effectively runs ``add --interactive``, but bypass the
> +	initial command menu and directly jumps to `patch` subcommand.
> +	See ``Interactive mode'' for details.


Jari,

It's good that you're working to make the documentation better.  To
me though, it seems more difficult to parse this description than the
one offered by Junio in an earlier thread:

        Review the difference between the index and the work tree, and add
        modified contents to the index interactively by choosing which
        patch hunks to use. 

If you don't want to just use that description verbatim, perhaps you'd
consider something closer to yours, such as:

	Interactively review the differences between the index and the
	work tree and choose which hunks to add into the index.

	This effectively runs ``add --interactive``, but bypasses the
	initial command menu and jumps directly to the `patch` subcommand.
	See ``Interactive mode'' for details.

Cheers,
Sean
