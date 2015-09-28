From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Mon, 28 Sep 2015 11:47:08 -0700
Message-ID: <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 28 20:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgdSF-0000eV-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 20:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbbI1SrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 14:47:11 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34746 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbI1SrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 14:47:10 -0400
Received: by padhy16 with SMTP id hy16so181513084pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ieMDuomVuSVbvtF6dWbzton7Y/cOAi76rmYe9UCFyq4=;
        b=HsXmIrF69pigS3jtpLF19L7tGPznKNcJc3cTx8bybFr9jlPcuNvI5E21nNKjW2IYYY
         +MFxWu+LALggnTbC+NRbWbYzVPUfD/7bb6xXV6HGhFmS5t8+kiSR9YYdLQAdKjsTFO0P
         jrkhJCC/jcY/QxQYMTQ3woaKS6oOeqkrUw1eQKWdrxt3oZbz9QewB7wrjVkfnKJLWbqQ
         lt6d/IZv0o2SHRNWomiXQ0EQ3Mu+va9sucTkCW5KMcrm2fwhsGIcBXorMe2gL74/aJLL
         HGJHqllGGRa/yW9RRPEuD9lZeQhcKLGVGwsaMuMJ6y/4TpXsXZ3QTDpv5vaMPLnbFo6F
         wxTw==
X-Received: by 10.67.5.202 with SMTP id co10mr11940212pad.68.1443466030157;
        Mon, 28 Sep 2015 11:47:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id ja4sm20782989pbb.19.2015.09.28.11.47.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 11:47:09 -0700 (PDT)
In-Reply-To: <vpq4mie1m3n.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 28 Sep 2015 19:37:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278742>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> It probably makes sense to do the later in the case of Git, so that
> Junio doesn't get spammed when pushing topic branches to
> https://github.com/gitster/git.

I won't enable it on github.com:gitster/git anyway, so I do not
think that is a concern.  I thought what people are talking about
was to add it on github.com:git/git, but have I been misreading the
thread?  I do not even own the latter repository (I only can push
into it).
