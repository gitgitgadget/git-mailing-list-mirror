From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GIT & Symbolic Links
Date: Sat, 17 Mar 2012 17:05:12 +0000
Message-ID: <4F64C448.5040108@pileofstuff.org>
References: <CACHQFzEqe-SwpCgjgGRDdzcUQW_+8-TdLsRV6KbKorvq7dJi+g@mail.gmail.com> <CACHQFzEJATc2hiSdAgoGg3vssQ-CShF+89TOkzVwaf_ujYy+3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Sassy Natan <sassyn@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 18:05:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8x4E-0007h6-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 18:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030701Ab2CQRFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 13:05:18 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:26092 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030419Ab2CQRFQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 13:05:16 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120317170514.ZKXF6650.mtaout01-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Sat, 17 Mar 2012 17:05:14 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120317170514.EXZR23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 17 Mar 2012 17:05:14 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CACHQFzEJATc2hiSdAgoGg3vssQ-CShF+89TOkzVwaf_ujYy+3w@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=-vMK40QVZDZxnkmlXUYA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193340>

Not really an answer to your question, but `git-relink` will
de-duplicate the contents of your .git directory using hardlinks.  Your
actual files will remain as big as ever, but the (potentially much
larger) git storage for older versions will take considerably less disk
space.

	- Andrew
