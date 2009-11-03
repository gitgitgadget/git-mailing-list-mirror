From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Skip translation of wrong Tcl version text
Date: Tue, 3 Nov 2009 22:31:21 +1100
Message-ID: <19184.5257.944412.835848@cargo.ozlabs.ibm.com>
References: <1256415640-10328-1-git-send-email-bernt@norang.ca>
	<1256415640-10328-2-git-send-email-bernt@norang.ca>
	<87d443xn5u.fsf@users.sourceforge.net>
	<874opel7de.fsf@gollum.intra.norang.ca>
	<87ljipje03.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Tue Nov 03 12:33:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Hdf-00020U-RJ
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 12:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZKCLdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 06:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbZKCLdI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 06:33:08 -0500
Received: from ozlabs.org ([203.10.76.45]:56775 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbZKCLdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 06:33:06 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 55F3AB7BE1; Tue,  3 Nov 2009 22:33:08 +1100 (EST)
In-Reply-To: <87ljipje03.fsf@gollum.intra.norang.ca>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131966>

Bernt Hansen writes:

> We check the required Tcl version number before we setup msgcat for
> language translation.  If the Tcl version is too old just display the
> untranslated error text.
> 
> The caller of show_error can now pass an alternative function for mc.
> The Tcl list function turns the transalation into a no-op.
> 
> This fixes the
>     Error in startup script: invalid command name "mc"
> when attempting to start gitk with Tcl 8.3.
> 
> Signed-off-by: Bernt Hansen <bernt@norang.ca>

Thanks, applied.

Paul.
