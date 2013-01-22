From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: [PATCH v3 1/6] Change old system name 'GIT' to 'Git'
Date: Tue, 22 Jan 2013 08:45:07 -0800
Message-ID: <7va9s1b20c.fsf@alter.siamese.dyndns.org>
References: <7vfw1udpav.fsf@alter.siamese.dyndns.org>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1335904329.632749.1358795780375.JavaMail.ngmail@webmail20.arcor-online.net>
 <1543684041.1817103.1358847866882.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 17:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txgye-0003gd-GY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 17:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab3AVQpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 11:45:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730Ab3AVQpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 11:45:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0AEB5A0;
	Tue, 22 Jan 2013 11:45:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cz18l8DgAR41jDAcQFJ7ceeXaEk=; b=o3KKAB
	3Bi3vpf1BCIPjAFwkoBWb7vUoX8bi64O8vd+BVk2s5Gbr5u6OPSoylAhZEEjVTGt
	RLQl/d2IXWR3SuAYTxWvX206WDQ0DXNAhW94B6Mz14rZLtqW8kO+frZz5yd60/XK
	NvuhSr4pULUp3i1iYBGvrhd6147jJ77Ii8Hx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qeST73F6SmeDr4dik83lKGBaux5VPy0d
	H+W+Z3uiBKQwqpFoVX2t2mLdjXpBYL621OpXkaUCwl25ZpIkhYnMTONp25hjuHS4
	b4/plGg1Y+Xzbwcous9UYJv70YLp/MrzkOhE5jAOuf+nY2EPd8uWT+IqM5MxohbC
	fpvtEhtNuN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F363B59E;
	Tue, 22 Jan 2013 11:45:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAC71B59C; Tue, 22 Jan 2013
 11:45:08 -0500 (EST)
In-Reply-To: <1543684041.1817103.1358847866882.JavaMail.ngmail@webmail19.arcor-online.net>
 (Thomas Ackermann's message of "Tue, 22 Jan 2013 10:44:26 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15080ADC-64B3-11E2-96B7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214237>

Thomas Ackermann <th.acker@arcor.de> writes:

>>  * Documentation/git-credential.txt:
>>  TYPICAL USE OF GIT CREDENTIAL
>>
> This is to be debated because here all caps is used as "poor man's bold face"
> and it would look odd if we write 'TYPICAL USE OF Git CREDENTIAL'?

I left this as-is in my "fixup" commit, as the html and manpage
backends seem to typeset the section titles differently.  I however
have to wonder what the result will look like if we replaced it with

	Typical use of Git credential

Can you try and see how well it works?

> Perhaps it would be best to separate this into 2 series:
> [1/6]+[6/6] and [2/6]-[5/6]?

I'd really hate to see these patches posted again to the list and
asking for re-reviewing the whole thing.  Can we go incremental
while parking these original patches on 'pu', and later squash the
whole thing into two commits, or something?

Right now I have these on 'pu':

  b15ac19 Add rule for when to use 'git' and when to use 'Git'
  57d4b2c Change 'git' to 'Git' whenever the whole system is referred to #4
  01758e6 Change 'git' to 'Git' whenever the whole system is referred to #3
  59b26cb Change 'git' to 'Git' whenever the whole system is referred to #2
  e458530 Change 'git' to 'Git' whenever the whole system is referred to #1
  c8fc93a Documentation: update two leftover small caps
  170a796 Documentation: avoid poor-man's small caps

I will locally squash the top one (your #6) into the bottom one
(your #1).  Perhaps people can proofread the result of "Some
instances of 'git' should be 'Git' as they talk about the system"
patches, and send in incremental corrections to be applied on top.
