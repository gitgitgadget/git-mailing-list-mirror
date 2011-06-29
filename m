From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: removing files from history but not filesystem
Date: Wed, 29 Jun 2011 18:57:10 +0200
Message-ID: <1309366630.2417.51.camel@oxylap>
References: <CFCCFA00-B4BF-4A88-88A5-2F588630F7BB@uab.edu>
	 <218bf1d3b2bf197a5f56d542c6a91960.squirrel@mail.localhost.li>
	 <D56E9579-BD93-42AC-BA45-E0DC20F4BB48@uab.edu>
	 <1309327707.2417.49.camel@oxylap>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Shantanu Pavgi <pavgi@uab.edu>
X-From: git-owner@vger.kernel.org Wed Jun 29 18:57:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qby4r-0002oR-B9
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 18:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab1F2Q5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 12:57:21 -0400
Received: from vserver.localhost.li ([85.214.46.152]:39360 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab1F2Q5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 12:57:19 -0400
Received: from p5794c8fc.dip.t-dialin.net ([87.148.200.252]:41890 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1Qby4e-00012F-V6; Wed, 29 Jun 2011 18:57:13 +0200
In-Reply-To: <1309327707.2417.49.camel@oxylap>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176447>

> Another possible way would be to create a temporary branch to point at
> HEAD^, filter-branch it, then add a graft to stitch the remaining commit
> on top of it, then filter-branch HEAD and then remove the branch. But
> this is a bit advanced for the case where you just want to omit one
> commit.
That should have been "[...] and then remove the _graft_." (and the
temporary branch).

Regards,
  Chris
