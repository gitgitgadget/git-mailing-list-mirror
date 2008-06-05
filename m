From: iiijjjiii <iiijjjiii@gmail.com>
Subject: Sharing home and etc files with git
Date: Thu, 05 Jun 2008 16:01:11 -0400
Message-ID: <48484607.5090505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:02:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Lf6-00054j-EQ
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbYFEUBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbYFEUBW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:01:22 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:35326 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYFEUBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:01:21 -0400
Received: by yw-out-2324.google.com with SMTP id 9so493981ywe.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=+ikUSlN4zRJAYiy97LUme5zLLC9ESnvNDelXOPDe91k=;
        b=Wm9yDCPHaUBerl9rn6NslhFnmzuXGuOn1tJsttgpAACU5uPo7mij88E8zRX4e/4iNs
         MdAt6pGPwtomAcT50iP6y5P2EBYUIffPIncfKF4TW/H6Svj1pOvfh10E3fGbVHVDDYiA
         2+51paX+TXUM3+n1KmR1cay2kd1eQzprgvjoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=m1voZtF7E50XzXHOEk2AuKPodFan1QPSZT2g4DXxe143XgYxa1z6/iM/nbfQNJ1NhD
         EYqAfK1naUIRhYmfCjRzpuln/C+uyDDlMA98h/sk9m5mg6omaH5nlnn6yj432+eoFzfM
         g7XJtbrmaSE5gxavcQrCLiYg+JLeI9xXyGB/Y=
Received: by 10.150.49.1 with SMTP id w1mr2382298ybw.22.1212696076653;
        Thu, 05 Jun 2008 13:01:16 -0700 (PDT)
Received: from ?192.168.110.125? ( [66.59.162.167])
        by mx.google.com with ESMTPS id k41sm2774077rnd.8.2008.06.05.13.01.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 13:01:16 -0700 (PDT)
User-Agent: Thunderbird 3.0a1 (X11/2008050714)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83964>

I would like to use git to keep revision histories of my home and etc 
directories. I have several computers and I like to keep their 
environments similar. I could see git pulls updating .bash_aliases, 
.bashrc, and various bash and perl scripts I create in the home 
directory, and updating /etc config files. Git pushes would share any 
recent changes to other computers. This way no matter which computer I 
am working on, the environment will be similar and I can make changes 
and know they will be copied to the others.

I haven't figured out a good way to deal with the files that have local 
settings in them. Using .gitignore feels a little overkill. Only certain 
lines of the files need to be unique. Once they are set, I'd like 
subsequent changes to be updated. I could cherry-pick manually but I'd 
like a more automated method. I have read about etckeeper, 
git-home-history and gibak, but they seem to be designed for backing up 
and versioning files on one computer and not for sharing files.

Has anyone done something similar using git or is another tool more 
suitable.

Thanks
jimk
