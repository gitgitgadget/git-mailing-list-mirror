From: Neil Macneale <mac4-git@theory.org>
Subject: Stashing untracked files
Date: Sat, 29 Sep 2007 11:27:48 -0700
Message-ID: <46FE9924.7080006@theory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 21:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbhZc-00077E-4i
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 21:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbXI2TBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 15:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754456AbXI2TBE
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 15:01:04 -0400
Received: from bucky.theory.org ([64.147.163.245]:37821 "EHLO bucky.theory.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbXI2TBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 15:01:03 -0400
X-Greylist: delayed 1991 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Sep 2007 15:01:03 EDT
Received: by bucky.theory.org (Postfix, from userid 8000)
	id 79A00DB3F; Sat, 29 Sep 2007 11:27:52 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bucky.theory.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.5 tests=BAYES_00,RCVD_IN_NJABL_DUL,
	RCVD_IN_PBL,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb
Received: from [10.0.1.199] (71-35-171-1.tukw.qwest.net [71.35.171.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bucky.theory.org (Postfix) with ESMTP id 2470B142C
	for <git@vger.kernel.org>; Sat, 29 Sep 2007 11:27:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59485>

Hi All,

I'm new to git, and I have a question regarding the best way to do 
something.

When using "git stash," in some cases I'd like to stash away files that 
are currently untracked. It seems to me like there should be a way to 
stash everything in a working directory so that the end result is a 
pristine tree. Then applying the stash will reinstate those file as 
untracked.

I understand that is not always desired, but sometimes it is (for me 
anyway). Perhaps an option like "git stash -u" could provide this behavior?

Is there some other approach that makes more sense? I don't want to 
start looking into this until I have some idea if this is a sane idea :-)

Thanks,
Neil
