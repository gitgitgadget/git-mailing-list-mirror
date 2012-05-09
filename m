From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Wed, 9 May 2012 15:10:28 +0200
Message-ID: <CAMP44s0DRrqMdHzOBTeQGmKtP7LzFerLZTaNgbHfj0XtebW9wA@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<vpqehqxmwpj.fsf@bauges.imag.fr>
	<CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
	<CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
	<7v1umv7ub0.fsf@alter.siamese.dyndns.org>
	<CACBZZX6u7rJer+tSqPddKdAF=bd216pZH5qUQNcrdr4nCmT46Q@mail.gmail.com>
	<7v62c71fl7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 15:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS6fC-0006a3-79
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 15:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759265Ab2EINKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 09:10:32 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45327 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab2EINKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 09:10:30 -0400
Received: by eeit10 with SMTP id t10so104909eei.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SlY/wudVWBhjJH17FwfhGApPA388tnZJMbTz7y+ZoFA=;
        b=xnalovGUWpsZWZC7BTpfth0j6BIAto/RMlNO7MxH/K8v3I6Z5UNL6X/PjWUEAsto0Y
         kXKFyeHfA+aaFXI3ECtPj2jeB78zkpQi+06TqhKdHw7h+nlmzP9mm9fPfX48bSpjwbIK
         erfUZHXo5KrlqyBZcMbcOimELy6zvcPPjNQtBqej10tBezkIJSooi4KdLG43IGUvV4tb
         GpMUvXczUpFr5p50A1xjnW8efB6Q4js/oV6Af14YsL9gvTvUTyp18FXV9kt9uzfM8tJj
         ljqg4HXLrExg57slXIwu0ofsOZRsoxAqC0Gmoed3kzJNXkL5wUVHBlixj//SI2VABsPU
         WreQ==
Received: by 10.14.187.4 with SMTP id x4mr25224eem.14.1336569029293; Wed, 09
 May 2012 06:10:29 -0700 (PDT)
Received: by 10.213.32.84 with HTTP; Wed, 9 May 2012 06:10:28 -0700 (PDT)
In-Reply-To: <7v62c71fl7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197471>

On Tue, May 8, 2012 at 6:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The word "index" is quite well understood: that which points at the
> information given a headword that refers to it, which is exactly what the
> "index" we have is. On the other hand, "to stage/staging area" is not as
> widely used outside the narrow shipping/logistics circles.

That's what git has, *internally*, but that's not how high-level users
interact with it. If 'git add file' was a true index from the point of
view of the user; then the user would have some kind of identifier,
like '1', or possibly and identifier of his own. Then the user could
use this identifier, say; give me the file '1', and the operation
would be much faster. But that's has *absolutely* nothing to do with
how users see these operations. The user does not see an index at all.
Maybe git has an index, but it could be replaced by something else,
and the user would still see the same; it's an implementation detail;
not something the user cares about.

This has been explained and discussed many times.

Cheers.

-- 
Felipe Contreras
