From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Questions about repo and git submodule
Date: Tue, 23 Dec 2008 22:01:28 +0800
Message-ID: <856bfe0e0812230601m1765b483pe62c7902849e9cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 15:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF7qS-0003go-GS
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 15:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYLWOBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 09:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbYLWOBa
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 09:01:30 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:32775 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbYLWOB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 09:01:29 -0500
Received: by yw-out-2324.google.com with SMTP id 9so857520ywe.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 06:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=I2U1jJwebCsOUSNKIxtUSEne9BMG8NiM+T/DtCInuUI=;
        b=MhmhwBSAXhYpaiAcpkibsO5coxvl7E9S70k01e50prkyqG7MyOJ2XhdjoZsgANl4ti
         9dQRYob6G3iJTWe7y8hm+H7wZUUXtyMpPWDNriyyny59VEKSPPDXd0jgp53gyb29cbzE
         KJXgk2cIbuo48IVe5Tu08R7K2W9rg1m/NdBY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=JdHhUii163eZFjXrG3GLP1PW7Kh4f+HSD8nxvqGvP1HfS6w9sWLphZh5fxEVFPHQ5G
         mOUcH+jicPI3zipsy5y1wak8U/D+NIh3UcrmZ+GSQQ2+rhfT2R5j8K9+oqcMrVlkFTL6
         ZpwGD5NQ8O+NjQLaWNtJ9tOeLSuNadulSJPkg=
Received: by 10.150.50.1 with SMTP id x1mr14006524ybx.58.1230040888716;
        Tue, 23 Dec 2008 06:01:28 -0800 (PST)
Received: by 10.150.143.3 with HTTP; Tue, 23 Dec 2008 06:01:28 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103818>

All,

I have some questions about android repo and git submodule.

I created a repo repository with below commands:
1.  repo init -u git://android.git.kernel.org/platform/manifest.git
2.  repo initialized in /android

1. The android dir is not a git repository, if other people clone my
android code, how does it work?
2. I want to make android dir to be a git repository, is it workable
that I create submodule for each subdirectory in another directory? Is
there a script for it?

Thank you ！

Emily
