From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: repack: handling of .keep files
Date: Fri, 4 May 2007 11:25:20 +0200
Message-ID: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 04 11:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hju2X-0004wD-Mv
	for gcvg-git@gmane.org; Fri, 04 May 2007 11:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933057AbXEDJZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 05:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933046AbXEDJZW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 05:25:22 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:27656 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767758AbXEDJZU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 05:25:20 -0400
Received: by an-out-0708.google.com with SMTP id b33so771548ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 02:25:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FADnq/cIe3zh51HCftC6o+vdOmJ1uQH4paL6jYUAMD+PBnCNTZrcefh1xiTJZOxKixR1u0bO5UCAuHITWK/omElSeqqTj0ItJGxeesnOnT5vCD7J5N+OnE9eF6RZdGZJNwLFikrhcWULAMHjHUUafI4WGLWRiuFpbV07PUnwt3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QsuUGhDL62O7csfPdfTXD603s20ycRiDlHKbU+bGYJDEKIr55UkgH2z4lVSCt+/veWur+FVKW3I9qleAZHz+bfmp+/H18bmDL45RVPGL9IoCgjee+5d4N4+5oOwb+9/nPuyfIVzeNtZFbIezTqN3Z7ceJOSY4COjWZGm3uUvur4=
Received: by 10.100.40.17 with SMTP id n17mr2511236ann.1178270720270;
        Fri, 04 May 2007 02:25:20 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 02:25:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46151>

It does not seem to be consistent with the name:
"git repack -a -d" removes .keep files anyway.

How can I pin down a pack file so that it is never repacked?
(Windows doesn't like big files, they get fragmented heavily
and are hard to read and defragment. So I try keep them
relatively small).

P.S. Experimenting with the .keep-files I had a crash in git-log,
when the pack was renamed into .keep.pack, but the
index was not. git-log complained about two objects it could not
read and than crashed. It's cygwin.
