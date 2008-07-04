From: "Neshama Parhoti" <pneshama@gmail.com>
Subject: can't push to ransom ssh port ?
Date: Fri, 4 Jul 2008 16:28:59 +0300
Message-ID: <912ec82a0807040628k14c8acd1ree9d82b68f69e080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 15:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElMc-0000eU-E8
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758483AbYGDN3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758524AbYGDN3C
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:29:02 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:53091 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758419AbYGDN3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:29:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so244133and.103
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=oH8ASKj8ad3eeqLqiQxTAOHwMUHN0C04FKSwCMru8S4=;
        b=h2fuIQiPb0qUSFZ/Ch8rKKSH74TKUGsi1omg6l2EqAelCHk0Qzc6ivBkPaVD3S/t46
         mR28ut7dPum5+4llco5bQZyF7aZ2gOVltZGzmC7ybz8Jz+bTHqx/nWZcy0z3cDMktZdq
         RtqybHI/fBgBeDmcD/0dRR4jMwaGJGsu8Wiig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gUi4srheo0P+O2iey5CzfGJQqkkfXMV4M4ovLDyKZJrpsYFZODcer01AF+b0F0+xv2
         9W9d0aeABhjwkwvs97LtQWnb2NTcdJv5PAAWDGFoKeom3xgC1OxpD8i8wU5AvTEnwlZx
         FMytf5EhH6Y1PigvYq/eYTwgpNcB4glwz6znQ=
Received: by 10.100.96.9 with SMTP id t9mr726881anb.143.1215178139391;
        Fri, 04 Jul 2008 06:28:59 -0700 (PDT)
Received: by 10.100.134.20 with HTTP; Fri, 4 Jul 2008 06:28:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87387>

Hi all,

Doing the following:

git push myuser@myip:~/gitrepo

Connects to ssh port 22 on myip.

Is there a way to tell git to connect to a random port X ?

(something like ssh's -p parameter)

I can't find how and I really need that..

Thank you!
pnesh
