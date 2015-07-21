From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2b 00/16, 2 updates] Make the msvc-build scripts work again
Date: Tue, 21 Jul 2015 12:25:10 -0700
Message-ID: <xmqqvbdduxd5.fsf@gitster.dls.corp.google.com>
References: <1437432846-5796-1-git-send-email-philipoakley@iee.org>
	<xmqq1tg2xwbd.fsf@gitster.dls.corp.google.com>
	<73004CECB3514744A5916831B4501689@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdAM-0001Zb-B2
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933720AbbGUTZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:25:17 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34283 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933377AbbGUTZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:25:14 -0400
Received: by pdbbh15 with SMTP id bh15so79675894pdb.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vxX1P1ELkxQ5e1FK7FaXpwz6CiD6F6ZheMFW0lIZ6dw=;
        b=JM0YaumZ4ZXYAGQ+cpAunqgyFfFY0dBwmqWzEST5FJpxJfCPTqcTu28xDIjHFJbKwr
         yL/Gnu2w8cQxIbqqpnTsxV4++pa9nBd0GvKVozuZHyGy3QXvMewNCTwqtdK6FLepTPyz
         3QDkgiiqsh59YTKmomEi0t5IKhkcMlLWC/hUKoLiw+Sxp410fj1++jt7T08AnEBYIjZw
         pxjOmggBB5Dks9ecK1ZQRk2N3CGEHaPk88uc0eMrPjeec5vAN6Zv5/48KuqYnVHDx8qG
         kg+6clRIYAnvd62Nt71pRtppma2qWGLjJd40MYj8xvGOHWsdDfYiIgT1+Ee7Td2WI4/Z
         l2Wg==
X-Received: by 10.66.63.8 with SMTP id c8mr77971118pas.122.1437506713560;
        Tue, 21 Jul 2015 12:25:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id nl10sm28934549pdb.38.2015.07.21.12.25.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 12:25:12 -0700 (PDT)
In-Reply-To: <73004CECB3514744A5916831B4501689@PhilipOakley> (Philip Oakley's
	message of "Tue, 21 Jul 2015 17:46:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274398>

"Philip Oakley" <philipoakley@iee.org> writes:

> ... Ideally, if part of this
> mainstream Git, it would get picked up automatically by them
> (rather than being local 'fixes' endlessly carried forward).

Actually, that is not "ideal", but what I want to avoid.

As I do not do Windows, it simply is wrong for me to apply changes
that are very likely to affect Windows folks without seeing their
support first, which they may end up having to revert on their end
and endlessly carry that revert forward.  That is why I very much
prefer to see changes get there first and then forwarded in my
direction once they are happy with them.

> There has been no activity here on the 'create a visual studio project'
> aspects in the last few years. Any changes listed in the logs relate to
> ensuring that the MSVC compiler will run as part of a regular Makefile
> run (IIUC). The last significant commit was 74cf9bd (engine.pl: Fix a
> recent breakage of the buildsystem generator, 2010-01-22) Ramsay Jones,
> so that's five and a half years.

I think Ramsay is still around on the list; I do not know if he
still does Windows, though.
