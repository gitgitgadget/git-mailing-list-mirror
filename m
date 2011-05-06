From: Srinidhi K V <srinidhikv@yahoo.co.in>
Subject: Unable to push remote branches
Date: Fri, 6 May 2011 10:17:37 +0530
Message-ID: <BANLkTimd887k0D=OL9rSuq6Z3FkhNAFAbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 06:47:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QICxH-0004iq-VL
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 06:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab1EFEri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 00:47:38 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:60627 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab1EFEri (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 00:47:38 -0400
Received: by pxi16 with SMTP id 16so2060157pxi.4
        for <git@vger.kernel.org>; Thu, 05 May 2011 21:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=JoVq1BpZLty1LmSWkHWqi2uNNE1jAIPLdREHGIMRnXQ=;
        b=lS2DSSvslATPSdL4cZW40htW+Y74NBcr3QMobPDJADXX51a4V3/MhY4N433BHv/XFi
         2yvcmdP7/PN3/HcemtwXyIkL/AUNgPDHoej8xBOJIg5nF0LzDgyeeONVTrp80cP2VtAF
         pcmupEZdece6bbsszLobefp+p6QXUS1lNyE6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=cdB1t9hvXLAxjc1XAiht+nbalo/W521TslsLuP0wbtQksQyBP65kosX1/LnAkdIn5q
         WUq+oYNLkxaNIvroY/k5+s+5DA4eP3rK9J1KeI00W5zAnH5W09eHuLXJhmZQ+Mvel9vO
         p6ZFnUyd8yokwvFgZqU2KO29MEkdWgjcD/Ojw=
Received: by 10.143.39.17 with SMTP id r17mr1644734wfj.113.1304657257855; Thu,
 05 May 2011 21:47:37 -0700 (PDT)
Received: by 10.143.167.9 with HTTP; Thu, 5 May 2011 21:47:37 -0700 (PDT)
X-Google-Sender-Auth: QwPYjAvL1YEhahxQKzRM5RO5PYc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172936>

Hi All,

I have a GIT repository in which there are lot of remote branches, I
have created a bare git repository in my server. When I push my local
repository to the bare repository in server using "git push --all"
only local branches get pushed.
However when I use "git branch -r" I get remote branches which tracks
to local branch.
I need push all the existing remote branches from my local repo to
bare repository in my server. How do i do that? Any pointer would be
of great help.

Thanks in Advance
Srinidhi KV
