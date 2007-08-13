From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Integrating the kernel tree and lkml
Date: Sun, 12 Aug 2007 20:31:22 -0400
Message-ID: <9e4733910708121731h1245eab3h9e331de8285daf8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 02:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKNqB-0000k5-RT
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 02:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934257AbXHMAbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 20:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933554AbXHMAbZ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 20:31:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:60374 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758719AbXHMAbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 20:31:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1666744wah
        for <git@vger.kernel.org>; Sun, 12 Aug 2007 17:31:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SgmFo20w3gZ4d/WgXFY/+WrNYKTfD42twMZ2crdV5yXBaX23+K5m9jB7oUe7VyALXRfN1ZfhZJL/+F2EAQ+kuh8XJlvl7Y0dhxalmGwAFuC+Z/0vfH5hTuOi7YQ3GAhq/kICCXEazrEIaqaTbL7qz1Fmy/62Tq5B6G9oiMgipyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MeBoyimlJQaC6QDMFDg1Sih6cR9dNilYg9CdWeeumGfma9JdDhP9yq0VyuDC1xObqgNzcaDqP4jgXEZxUCScIbqlZ4PEgvFGXsq6OVvgA6t4nB5GF1zqio42k1NPuBetgmQqrsHLlYbyJ2uOnyR4DlzLpXSzGwDysGW7VVA8C34=
Received: by 10.115.76.1 with SMTP id d1mr2323279wal.1186965082961;
        Sun, 12 Aug 2007 17:31:22 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Sun, 12 Aug 2007 17:31:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55737>

The thread about using a news reader to read the git history caused me
wonder if are other synergies between git and the mail/news world.

You could load the lkml history into the git db along with the kernel
tree. Then process the mailing list history to tie discussion threads
to commits. As you look at commits with gitk you could also see the
relevant messages on lkml.

Of course post processing lkml may not tie the threads to the commits
very well. But if we built something like this we could start putting
the right clues into the threads to make sure they get linked to the
commits properly in the future. For example you could link an existing
thread by including the sha1 of the commit in a reply.

The git kernel history is about three years old. How big is three
years of lkml put into git and packed? A db like this may not be for
everyone but it could always live on a server with web access.

-- 
Jon Smirl
jonsmirl@gmail.com
