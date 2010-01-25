From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/18] rebase -i: Make the condition for an "if" more
 transparent
Date: Mon, 25 Jan 2010 19:28:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001251927460.8733@intel-tinevez-2-302>
References: <cover.1263447037.git.mhagger@alum.mit.edu> <aa37ee8a68d460df172b23b4999fbe4ce7d77c1e.1263447037.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:55:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZU5a-0005ep-7f
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 19:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab0AYSzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 13:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753806Ab0AYSy7
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 13:54:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:41296 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752203Ab0AYSy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 13:54:59 -0500
Received: (qmail invoked by alias); 25 Jan 2010 18:28:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 25 Jan 2010 19:28:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lK8phCfOlm0T8cOyv1N/JSsXVGTEdWzjk0ZrrRi
	nZ7yaFNkW8+c2X
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <aa37ee8a68d460df172b23b4999fbe4ce7d77c1e.1263447037.git.mhagger@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137979>

Hi,

On Thu, 14 Jan 2010, Michael Haggerty wrote:

> @@ -166,7 +166,8 @@ pick_one () {
>  	parent_sha1=$(git rev-parse --verify $sha1^) ||
>  		die "Could not get the parent of $sha1"
>  	current_sha1=$(git rev-parse --verify HEAD)
> -	if test "$no_ff$current_sha1" = "$parent_sha1"; then
> +	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"

Rather use &&, right?

Ciao,
Dscho
