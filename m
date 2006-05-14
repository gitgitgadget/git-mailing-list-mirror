From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Howto get the merge-base ?
Date: Sun, 14 May 2006 19:21:01 +0200
Message-ID: <4fb292fa0605141021r20cefaa0he592b9c713ede333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun May 14 19:21:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfKHD-0004e4-KN
	for gcvg-git@gmane.org; Sun, 14 May 2006 19:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWENRVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 13:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWENRVD
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 13:21:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:37083 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751293AbWENRVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 13:21:03 -0400
Received: by nf-out-0910.google.com with SMTP id c29so6170nfb
        for <git@vger.kernel.org>; Sun, 14 May 2006 10:21:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pX1A8wS2hyefn12O+nQs3ABlfpt0eZJsgFyo2501ZJbc12WFm7vi+334EEMzHPbcI/mGI5Ww+2XWUGJIt2hwttig7fQGaWNR7zHezhun2eQ9V8St/K3mC1rOuu0b41VLBnuBZuH6DoPZmvogiys9vrVOB5HFFszN1JOro+ha/xQ=
Received: by 10.48.213.13 with SMTP id l13mr2719105nfg;
        Sun, 14 May 2006 10:21:01 -0700 (PDT)
Received: by 10.49.5.5 with HTTP; Sun, 14 May 2006 10:21:01 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19970>

Hi,

I'm trying to know which commit it the parent of a merge.
For exemple if I do that :

   o Merge
  / \
 /   \
 |   |
 |   o Commit D
 |   |
 |   o Commit C
 |   |
 o   | Commit B
 \  /
  \/
  o Commit A
  |
  o Init

How could I know that ``Commit A'' is the merge-base of ``Merge'' ?

I try to get this git-merge-base but result is strange and quiet
mysterious as he return me always second args I passed to. I'm using
git 1.3.2

-- 
Beber
#e.fr@freenode
