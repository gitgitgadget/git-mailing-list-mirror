From: Caleb Cushing <xenoterracide@gmail.com>
Subject: mergetool ignore
Date: Fri, 16 Jan 2009 15:19:30 -0500
Message-ID: <81bfc67a0901161219l23877df8xf1707aaf9e83bcb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 21:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNvBZ-00061U-Gt
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 21:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020AbZAPUTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 15:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757263AbZAPUTd
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 15:19:33 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:49872 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbZAPUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 15:19:32 -0500
Received: by bwz14 with SMTP id 14so5607963bwz.13
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=2a9dGY0xu927hy0OeT3DMLWronconKvOGCEd64mXAX0=;
        b=AcEAVGy44Fw2DqBfmRiwKyp+H4waNDWtLgAuCkVPQO+9F12UoE1n8/8hneEzsn5oBv
         6sAuekRcK0x60r5hfNlnm8wXWluMVJaTk3WWff4hkwl//RyaBknHQTY57JVemyGnWDGD
         tNB2ysOPtrxQhDW/2Al2j9P1O4ESjsfn3WaqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=DNZAGQS2YtPBSrmRuDr/OQH3D7uF8AHDPEsYC6OkJbkdHYIoRwyhl7dZwg0JovQZd0
         r+MPAQ0mZphMhbGZtnpAk4NNeFakyGWiTrxjTrpnnZgYv6h3Fp4TmW+p+pX8yrbCLKrj
         dUhPqNxI3BExvQLrrJaySF3uykz8vC4K7fAQ4=
Received: by 10.223.124.209 with SMTP id v17mr3486872far.6.1232137170596; Fri, 
	16 Jan 2009 12:19:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105991>

is there any way to tell git to ignore merging certain files? I've got
files that have the same name in each directory. but I can't merge
them with an editor... it'd be easier to be able to ignore them with
git mergetool... and handle them manually.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
