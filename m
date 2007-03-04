From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Add dangling object and unreachable object in glossary.txt
Date: Sun, 4 Mar 2007 14:03:22 -0500
Message-ID: <20070304190322.GA3644@filer.fsl.cs.sunysb.edu>
References: <3c6c07c20702260835v4865ace1u18a20f6b1d0030b5@mail.gmail.com> <7virdolm8u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702261216380.12485@woody.linux-foundation.org> <87649g991s.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 20:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNvzY-0004cN-Su
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 20:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbXCDTD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 14:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbXCDTD2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 14:03:28 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53101 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbXCDTD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 14:03:28 -0500
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l24J3M0h006629;
	Sun, 4 Mar 2007 14:03:22 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l24J3MSg006627;
	Sun, 4 Mar 2007 14:03:22 -0500
Content-Disposition: inline
In-Reply-To: <87649g991s.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41366>

On Mon, Mar 05, 2007 at 03:07:43AM +0900, Yasushi SHOJI wrote:
> ---
> Would it be worth to add these two entery in
> Documentation/glossary.txt?
> 
> English isn't my mother tang, so please check it.
> -- 
>          yashi
> 
> 
> 
> diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
> index d20eb62..ee48009 100644
> --- a/Documentation/glossary.txt
> +++ b/Documentation/glossary.txt
> @@ -73,6 +73,11 @@ DAG::
>  	objects is acyclic (there is no chain which begins and ends with the
>  	same object).
>  
> +dangling object::
> +	An object which is a very special case of unreachable object;
> +	it is not reachable from anything, including unreachable
> +	objects.

"...including other unreachable objects." ?

Josef "Jeff" Sipek.

-- 
Don't drink and derive. Alcohol and algebra don't mix.
