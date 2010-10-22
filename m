From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as
	UTF-8...?
Date: Fri, 22 Oct 2010 14:06:45 -0400
Message-ID: <1287770805.819.7.camel@drew-northup.unet.maine.edu>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
	 <20101022161851.GH9224@burratino>
	 <1287766916.31218.71.camel@drew-northup.unet.maine.edu>
	 <20101022171248.GA11794@burratino>
	 <1287768426.31218.75.camel@drew-northup.unet.maine.edu>
	 <m31v7iktkn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:08:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9M2P-0006t1-9x
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255Ab0JVSIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:08:15 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:59620 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119Ab0JVSIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:08:14 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9MI6oQP031765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 14:06:55 -0400
In-Reply-To: <m31v7iktkn.fsf@localhost.localdomain>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9MI6oQP031765
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288375616.19125@Y1RoEqbk2EMJmw7blEYtyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159720>


On Fri, 2010-10-22 at 10:48 -0700, Jakub Narebski wrote:
> Drew Northup <drew.northup@maine.edu> writes:

> > Well I shall plumb the documentation again.... just in case. I'm not
> > holding my breath that it will do what I (and frankly a fair number of
> > other people) want. We just want version control that treats text like
> > text. FULL STOP. Why isn't UTF-16 text???????
> 
> If you are asking why Git detects files with text in UTF-16 / USC-2 as
> binary, it is because Git (re)uses the same heuristic that e.g. GNU
> diff (and probably also -T file test in Perl), and one of heuristics
> is that if file contains NUL ("\0") character, then it is most
> porbably binary (because legacy C programs for text would have
> troubles with NUL characters).
> 
> That probably doesn't help you any...

I did find that already. I still have not decided that correct place to
shoehorn in Unicode detection, but I'll be sure to do that before I
bother anybody else with it. I already wrote code to detect (reasonably)
valid UTF-16 (if it isn't obviously valid then I'll just as soon deal
with it as binary data, so as to avoid a foot-shooting exercise).
My main motivation here has been to get some feedback as I write stuff
so as to not waste a lot of time during writing something that could be
done better. 
(As opposed to not done at all, which is the feeling I'm getting from a
few people around here...)
-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
