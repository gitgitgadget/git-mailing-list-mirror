From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Are "private blobs/trees" possible?
Date: Mon, 25 Oct 2010 16:10:05 -0400
Message-ID: <1288037406.819.93.camel@drew-northup.unet.maine.edu>
References: <AANLkTimQ7Z9Cd2yKw5jFD6UBzFRBZk_-SpC7jc6+JACw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kynn Jones <kynnjo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 22:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PATTp-0002Qm-2X
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 22:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757816Ab0JYURM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 16:17:12 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:60501 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab0JYURL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 16:17:11 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9PKACRA005425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 25 Oct 2010 16:10:12 -0400
In-Reply-To: <AANLkTimQ7Z9Cd2yKw5jFD6UBzFRBZk_-SpC7jc6+JACw@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9PKACRA005425
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288642236.10118@o+70m7VjFA/uG4QYqeBgcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159970>


On Mon, 2010-10-25 at 15:19 -0400, Kynn Jones wrote:
> There are some files that I want to keep under local git control, but never
> push to any remote repositories.
> 
> What's the best way to implement this idea with git?
> 
> The best solution I can think of is to put these files in some
> git-controlled directory that is not below the "main" working directory, and
> have an (ignored) symlink to it in this working directory.
> 
> Is there a better way?
> 
> TIA!

There is no restriction that you only have one git repository on any
given machine.... Set up your symlink to those files in their own git
repository.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
