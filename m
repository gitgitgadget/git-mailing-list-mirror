From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: git push controls / config
Date: Tue, 22 Jun 2010 16:20:37 +0530
Message-ID: <AANLkTin8O01vNL8JlPcNqB7FdvMssjOce_YFF82iW6GC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 22 12:50:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR14C-0002j1-9M
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 12:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759267Ab0FVKuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 06:50:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37437 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314Ab0FVKuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 06:50:39 -0400
Received: by gwaa12 with SMTP id a12so866895gwa.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=+Sp3tC4RMm4wbPj3loq8HyEOrJ9BieXhpo2Okuh4tsU=;
        b=DtLh64v77dxVZWhEtrzZNghcD9k6eqlCIF3xk4JGvERCUTeX2KqO1ZrBEOCaYj0gtA
         k5wSaguLDapIN2cnaMRNXrkXa5gL4dw9WKDb3ztVl+txr5SZnjoXUUrpiSZE+oLKYEeC
         8sJJ+VUXu1fwAHDXfFmoDbusC+j7/B7kZnQWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=TAz3lJaN+2z6LQlvFXZmYBx4eZT8jOQkb6+gArSr4G7sJDgWFFKb/+XikegBSPKUUC
         cGCnUcdVo+huxmioDcBuRkXpvQR//u4vB7f0d4xfxsP0yAoYwh9xycKpPipnv43t37/j
         wbmqS1fg7fbLgvg1NNVcCt2Z5P33obASZ+mgE=
Received: by 10.91.92.2 with SMTP id u2mr3806784agl.102.1277203837497; Tue, 22 
	Jun 2010 03:50:37 -0700 (PDT)
Received: by 10.90.25.8 with HTTP; Tue, 22 Jun 2010 03:50:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149470>

How can I prevent (via a config file) someone from pushing a

1) same commit with --amend;
      - we rely on commit log; bug number. If some one changes bug
number via amend; that risks the integrity.

2) creating and removing Tags and Branches
    - same - Tags are of special importance to us.



Thx/ Mahesh
