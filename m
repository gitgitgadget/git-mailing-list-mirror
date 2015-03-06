From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git merge driver / attributes bug in 2.3.1?
Date: Fri, 06 Mar 2015 15:12:16 +0100
Message-ID: <54F9B5C0.9050604@drmicha.warpmail.net>
References: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local> <54F98EBE.8080903@drmicha.warpmail.net> <D8780C527EB1E642B3150E6D705B46D448E8058B@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 15:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTszK-0004Lh-Az
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 15:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbbCFOMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 09:12:19 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39254 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914AbbCFOMS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 09:12:18 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C1ADE207D3
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 09:12:16 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 06 Mar 2015 09:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=927J23OYG0ELgtHGvVSTXw
	uClYA=; b=i0cqG2ipo2FOGb+datmf5D0UJtrBWcS9WF5CuoBtm29MBXoyrxZSa2
	8QNL7NYGwGeX11BWz7qcVVm4JZherL6ESCPJ/vJsquLx/WkMNWhGubZfcoI8jZT0
	/e47JurMAYuXXWlddA+d6oa6sxOKiDziFYidGFfRI3Eu4H95rHkjc=
X-Sasl-enc: oQtNKI3SnPRUCooSmxiAwp67SUnKDpe1ko2qY1/MjiVe 1425651137
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5C789C0028C;
	Fri,  6 Mar 2015 09:12:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <D8780C527EB1E642B3150E6D705B46D448E8058B@DWPWHMS531.dwpbank.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264925>

Gondek, Andreas venit, vidit, dixit 06.03.2015 14:31:
> The archive contains my test repository, the merge driver and the .gitconfig of the user. We don't have a global .gitconfig.

Thanks for the test repo!

Alas, the merge driver gets executed with v1.9.0-rc3, v1.8.5 and v1.7.0,
at least over here - as it should be because of the conflict: two
patches changing the same file. That conflict can be resolved
automatically by the internal driver, of course. Maybe something else
changed during the upgrade?

Michael
