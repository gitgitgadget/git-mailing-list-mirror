From: Gerrit Pape <pape@smarden.org>
Subject: gitweb: incorrect search form layout when $site_header is in use
Date: Sat, 3 Feb 2007 22:39:35 +0000
Message-ID: <20070203223935.19469.qmail@b1fe9c509749cf.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 23:39:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDTXR-0004fI-9X
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 23:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbXBCWjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 17:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbXBCWjP
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 17:39:15 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:58257 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1751770AbXBCWjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 17:39:14 -0500
Received: (qmail 19470 invoked by uid 1000); 3 Feb 2007 22:39:35 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38615>

Hi, please see http://bugs.debian.org/408768:

> When $site_header is in use and some vertical space is added to the top
> of the web page, the search layout with CSS
> div.search {
>         position: absolute;
>         top: 56px;
>         right: 12px
> }
> is incorrect and ends up to cover the git logo.
> 
> Correcting this by using "position: inherit;" is complicated and may
> involve some code reorganization between
>    git_header_html();   and    git_print_page_nav(...);
> 
> Please forward this upstream for correction.

Thanks, Gerrit.
