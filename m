From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our Documentation/
Date: Fri, 09 Sep 2011 21:05:07 +0200
Message-ID: <4E6A6363.3060608@drmicha.warpmail.net>
References: <4E6A23DB.1040606@drmicha.warpmail.net> <7v4o0lvcq3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26O4-0007Q5-62
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759656Ab1IITFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:05:11 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56033 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759655Ab1IITFJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 15:05:09 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 231A42567E;
	Fri,  9 Sep 2011 15:05:09 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 09 Sep 2011 15:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=onO5+cyqTQX7zA6mA4+RlG
	zrLLY=; b=NaMedLsl5IHPBHLh4YKaQRv+CvRk7MQh1EnoZhS9vC2eToAntO2HRm
	cpqzXf9plMOxc6CL2yuo9IssTOCqUHzplL6CF8UVeNfPLZLbeiCMxLnl4itx93Ey
	pYdo1LThg8h1WZ2sEWYzq7saP+PnKyzzKIAkPGzfXWrxMLaj18fFE=
X-Sasl-enc: a3GMEEoE+XmOPqv1JAyKnO8e7neceiFhO3FSzSdz+Nb2 1315595108
Received: from localhost.localdomain (p548594B4.dip0.t-ipconnect.de [84.133.148.180])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 866F86C033B;
	Fri,  9 Sep 2011 15:05:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7v4o0lvcq3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181106>

Junio C Hamano venit, vidit, dixit 09.09.2011 19:37:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Our own customisation is not loaded (of course) so that, e.g., the
>> linkgit macro does not work; and the include statement makes GitHub's
>> parser unhappy and choke.
>>
>> Does anybody feel this is worth pursuing?
>>
>> + Nicer blob view
>> + Simpler way to judge documentation changes
>> - Need to get our asciidoc config in there
>> - GitHub's parser neeeds to learn include
> 
> Personally I am not very interested. Couldn't you just visit the html
> branch instead for viewing?

For viewing what you generated yes, of course. Though there's some
fiddling if you want to view a specific version. And even for the latest
version it is more direct to click on the file in the tree and see it
rendered.

But what I had in mind was being able to view anyone's branches like
that, to aid review of a patch which is on list and in a branch on
GitHub, say for restructuring layout or presentation of some man pages.
The linkgit and include issues are a bit of a showstopper (looks like
lots of digging in foreign code).

Michael
