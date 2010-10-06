From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: cvs importing a forked project
Date: Wed, 6 Oct 2010 16:34:11 +0000
Message-ID: <AANLkTiksZTtBGAp0KvsPTjUHqh+ogQbQDZacJ4a661ZV@mail.gmail.com>
References: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
	<Ci4laGuWQaUrmZdwH9nojZ77bfNScQVKlCGXCSR6hP816oyKCfkncQ@cipher.nrlssc.navy.mil>
	<AANLkTi=DRWeJc5gW0Rio9NZh5a02FQtdd9TeEzOkBimr@mail.gmail.com>
	<AANLkTimnvAXAiE=03E3VdXSeP3pQBa8UTH548vEWsYsG@mail.gmail.com>
	<AANLkTimawPYmqoH_tupOc6zsgSeTU=dqgXA9pB95m542@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 18:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Wwa-00010E-LJ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 18:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759369Ab0JFQeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 12:34:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48942 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab0JFQeN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 12:34:13 -0400
Received: by yxp4 with SMTP id 4so2524119yxp.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=LtPmKXgX6VJgQYttiEXbrtivAdYKbUEDSjJTNtNzIVc=;
        b=kLXarNgdzjYGAsxYe3H69F4ZiqDWWOk6lXETTi3a/EmtVTRXuAOiwQf7pIyRD5L41Q
         5u90ZQpWZ/uOoRFY4/MMLECpjblLnoEFL1wCHxtEGHxAPQa2l8F19Me+/R7PjVk8Ocjs
         QkGDW1oOS9XXT+LFR9UnZUGovC2xz7sPy6WCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BSVo/mO/ojFypxgqhIUDRuTPuGMx/7jPE8QiHtJi6qXVPrt4AfcBUZz0yCr9WnZOEG
         2MLNNjn9RoiVU/pfIwl2Pcf8VjG1Id4IvamPAwrsjioNerlIsvRxv1r3gBjJNWE2nrKg
         v6ZKVof3QjNYiwO+cAq4y8FpWqlL/sCggLRbk=
Received: by 10.42.8.133 with SMTP id i5mr15696993ici.80.1286382852087; Wed,
 06 Oct 2010 09:34:12 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 6 Oct 2010 09:34:11 -0700 (PDT)
In-Reply-To: <AANLkTimawPYmqoH_tupOc6zsgSeTU=dqgXA9pB95m542@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158296>

On Wed, Oct 6, 2010 at 14:51, Eric Frederich <eric.frederich@gmail.com> wrote:
> I wanted to try to "switch to a new parentless branch" but don't know how.
> How can I create / switch to a new empty parentless branch?

    git checkout --orphan parentless-branch-name-here
