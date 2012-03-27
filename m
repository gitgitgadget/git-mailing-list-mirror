From: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull gitk update
Date: Tue, 27 Mar 2012 20:52:05 +1100
Message-ID: <20120327095204.GA8718@bloggs.ozlabs.ibm.com>
References: <20120324055540.GA20898@bloggs.ozlabs.ibm.com>
 <7vsjgvkl69.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 11:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCT5l-00020m-FU
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 11:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938Ab2C0JxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 05:53:25 -0400
Received: from ozlabs.org ([203.10.76.45]:45664 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757908Ab2C0JxY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 05:53:24 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6E8BCB6EF1; Tue, 27 Mar 2012 20:53:23 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <7vsjgvkl69.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194036>

On Mon, Mar 26, 2012 at 04:16:30PM -0700, Junio C Hamano wrote:
> Here is what I came up with after looking at the result of this pull.
> Could you eyeball it?
> 
> Thanks.
> 
> diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
> index 11b0b10..e1f493c 100644
> --- a/Documentation/RelNotes/1.7.10.txt
> +++ b/Documentation/RelNotes/1.7.10.txt
> @@ -46,6 +46,14 @@ Updates since v1.7.9
>  UI, Workflows & Features
>  
>   * various "gitk" updates.
> +   - show the path to the top level directory in the window title
> +   - update preference edit dialog
> +   - pathspecs like "gitk -- .", "gitk -- ..\t" did not work well

This sounds a bit awkward, how about:

 +   - display file list correctly when directories are given on command line

or something like that?

> +   - make "git-describe" output in the log message into a clickable link
> +   - avoid matching the UNIX timestamp part when searching all fields
> +   - give preference to symboic font names like sans & monospace
> +   - allow comparing two commits using a mark
> +   - "gitk" honors log.showroot configuration.
>  
>   * Teams for localizing the messages from the Porcelain layer of
>     commands are starting to form, thanks to Jiang Xin who volunteered

Other than that, looks fine.

Paul.
