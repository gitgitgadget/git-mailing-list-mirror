From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] send-email: Don't leak To: headers between patches
Date: Mon, 04 Oct 2010 11:55:43 -0700
Message-ID: <1286218543.10512.57.camel@Joe-Laptop>
References: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
	 <1286175924-15761-1-git-send-email-bebarino@gmail.com>
	 <AANLkTimuP8Myj-PAU76hjtWdOkbzg2WrZwaFNOxRqfsM@mail.gmail.com>
	 <AANLkTinnd-ZTqfKvEaDQ6o-gR2oAmvEChSpDps5T0Xsu@mail.gmail.com>
	 <7vpqvq8k1i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:55:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qCX-0006XY-K2
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214Ab0JDSzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:55:46 -0400
Received: from mail.perches.com ([173.55.12.10]:2624 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204Ab0JDSzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:55:45 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 7EBE624368;
	Mon,  4 Oct 2010 11:55:32 -0700 (PDT)
In-Reply-To: <7vpqvq8k1i.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158090>

On Mon, 2010-10-04 at 01:00 -0700, Junio C Hamano wrote:
> I would prefer to keep @initial_to and @initial_cc as "these apply
> globally to the whole command invocation", copied to separate @to and @cc
> that are primed by the former and tweaked per message.

Makes sense to me, thanks.

Is there a need to add initial_to and
initial_cc to the test suite for a patch
series?  I believe the test suite is
currently setup for single patch testing.
