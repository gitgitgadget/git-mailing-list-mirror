From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible bug in 'git status' exit code is 1 instead of 0
Date: Tue, 9 Jan 2007 18:45:05 +0100
Message-ID: <e5bfff550701090945u5a240fe9xf46cc40b030e1ba7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 18:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4L27-00025x-Ul
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 18:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbXAIRpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 12:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbXAIRpI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 12:45:08 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:40893 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295AbXAIRpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 12:45:06 -0500
Received: by py-out-1112.google.com with SMTP id a29so4266702pyi
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 09:45:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i7g5LtA/P0+hC4Z1GB8i2yRFl5tGxrOAl8KXXk+BioLEimUl78/FtIhmDZDQVJ4Z79qShn/FNyify+fXXq55llIqhmSRwBGVHN6MeuQ/iOFupHKFNpu3r7W2xJ4oUNESNDQGrk3AhYooWaiNqClXz7cW+656cv0Yk5SmwAhv8kY=
Received: by 10.35.60.15 with SMTP id n15mr51362130pyk.1168364705845;
        Tue, 09 Jan 2007 09:45:05 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 9 Jan 2007 09:45:05 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36380>

bash-3.1$ pwd
/home/marco/programmi/git
bash-3.1$ git status; echo $?
# On branch refs/heads/origin
nothing to commit (use "git add file1 file2" to include for commit)
1
bash-3.1$ git --version
git version 1.5.0.rc0.g244a7
