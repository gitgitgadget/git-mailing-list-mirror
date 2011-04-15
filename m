From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 1/5] Documentation: describe the format of messages
	with inline patches
Date: Fri, 15 Apr 2011 16:11:31 -0400
Message-ID: <1302898291.5926.9.camel@drew-northup.unet.maine.edu>
References: <87d3kq6tz7.fsf@rho.meyering.net>
	 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
	 <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie>
	 <7vzkntkc9d.fsf@alter.siamese.dyndns.org> <20110414211125.GA15277@elie>
	 <7vlizcfpz8.fsf@alter.siamese.dyndns.org> <20110415021100.GA19829@elie>
	 <20110415022202.GB19829@elie>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:16:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QApRU-0000SF-JH
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 22:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab1DOUQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 16:16:31 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:54394 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab1DOUQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 16:16:30 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3FKBb1L004774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 15 Apr 2011 16:11:42 -0400
In-Reply-To: <20110415022202.GB19829@elie>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3FKBb1L004774
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1303503160.8971@aiKm0L2Ps3Mc3DzuAa6svA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171636>


On Thu, 2011-04-14 at 21:22 -0500, Jonathan Nieder wrote:
> Add a DISCUSSION section to the "git format-patch" manual to encourage
> people to send patches in a form that can be applied by "git am"
> automatically.  There are two such forms:
> 
>  1. The default form in which most metadata goes in the mail header
>     and the message body starts with the patch description;
...
> +DISCUSSION
> +----------
> +
> +The patch produced by 'git format-patch' is in UNIX mailbox format,
...
> +
> +arch/arm config files were slimmed down using a python script
...
> +Typically it will be placed in a MUA's drafts folder, edited to add
> +timely commentary that should not go in the changelog after the three
> +dashes, and then sent as a message whose body starts with "arch/arm
> +config files were".  On the receiving end, readers can save
> +interesting patches in a UNIX mailbox and apply them with
> +linkgit:git-am[1].

Maybe I'm too picky, but I'd feel more comfortable saying:

...
dashes, and then sent as a message which in our example stars with
"arch/arm config files were..." On the receiving end, readers can save
...


-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
