From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] Use .git/MERGE_MSG in cherry-pick/revert
Date: Tue, 8 May 2007 07:20:56 +0000
Message-ID: <20070508072056.16912.qmail@48dfd32da30381.315fe32.mid.smarden.org>
References: <20070508015447.GA22253@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 09:21:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlK0P-0008CR-VP
	for gcvg-git@gmane.org; Tue, 08 May 2007 09:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613AbXEHHUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 03:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755614AbXEHHUj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 03:20:39 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:36715 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755613AbXEHHUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 03:20:38 -0400
Received: (qmail 16913 invoked by uid 1000); 8 May 2007 07:20:56 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070508015447.GA22253@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46548>

On Mon, May 07, 2007 at 09:54:47PM -0400, Shawn O. Pearce wrote:
> Rather than storing the temporary commit message data in .msg (in
> the working tree) we now store the message data in .git/MERGE_MSG.

Hi, there's one more error message referring to '.msg':

 static void add_to_msg(const char *string)
 {
 	int len = strlen(string);
 	if (write_in_full(msg_fd, string, len) < 0)
 		die ("Could not write to .msg");
 }

Thanks, Gerrit.
