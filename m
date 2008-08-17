From: "Ravi Chhabra" <ravi.chhabra@gmail.com>
Subject: Git+ssh, which config file should I use for ssh settings?
Date: Sun, 17 Aug 2008 15:56:27 +0630
Message-ID: <e975c1980808170226mc3e3812p76d8364df2b8f39e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 11:27:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUeXt-0002Lu-Lh
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 11:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbYHQJ0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 05:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbYHQJ0a
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 05:26:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:27197 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbYHQJ03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 05:26:29 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1572322rvb.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=bVvNDHprTTbpaz5kcyEAIqMFr2DKab/g1cY5rHuEiVE=;
        b=O+AHEZJh8yJauCmeVdAdn3qSaJm78dUSwUNdYg0f6g38W/OGUuXbtSKq3GybonBeDV
         3b8OtXEXhym3Q4emzcqHV0/UIK6iO0dw1E4D+V3bXv/RLAgrOAna/8ErmsYz7HORyr4f
         ZTtF2f5dvcBzi0kQyFf7qcK/t0qKop0U/++5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=n8kkl/Hofi8xGKj+DjvKRHGC+dtmlbqlVeWc687TT+zHo73SoUUrxWsJYDPw/fWx/E
         R/it3Rg2SbmhFakRQw6I62nwMH5dFAZBXCHSv1wiLphnW3S222hU1Tj03MTSA6YE8CXi
         G3ql4kK36WI0L1J/jGL37mDXFA87WHrLaePdo=
Received: by 10.140.249.20 with SMTP id w20mr2542603rvh.189.1218965187911;
        Sun, 17 Aug 2008 02:26:27 -0700 (PDT)
Received: by 10.141.123.14 with HTTP; Sun, 17 Aug 2008 02:26:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92592>

Good morning,
I set up a repo as follows:

git remote add origin git@git.assembla.com:mconverter.git

But, I can't push to it by using the command below:

git push origin master

I get:

ssh:fatal: The remote end hung up unexpectedly

If I run Git-Gui I push, I get:
ssh: connect to host git.assembla.com port 22: Bad file number
Pushing to git@git.assembla.com:mconverter.git
fatal: The remote end hung up unexpectedly

What am I doing wrong, and how did git know that I using git+ssh? I
installed Git on windows Vista, the SSH that comes with git is inside
the git program folder under 'bin'. So where do I place the config
files? My git folder is C:\Program Files\Git\, and ssh is in
C:\Program Files\Git\bin. Do I need to create etc folder under git and
name it as ssh_config for the ssh options? My ISP blocks all ports
except 443/80. I am trying to set up a tunnel to push git through.
Please help!
Ravi.
