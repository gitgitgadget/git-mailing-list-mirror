From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: Aw: Re: Re: Re: [Bug report] 'git status' always says "Your branch is up-to-date with 'origin/master'"
Date: Tue, 14 Jan 2014 15:34:31 -0800
Message-ID: <87lhyi6su0.fsf@gmail.com>
References: <20140106154552.GA22189@google.com>
	<CAGyf7-FX1sPjwvKdxeEXopffFPiftgDRqoe7NRWyM1Cm=5n6Sw@mail.gmail.com>
	<1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
	<1283978462.720554.1388999328222.JavaMail.ngmail@webmail15.arcor-online.net>
	<1067660482.1596252.1389024023072.JavaMail.ngmail@webmail11.arcor-online.net>
	<xmqqlhytjapb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Ackermann <th.acker@arcor.de>, jrnieder@gmail.com,
	bturner@atlassian.com, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 00:34:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3DVI-0007ox-UI
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 00:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbaANXei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 18:34:38 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:56393 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaANXeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 18:34:36 -0500
Received: by mail-qa0-f47.google.com with SMTP id j5so296204qaq.20
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 15:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:newsgroups:to:cc:subject:references:date:message-id:user-agent
         :cancel-lock:in-reply-to:mime-version:content-type:posted-to;
        bh=GzSolDFztugOmcJof4dqA0pVOKlYVIg3DO+NomOnV5I=;
        b=X2jTtg4/bQ9OY1dVVo5TouTQp9vOQABmKUMmwlvtU4IczEsXuADvSZjiUUnBILcm2O
         0l5v9/k+KYEn9jcZo3aOnhKqc8bUPSrbMXh0D4Js/EpnInL1YZhbNc3CgONzzFn4GLdX
         o9UAAfVQ/hed5VpPKDXS+UWLaSLofbcQdq1snUQawJBBwP2kEpuFiuTqdp0dCKlOLpQt
         p06CXnW6Ryzf+eEU4OxyZTDLJs9Qv/+y82kc2oI2RRhEHt+DLkLG9CGxS/hQ/5ZW3Jel
         JRO84P5j7APBIOnvRxjNZr/nHJ6Vo3OrMtqAjBtA7I0HhWPyCcze34A7r5U7jeoHk7Q+
         tt5A==
X-Received: by 10.229.171.132 with SMTP id h4mr7925509qcz.21.1389742475645;
        Tue, 14 Jan 2014 15:34:35 -0800 (PST)
Received: from localhost ([12.217.66.3])
        by mx.google.com with ESMTPSA id e11sm3596900qej.1.2014.01.14.15.34.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2014 15:34:34 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:pEavtbq4JG+kaKn0DO3hAg4wWrI=
In-Reply-To: <xmqqlhytjapb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 06 Jan 2014 09:12:48 -0800")
Posted-To: gmane.comp.version-control.git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240423>

The following message is a courtesy copy of an article
that has been posted to gmane.comp.version-control.git as well.

Junio C Hamano <gitster@pobox.com> writes:
> Thomas Ackermann <th.acker@arcor.de> writes:
>>> > But for the simple use case where you only have a master
>>> > branch I consider it not really helpful and - at least for me -
>>> > misleading.
>>> 
>>> I see what you mean, and you're not the only one.
>>> 
>>> Git follows a rule of "never contact another machine unless explicitly
>>> asked to using a command such as 'git pull' or 'git fetch'".  To
>>> support this, it makes a distinction between (1) the remote-tracking
>>> ref origin/master and (2) the actual branch "master" in the remote
>>> repository.  The former is what is updated by 'git fetch', and the
>>> latter is something git does not know about without talking to the
>>> remote server.
>>> 
>>> What documentation did you use when first starting to learn git?
>>> Perhaps it can be fixed to emphasize the distinction between (1) and
>>> (2) earlier.
>>
>> I think it's not the problem of the documentation but of myself
>> not having it read thorough enough ;-)
>>
>> (This new feature in V1.8.5 of course is not documented in any of the books
>> up to now but in the future could be used to explain the above mentioned
>> rule.)
>
> By the way, this is nothing new in 1.8.5; we didn't bother saying
> up-to-date before, so you may not have noticed, but its silence was
> already telling you that your branch was up-to-date with respect to
> what you are building on top of.

Maybe it would be worthwhile to add a message like "(last fetched from
upstream branch at [date])", taken from
$GIT_DIR/logs/refs/remotes/foo/bar ?  This would mitigate the confusion
Thomas suffered, I think.

Caveat: pretty ill-defined, since 1) if you've been pushing and not
fetching, the most recent time at which it is known that your
remote-tracking branch was up to date could be much newer than when it
was technically "last fetched"; 2) the upstream branch might not
even be a remote-tracking branch; 3) probably something else I haven't
thought of.

-Keshav
