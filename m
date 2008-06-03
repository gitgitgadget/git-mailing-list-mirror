From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: [JGIT RFC] Mavenized JGit
Date: Tue, 3 Jun 2008 20:42:33 +0600
Message-ID: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 16:44:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3XjZ-0001cs-Bk
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbYFCOmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbYFCOmk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:42:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:61046 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbYFCOmj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 10:42:39 -0400
Received: by yw-out-2324.google.com with SMTP id 9so820013ywe.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=tAgz1E48V9ikveB777SzEBK3fI20sRCHKcS1Gj9nLLw=;
        b=c79b7gaa65jYltyR5C75ncJ/Tzj9TF+85hgDtE4E+m5y23bQsSTR7swy1X48kxug9w8cZo8qUe70q1DwNKFz1lkRa64Kdm0/RODZGiUPWRhtzMFqi3HKqfRBVorkySnjDlu/jUMIS/sYA1sFG73PaJbpU8rKxOeXmuOS46uCM6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Bl1eq5b9dOzKgn82Gc+CzRBFdFszXRMi354rQ+tSiXPz2lQRYCGdPs0+GgWORageZD08jAfKGsWBVsv/nnYSjyqE2yfh1+wVWjbhtX0MchjIigkhNC+8ELdPqB7gXsHaGvlwBhrSaOKzxPOIjWY/jkuf/KxODsnTGFeE+gV0bjA=
Received: by 10.150.191.15 with SMTP id o15mr7695267ybf.54.1212504158629;
        Tue, 03 Jun 2008 07:42:38 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Tue, 3 Jun 2008 07:42:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83669>

Hi,

I have successfully Mavenized JGit (at least partially :)) to make it
independent of IDE to develop on. I will also add a code-file format
checker soon. Please have a look at it and let me know what you think
and how it can be improved. If its helpful I will surely send out a
patch in this regard. The one thing that I did not configure is the
external test (exttst), doing that and the code format checker is my
next step.
The 'jgit-mavenize' branch of my fork of egit contains it.
(http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/jgit-mavenize).

Best regards,

-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
