From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: How to pre-empt git pull merge error?
Date: Wed, 27 Nov 2013 17:38:46 +0100
Message-ID: <CALWbr2wNODeLSmQ5ztQmKVxBSguNJ1bbSbvY66sdsP09dSUUgA@mail.gmail.com>
References: <86d2llc1rs.fsf@gmail.com>
	<20131127194240.2abaff5575961b3d73e1970f@domain007.com>
	<vpq8uw9q1r4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Pete Forman <petef4+usenet@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Nov 27 17:38:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vli8b-0000rX-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 17:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363Ab3K0Qis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 11:38:48 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:65347 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320Ab3K0Qir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 11:38:47 -0500
Received: by mail-lb0-f176.google.com with SMTP id x18so5432447lbi.7
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 08:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WhoOhHeLdcxWd6JjltGXhABAiS9C0iWB2wW0wlLCNsY=;
        b=SzXfsaVvfwKsqMGd7XzTZP9hFaK+x54h8t/Vj0QYE96JSgDtD2Bs5usivM0x5OK7Q1
         1+nE8/MraGwIyZoXRmYFGsOP4IXvfEXWwKFenOdULm4s/56MAlwMwhpdLxRuKA3oAz6B
         KXNbudGnaESMatW8x/+I26qsJNGzKEZ5V03WhXVzktUynrBmukAep+EcGsU+TtfBf6Rr
         lMq2i6hTDVXldefrD4tS34BB1qUm5hS9V6Fz3cZBXcg6KaNZye3rLVpUCemR1BgxWaFo
         /b5bSfwfE9umi01lXtFgZcyGbquPbhOZ2TqaxWYjTVy0fLnHip1sZVXbex4m6kunPKNd
         2Wdg==
X-Received: by 10.112.205.164 with SMTP id lh4mr28575299lbc.15.1385570326135;
 Wed, 27 Nov 2013 08:38:46 -0800 (PST)
Received: by 10.112.134.135 with HTTP; Wed, 27 Nov 2013 08:38:46 -0800 (PST)
In-Reply-To: <vpq8uw9q1r4.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238448>

>> On Wed, 27 Nov 2013 15:17:27 +0000
>> Pete Forman <petef4+usenet@gmail.com> wrote:
>>
>>> I am looking for a way of detecting up front whether a git pull or git
>>> merge would fail. The sort of script I want to perform is to update a
>>> server.
>>>
>>>     git fetch
>>>     git okay
>>>     stop server
>>>     backup data
>>>     git merge
>>>     start server
>>>
> I don't know a simple way to do the pre-merge check without actually
> doing the merge (other than patching git merge to add a --dry-run
> option)

Wouldn't that be a nice use-case for git-recursive-merge --index-only
($gmane/236753) ?
