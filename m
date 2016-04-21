From: Stefan Beller <sbeller@google.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Thu, 21 Apr 2016 10:48:25 -0700
Message-ID: <CAGZ79kYTo+CHPvhV6i0U3xqezhGBSXQs9h+5JL6MRh9oAWXvFg@mail.gmail.com>
References: <20160420152209.GH23764@onerussian.com>
	<CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
	<xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
	<xmqqshygt1gs.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbyDuu8hUQXOUNmDLyO88GOi3kqSzsc0UfgzwAL9peZHg@mail.gmail.com>
	<20160421031426.GY23764@onerussian.com>
	<CAGZ79kYmobvZgAeJv7MNXeFXd+Ahg5mtyagt5m+f7Gpp=Ps4iQ@mail.gmail.com>
	<xmqqr3dysvne.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:48:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atIiN-0000sC-K4
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbcDURs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:48:27 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38460 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbcDURs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:48:26 -0400
Received: by mail-ig0-f173.google.com with SMTP id m9so72465132ige.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BrdE8PuJSjVxb24vBtRbFl2tKH9Hy5nsu+tlB52++e8=;
        b=B0zPEMYiptIgDr3laZPvzuRnVKfHWH0qNkfXX9moKCP6b8lWCSfsRy++JkLrqUo1+B
         tG4SyMjyccO8+cOJxLjoElL9gyinTk8TYV7kg66imazKLCk7nbQU1HebF8A2Ah18/QhL
         p6z6qeI2YHoHTETF2hnORUyJD8+UnLXSuG0Av67JNRunq1H3dKGIIsu8KlWuZWHSLIWl
         bDnbdza1g6WV66tu4210+7xOjYzN7EqcDbxXuVdkoMn/lmGX+Vt/dNJd7A1FBQcPnGQL
         +5AHsOw77jHGR8RA3MII6lSHKILuw8QYkrnmt6l2R9vYrs0tP0ywR3Z1aBYflB5jiRQc
         S0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BrdE8PuJSjVxb24vBtRbFl2tKH9Hy5nsu+tlB52++e8=;
        b=X7C3x6I7csl/PzD7N+6AmZmzMzaJI8ItkoFHSvjw974URfHWD4NNsvexCnYolq8FO9
         lnGHZJACpwlhDnVQ6JMnn09BOl92VVX887iQS879lIGFcZ0GOimPArdIFdZwQV8byeGr
         hm+n1LoZxZpRWs61oy/ni19OKg5kY6AVn8xHbMaRcrzeoTM4fgw41EBftk6y9HZnGs2V
         kRGWfMF6xR6P1jO7UoUO4GoDHUzCJ4YY4Jl+l+dhWNiaamWQSUeUehu4+HrvyZTlTWfD
         5fFcqdzWcWT9j2CcJRZn+YJD8c3B8MY4vUOzmsWMiWIEykj65qGrhNrKDg1nOnJtXWbu
         Ygog==
X-Gm-Message-State: AOPr4FW9E/4MMCM9bLyPuRESncnzdvyPctg6GjKLLEV6zODrQ/fwgBQK0pP/G/5rfrgCHWL4UStA0B7vpAVJAvfh
X-Received: by 10.50.111.15 with SMTP id ie15mr5567499igb.94.1461260905371;
 Thu, 21 Apr 2016 10:48:25 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 21 Apr 2016 10:48:25 -0700 (PDT)
In-Reply-To: <xmqqr3dysvne.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292136>

On Thu, Apr 21, 2016 at 10:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In case of non bare:
>>
>>     Get the repo and all its submodules from the specified remote.
>>     (As the submodule is right there, that's the best guess to get it from,
>>     no need to get it from somewhere else. The submodule at the remote
>>     is the closest match you can get for replicating the superproject with
>>     its submodules.)
>>
>> This way is heavy underutilized as it wasn't exercised as often I would
>> guess,
>
> My guess is somewhat different. It is not used because the right
> semantics for such a use case hasn't been defined yet (in other
> words, what you suggested is _wrong_ as is).  You need to remember
> that a particular clone may not be interested in all submodules, and
> it is far from "the closest match".

Yes, when that clone doesn't have some submodules, we can still fall back
on the .gitmodules file.

If you have a submodule chances are, you are interested in it and modified it.
So the highest chance to get your changes is from your remote, no?
