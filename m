From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: Add horizontal scrollbar to the diff view
Date: Fri, 7 Mar 2008 10:04:35 +1100
Message-ID: <18384.30851.318641.612252@cargo.ozlabs.ibm.com>
References: <20080306123845.GA12115@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, newsletter@dirk.my1.cc, git@vger.kernel.org
To: kaitanie@cc.helsinki.fi
X-From: git-owner@vger.kernel.org Fri Mar 07 00:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXPAb-0001ua-Iu
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 00:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbYCFXGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 18:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757424AbYCFXF7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 18:05:59 -0500
Received: from ozlabs.org ([203.10.76.45]:44549 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756925AbYCFXF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 18:05:59 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id ED7D7DDF2D; Fri,  7 Mar 2008 10:05:57 +1100 (EST)
In-Reply-To: <20080306123845.GA12115@localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76431>

Pekka Kaitaniemi writes:

> -	-yscrollcommand scrolltext -wrap none
> +	-yscrollcommand scrolltext  -wrap none \

Why this whitespace change?

> +    scrollbar .bleft.sbhorizontal -command "$ctext xview" -orient h \
> +	-width 10

Are you using Tk 8.4 or 8.5?  With Tk 8.5 the scrollbars are thinner
and I wonder whether specifying a width of 10 will actually make it
fatter than it would be otherwise.

Paul.
