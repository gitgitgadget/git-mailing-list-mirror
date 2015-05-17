From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: Remove mc parameter from proc show_error
Date: Sun, 17 May 2015 10:52:27 +1000
Message-ID: <20150517005227.GA21039@iris.ozlabs.ibm.com>
References: <1431372401-8750-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bernt@norang.ca, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 06:22:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ytq5k-0000C9-C9
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 06:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbEQEWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 00:22:12 -0400
Received: from ozlabs.org ([103.22.144.67]:38949 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbbEQEWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 00:22:03 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id F0E1A140B04; Sun, 17 May 2015 14:21:59 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1431372401-8750-1-git-send-email-alexhenrie24@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269209>

On Mon, May 11, 2015 at 01:26:41PM -0600, Alex Henrie wrote:
> This is a better fix for 8d849957d81fc0480a52570d66cc3c2a688ecb1b.
> 
> This new fix makes the strings "Sorry, gitk cannot run..." and "OK"
> translatable and the string "mc" not translatable. It will take effect
> the next time `make update-po` is run.
> 
> msgcat is now imported before the Tcl/Tk version check so that the mc
> function is available even if the version check fails. This should not
> be a problem because msgcat and ::msgcat::mc were officially added in
> Tcl 8.1 (released April 29, 1999) and we are not trying to support
> versions of Tcl older than that.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

Thanks, applied.

Paul.
