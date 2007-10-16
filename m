From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] rev-list documentation: add "--bisect-all".
Date: Tue, 16 Oct 2007 12:42:57 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071016104257.GB1170@ins.uni-bonn.de>
References: <20071016055905.55c1d280.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:43:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhjtL-0001mI-Ci
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 12:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758319AbXJPKnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 06:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755916AbXJPKnD
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 06:43:03 -0400
Received: from hermes.iam.uni-bonn.de ([131.220.223.5]:58900 "EHLO
	iam.uni-bonn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756608AbXJPKnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 06:43:01 -0400
Received: (qmail 31363 invoked from network); 16 Oct 2007 10:42:58 -0000
Received: from gibraltar.iam.uni-bonn.de (HELO ins.uni-bonn.de) (131.220.223.4)
  by hermes.iam.uni-bonn.de with (EDH-RSA-DES-CBC3-SHA encrypted) SMTP; 16 Oct 2007 10:42:58 -0000
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071016055905.55c1d280.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.16 (2007-10-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61140>

Hello,

A couple of typos:

* Christian Couder wrote on Tue, Oct 16, 2007 at 05:59:05AM CEST:
> 
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index 7cd0e89..f6dd0c4 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
[...]
> @@ -354,6 +355,21 @@ the expected number of commits to be tested if `bisect_rev`
>  turns out to be bad to `bisect_bad`, and the number of commits
>  we are bisecting right now to `bisect_all`.
>  
> +--bisect-all::
> +
> +This outputs all the commit objects between the included and excluded
> +commits, ordered by their distance to the included and excluded
> +commits. The farthest from them is displayed first. (This is the only
> +one displayed by `--bisect`.)
> +
> +This is usefull because it makes it easy to choose a good commit to

s/usefull/useful/

> +test when you want to avoid to test some of them for some reason (they
> +may not compile for example).
> +
> +This option can be used along with `--bisect-vars`, in this case,
> +after all the sorted commit objects, there will be the same text as if
> +`--bisect-vars` has been used alone.

s/has/had/

Cheers,
Ralf
