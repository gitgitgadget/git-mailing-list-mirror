From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Problems Importing a CVS tree into FAUmachine
Date: Mon, 25 Jul 2005 11:03:13 +0200
Message-ID: <20050725090313.GB25825@cip.informatik.uni-erlangen.de>
References: <20050724205601.GD2117@cip.informatik.uni-erlangen.de> <20050725085756.GA25825@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 25 11:08:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwywZ-0002Re-NT
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 11:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVGYJHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 05:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVGYJHx
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 05:07:53 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:35318 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261156AbVGYJHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 05:07:33 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.11/8.12.11) with ESMTP id j6P93Ex0027631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jul 2005 09:03:14 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.11/8.12.11) id j6P93E25027630;
	Mon, 25 Jul 2005 11:03:14 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>, GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050725085756.GA25825@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> > 	git-cvsimport-script -d /var/lib/cvsd/cvsroots -C /var/lib/cvsd/gitroots/FAUmachine FAUmachine
> > 	<Output of rlog and 'treated as before'>
> > 	Committing initial tree e30105bb454c40a143689b37c11340f1a8f084b4

> > 	Unknown: error

> I isolated the error to the following:

> <lib/pattern-matcher/input/Pic0.ppm> <1.1>

> It tries to retrieve version 1.1 of lib/pattern-matcher/input/Pic0.ppm. However
> I can't find a single reference to Pic0.ppm:

> 	(faui02new) [/var/lib/cvsd/cvsroots] grep -rli Pic0.ppm FAUmachine
> 	(faui02new) [/var/lib/cvsd/cvsroots] find . | grep Pic0.ppm
> 	(faui02new) [/var/lib/cvsd/cvsroots]

	---------------------
	PatchSet 10688
	Date: 2005/04/28 17:34:58
	Author: sistsigw
	Branch: HEAD
	Tag: (none)
	Log:
	added some screenshots for development / testing purposes

	Members:
		lib/pattern-matcher/input/Pic0.ppm:INITIAL->1.1
		lib/pattern-matcher/input/Pic1.ppm:INITIAL->1.1
		lib/pattern-matcher/input/Pic2.ppm:INITIAL->1.1
		lib/pattern-matcher/input/Pic3.ppm:INITIAL->1.1

But I see the PatchSet if I run cvsps manually. Very strange.

	Thomas
