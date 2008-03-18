From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: [RFC] git-bisect unsure
Date: Tue, 18 Mar 2008 11:57:41 -0400
Message-ID: <CE6D7D80-DC0F-4840-8B95-7482EE0E71A3@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 01:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8wd-0002ip-0X
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936510AbYCTAqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 20:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765310AbYCTAqv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:46:51 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:8774 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936075AbYCTAqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:46:49 -0400
Received: by an-out-0708.google.com with SMTP id d31so174367and.103
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 17:46:48 -0700 (PDT)
Received: by 10.100.122.8 with SMTP id u8mr2073701anc.103.1205855864779;
        Tue, 18 Mar 2008 08:57:44 -0700 (PDT)
Received: from ?172.30.3.237? ( [80.67.64.10])
        by mx.google.com with ESMTPS id c27sm23488853ana.27.2008.03.18.08.57.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Mar 2008 08:57:43 -0700 (PDT)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77603>

I'm in the middle of tracking down a bug, unfortunately one of the  
commits that git-bisect chose had an unrelated problem in it that  
broke my build. As a result I don't know if this version is good or  
bad as far as the bug I'm trying to track down is concerned. I would  
think of a number of situations where one bug could interfere with the  
testing of another.

My proposal is to add an "unsure" option to git-bisect.

I'm thinking that when you say "git bisect unsure" it would simply  
shift one commit earlier or later and refrain from ever checking out  
one marked unsure until there were only "unsure" ones left at which  
point it would add a disclaimer when you called bad or good and throw  
up it's hands in frustration if you were to say "unsure" again.

-Kate
