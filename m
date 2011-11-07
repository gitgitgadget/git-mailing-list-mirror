From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: ignore apple filetype
Date: Sun, 06 Nov 2011 20:33:40 -0800
Message-ID: <7vobwo4km3.fsf@alter.siamese.dyndns.org>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
 <20111101020841.GA8116@arf.padd.com>
 <CAOk9v+_xXRGAGWg2L5u=r9qBS=H+ZmdF=TwumSyq7WKf-15okw@mail.gmail.com>
 <loom.20111102T153631-769@post.gmane.org>
 <CAOk9v+_xaS_Y1m17TROOSjgiscT+QEJWbpZbAZFmh8_tAviF6Q@mail.gmail.com>
 <CAOpHH-W1JO9PLsyp2hQxfr6eyKRr+=pMkaDikV5NcFwF98Miow@mail.gmail.com>
 <20111104183957.GB18517@padd.com> <20111105173607.GA12532@arf.padd.com>
 <CAOk9v+9xbq0zBF=96GXeK4L-Z9PrGB_NO5h06u63PweRgFFB2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, Git Mailing List <git@vger.kernel.org>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 05:33:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNGu6-0005jx-Rw
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 05:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab1KGEdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 23:33:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab1KGEdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 23:33:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C8E16859;
	Sun,  6 Nov 2011 23:33:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IoAffnA/aSS9dP0sDXvFtehjJdE=; b=maoYKZ
	+qXzrf4syNyXwJF/hVEflePi4krd/0tGvlIFX3X5WgnwfhjmWHiZBDrQFOdUSzV3
	io7br0u9P3ApyolCkIuYthEcYoAM9v/sF93qb28yZv/rx34+qmUVbxKDSx9sx+uL
	9EJMHI6p2OMp4a0gnGhV40EkCswYYNRm61et8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P4BrPRyTx0oskxbvcmAIIfpO7+4b2m2z
	RFqqPV2jLPv6rKeDfpglyu49O60vNtEQTbnwJ417oz069BTV4H+Wjfnmw5i27otx
	WUVEVOF9b7C6ZVo1eor6ddHK6/PcmO+pRMgskQ4VIPi0tZBgiU5jWQigGVXpgG6q
	NR7dZqf1AVw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 720346858;
	Sun,  6 Nov 2011 23:33:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 019FF6857; Sun,  6 Nov 2011
 23:33:42 -0500 (EST)
In-Reply-To: <CAOk9v+9xbq0zBF=96GXeK4L-Z9PrGB_NO5h06u63PweRgFFB2g@mail.gmail.com> (Michael
 Wookey's message of "Mon, 7 Nov 2011 13:21:33 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC67B11E-08F9-11E1-860F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184946>

Thanks, both. Will include the patch in 1.7.8-rc1.
