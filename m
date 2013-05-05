From: Jed Brown <jed@59A2.org>
Subject: Re: git describe not showing "nearest" tag
Date: Sun, 05 May 2013 04:50:19 -0500
Message-ID: <87y5btah7o.fsf@mcs.anl.gov>
References: <877gjeav64.fsf@mcs.anl.gov> <7vmwsaudv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 05 11:50:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYvaO-00075K-45
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 11:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab3EEJuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 05:50:24 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:65382 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3EEJuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 05:50:23 -0400
Received: by mail-gh0-f180.google.com with SMTP id f18so546598ghb.11
        for <git@vger.kernel.org>; Sun, 05 May 2013 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=iOBkQHhF7kPykmEJ0tr0PwNa7w5kFF+eF0MrQ72rK5g=;
        b=rvcWAQhnAaiDK9V71ae5UFVC0SsQfY68ChW3wejtOhbsVtnpmkQXk7jzrQABpGdypf
         cqJyf1T8aIL2Rk68bZXqhAQhNZKSzey4TfQ5gDOIUAtrb0NGtP7l8ng05/FRDq4QXKRb
         0cMCSNjLyHs1tOqaJ+dYH0GyqgFCPoHMnl3lOyYES6V6iO+BFR1YSR21y1L9XBp/iWbl
         H0st/luLame6jLqy38OluJVfNk2ZwWKRuay9aEyHrhySpikOG3lujqDseqcWj2bgPvgK
         6/gL8MOd5THst5eodcWUYis8gzjht36SgW1gZDmNGpLWjnXwBhLbeitO1xo76MZj2YJ6
         CLtQ==
X-Received: by 10.236.126.179 with SMTP id b39mr14882491yhi.94.1367747422420;
        Sun, 05 May 2013 02:50:22 -0700 (PDT)
Received: from localhost ([38.69.41.96])
        by mx.google.com with ESMTPSA id j47sm37480254yhm.21.2013.05.05.02.50.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 05 May 2013 02:50:21 -0700 (PDT)
In-Reply-To: <7vmwsaudv9.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.15.2+84~gfa8aadf (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223396>

Junio C Hamano <gitster@pobox.com> writes:

> Is 'master' a descendant of v3.3?  I.e. what does
>
> 	git rev-list master..v3.3
>
> say?

Yes, this shows nothing.  Although 'master' is a descendant of v3.3, it
is not a --first-parent descendant of anything after v3.0.0.
