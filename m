From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Q: why submodules references are different from tree entries from 
	point of view of sorting?
Date: Fri, 26 Jun 2009 21:19:24 +0400
Message-ID: <85647ef50906261019x1cf20245j968aacd5a988c85e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKF5Z-0003lL-NA
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 19:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZFZRTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 13:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbZFZRTX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 13:19:23 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:53198 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbZFZRTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 13:19:23 -0400
Received: by ewy6 with SMTP id 6so3572222ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=CpGfw+N6o/K2v6kDPWw0KGxBWLm/EIltpkUfS38EqHY=;
        b=DGkgzbPK1HIceIpqrlsAe1lLEPiTdt02CfJGZn1MoZ7HymD3k2V0dXZ53AITarzDsJ
         v75KIJfe+JvT6DQiQ1L0LFF9NJguY1an7laC5uPD00EFim5LupurCcTjoPl3hKffNeaW
         WE6ftBfmpUGI7HNM+pjIHh9LOSb3jwy+dSi/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=K18/vZrN1Zx5/o5Wh3tg9taQEU/6fsL04gOKZHsTdAevlPz2X4J2k9R2s9DnZgZBrS
         byctZcEG+So/ecWLSox+NY2pCHncGwFNANakbE3v8hB9XAA9/2QWYFRhA8LwC7ywknXI
         RO7u0HH15cZltf5nTQyIE+KI6rz1tz3DtDVVA=
Received: by 10.216.72.83 with SMTP id s61mr1229362wed.79.1246036764332; Fri, 
	26 Jun 2009 10:19:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122309>

Hello!

The submodule entry is an indirect reference to tree stored in commit
in another repository. But for some reason it is ordered in the same
way as a normal file entry rather than as a tree entry (with virtual
"/" at the end).

What was the reason for ordering submodule references this way?

Regards,
Constantine
