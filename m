From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: Use DBI->table_info instead of DBI->tables
Date: Sat, 31 Mar 2007 16:09:19 +0200
Message-ID: <20070331140919.GW8017@planck.djpig.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de> <1175349467524-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 16:09:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXeGj-0003SW-07
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 16:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbXCaOJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 10:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbXCaOJW
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 10:09:22 -0400
Received: from planck.djpig.de ([85.10.192.180]:59636 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096AbXCaOJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 10:09:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 3AC6E88136
	for <git@vger.kernel.org>; Sat, 31 Mar 2007 16:09:20 +0200 (CEST)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23133-02 for <git@vger.kernel.org>;
	Sat, 31 Mar 2007 16:09:19 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 5FD8C88137; Sat, 31 Mar 2007 16:09:19 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1175349467524-git-send-email-frank@lichtenheld.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43557>

On Sat, Mar 31, 2007 at 03:57:47PM +0200, Frank Lichtenheld wrote:
> DBI->table_info is portable across different DBD backends,
> DBI->tables is not.
> 
> Limit the output to objects of type TABLE.
> ---

I just noticed I forgot to add the
"Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>"

Does one resend the patch in such cases?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
