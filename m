From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 14:41:13 +0200
Organization: eudaptics software gmbh
Message-ID: <466E9469.5D6BD391@eudaptics.com>
References: <20070611225918.GD4323@planck.djpig.de> <466E7D7E.7BAB2FD@eudaptics.com> <8c5c35580706120412o516ec39p71332d23823d7389@mail.gmail.com> <200706121423.02127.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>, skimo@liacs.nl,
	git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:40:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy5fI-0006Qh-GM
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 14:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbXFLMj4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 08:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbXFLMj4
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 08:39:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:13696 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbXFLMjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 08:39:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1Hy5f5-0003Rv-7b; Tue, 12 Jun 2007 14:39:51 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E96C354D; Tue, 12 Jun 2007 14:39:49 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.039
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49957>

Josef Weidendorfer wrote:
> However, to not have a lot of copies of the admin submodule
> in
> 
>  .git/submodule/admin
>  .git/submodule/kdelibs/.git/submodule/admin
>  .git/submodule/kdebase/.git/submodule/admin
>  .git/submodule/kdenetwork/.git/submodule/admin
> 
> the just suggested submodule.<name>.repopath to specify a repository
> outside of .git/submodule to be shared by kdelibs,kdebase,... would
> be fine.

This clearly shows that having the repositories of submodules in
.git/submodule does not buy you enough to avoid duplication.

(I don't see enough reason to place a repo for submodule X in project Y
outside its "natural" checked-out directory in project Y. But then, I
haven't followed the discussion. Please ignore me if above layout choice
is for more than just avoiding duplication.)

-- Hannes
