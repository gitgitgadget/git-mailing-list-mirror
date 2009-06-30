From: Eric Raible <raible@gmail.com>
Subject: RFH - git-log variant that _does_ search through diffs
Date: Mon, 29 Jun 2009 17:08:47 -0700
Message-ID: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 30 02:08:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLQu9-0000oR-IR
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 02:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756997AbZF3AIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 20:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZF3AIp
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 20:08:45 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:63620 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbZF3AIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 20:08:44 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1909738qwb.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=1zzPsJVfPGwpuO7QC/fQVTinZcLZw9idJRh8f39sSEo=;
        b=H09qc10qE6kWqzGj8vqjJrfbh7dDrg/XTfoT0gZv11R0cJY9QBR9cqUGfpFglMAu8I
         NTHDGEstW9sRUQogLGdO56Z/7q7XpI1hUAgX9vg0urTNNBuI2NJx0IRi9GW+9YEXxXWF
         AAKpxiMSK5e11lUydKGsrvD+PteAGr8duq8+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=tNCeJV32hOiQyI+z7eXfqJ0OjTddMsCaN6bJIgutDeoFB7V3GVYHMkN79ZcRjnn9pa
         41Vd8sbuk1+GpMFyGNURWus9rP3phd+zCQasVrSj0lgPaV60IqSrjqrmHBYuH1k4LFul
         6IMyma3nBL6UxdLOJEHnTLdFl2n4S6ZaDAFEI=
Received: by 10.220.92.204 with SMTP id s12mr4919012vcm.30.1246320527333; Mon, 
	29 Jun 2009 17:08:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122478>

[Surely this has been address before,  but I wasn't able to find it...]

The documentation for git-log -S includes:

"Look for differences that introduce or remove an instance of <string>.
 Note that this is different than the string simply appearing in diff output"

But I want to do that "different" thing (IOW I want search the diff output).

So must I loop through git-rev-list, grepping git-diff output on each commit?

Or if it _is_ possible to search the diff output directly then it
might be useful
to link to the relevant description instead of saying what -S doesn't do.

Thanks - Eric
