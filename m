From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: git submodule: update=!command
Date: Tue, 17 Mar 2015 16:59:49 -0400
Message-ID: <1426625989.1809668.241718517.07249CD6@webmail.messagingengine.com>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
 <xmqqy4mvmjs9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 22:00:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXyan-0003wr-JV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 22:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbbCQU7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 16:59:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56523 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750958AbbCQU7u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 16:59:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 10CAA20A77
	for <git@vger.kernel.org>; Tue, 17 Mar 2015 16:59:48 -0400 (EDT)
Received: from web1 ([10.202.2.211])
  by compute3.internal (MEProxy); Tue, 17 Mar 2015 16:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=desrt.ca; h=
	message-id:x-sasl-enc:from:to:cc:mime-version
	:content-transfer-encoding:content-type:subject:date:in-reply-to
	:references; s=mesmtp; bh=pLEnIFMgZBc9xIj9mAeh4xU1znY=; b=aj866m
	fcAPo1++2ErcWNST5hHpX4UK34NyCiMS4OB83xciojE0EIFoyWC+c6y9Q0WxshFD
	XJz5Gj92Ecb3v56L4frY4xPWpEsXCspm+W1I1vBD7xCqzIzVGgbanfYaGhiLmek0
	AyLxkbeJXYEA6TwVjiFGRoU/1DeXqEfsa1O60=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:x-sasl-enc:from:to:cc
	:mime-version:content-transfer-encoding:content-type:subject
	:date:in-reply-to:references; s=smtpout; bh=pLEnIFMgZBc9xIj9mAeh
	4xU1znY=; b=Cit/d535YZLiX6NIHyAQhuk+yhO2gV0N9fT51DqoskW1k5uWHfH5
	VzVELUZp58Xnn7yMAW1nu3FZmwCJWuViUWgRSJvVWvEF+lxrfIqQnhBysYd86+C5
	ryDbXMwLy4Ap6rqkghvSc6igNVkrjifAShGtR9RZQVoiqMomjnYc07U=
Received: by web1.nyi.internal (Postfix, from userid 99)
	id EEEC2AF354A; Tue, 17 Mar 2015 16:59:49 -0400 (EDT)
X-Sasl-Enc: W3aIUBHRGGLA6NMVhfOiHfsq9g/qLtTvZhFNB7+nkS+w 1426625989
X-Mailer: MessagingEngine.com Webmail Interface - ajax-15db86eb
In-Reply-To: <xmqqy4mvmjs9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265667>

On Tue, Mar 17, 2015, at 16:49, Junio C Hamano wrote:
> With more recent versions of Git, namely, the versions after
> 30a52c1d (Merge branch 'ms/submodule-update-config-doc' into maint,
> 2015-03-13), the documentation pages already have updated
> descriptions around this area.

sigh.

That's what I get for forgetting to type 'git pull' before writing a
patch.

Sorry for the noise!

Cheers
