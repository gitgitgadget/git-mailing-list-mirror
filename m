From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: git submodule: update=!command
Date: Tue, 17 Mar 2015 17:11:41 -0400
Message-ID: <1426626701.1812977.241723449.1C0F64BD@webmail.messagingengine.com>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
 <xmqqy4mvmjs9.fsf@gitster.dls.corp.google.com>
 <1426625989.1809668.241718517.07249CD6@webmail.messagingengine.com>
 <xmqqtwxjmj21.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 22:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXymC-0002Hc-5j
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 22:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbbCQVLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 17:11:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44166 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752392AbbCQVLl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 17:11:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 522F9207CC
	for <git@vger.kernel.org>; Tue, 17 Mar 2015 17:11:39 -0400 (EDT)
Received: from web1 ([10.202.2.211])
  by compute5.internal (MEProxy); Tue, 17 Mar 2015 17:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=desrt.ca; h=
	message-id:x-sasl-enc:from:to:cc:mime-version
	:content-transfer-encoding:content-type:in-reply-to:references
	:subject:date; s=mesmtp; bh=hmJ6GmDshql3Sx5nbFQkeBorAe8=; b=bvzD
	sv/o1x++vFzHrLPcEi+4RRuAhE7cf3WJLLYrJcoZV/x+s8TAbddexQuDwpH0bJGE
	YZR5uoA4hYuUNd77ShlUNDLmvBVsQ0NbXQ07RxMH760KMO/KG53CrrTkF9AlrLLS
	z3TUQQS6XWVKAF4HH4Bmnh5DxbXBZtgjFOpOrFo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:x-sasl-enc:from:to:cc
	:mime-version:content-transfer-encoding:content-type:in-reply-to
	:references:subject:date; s=smtpout; bh=hmJ6GmDshql3Sx5nbFQkeBor
	Ae8=; b=XpLUOa0JdQMj3nfYCMrDeMmQA2VNHenVEoOeY9xYJFUUQDUzwPXbnkZQ
	/UcpEG3BKf+cTgoX2YahJd6IVjFlJ4cgpJeJUq6BKGqeIIATA0aqPn3TBHuXG9mP
	Vf9xRVUeJX7QvTX/QIjZbbMk4DtzrS2KyRgI8J93SxiaRF3PzSg=
Received: by web1.nyi.internal (Postfix, from userid 99)
	id 3930BAF35A2; Tue, 17 Mar 2015 17:11:41 -0400 (EDT)
X-Sasl-Enc: bhgfwT9BBGYRl+xDgBVh93f9A+HJ9y3FcfF2T4HrtWAG 1426626701
X-Mailer: MessagingEngine.com Webmail Interface - ajax-15db86eb
In-Reply-To: <xmqqtwxjmj21.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265669>

kara,

On Tue, Mar 17, 2015, at 17:05, Junio C Hamano wrote:
> If you check the output from
> 
>     git diff 30a52c1d^ 30a52c1d
> 
> and find it appropriately address the problem you originally had,
> that would be wonderful, and if you can suggest further improvement,
> that is equally good.

Indeed, the new version of the docs looks much better.  I'm particularly
happy about the change to the format to make it easier to visually scan
for the possible update modes.

Cheers
