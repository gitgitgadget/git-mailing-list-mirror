From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Tue, 7 Jan 2014 20:25:33 +0100
Message-ID: <CALas-igZCvqybsw6honUTddnJYFkOYfieyfvW0yfT2oUVrPhVg@mail.gmail.com>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com> <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
 <20140106140627.GA27265@t2784.greatnet.de> <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
 <xmqqy52rd30b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:26:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cHm-0004O9-PA
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbaAGTZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:25:55 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:45808 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaAGTZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:25:53 -0500
Received: by mail-ob0-f179.google.com with SMTP id wm4so640607obc.38
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 11:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K4w0hLVcqARqA/KL0XOaULqe+DtE3tWUaeqIJJn7iTE=;
        b=U62dY3tp6LmQb6qDNuyxLE9EGDlCxNhVnaLznqZvqDyQSZBFiE3RLztDEPP3ZANaZN
         h69KG0XnykOX/v1ItdzMxNWZInfBJbkwDYUAUd7iaMK0J1RdGa8w7b+kYpVzeF9ltE+E
         m4qIOTw6rNtLfIauhIQ1HGRiVysGG69NRhbKngO666S8Qmm0wipper5yNXI6bR6jQxhY
         3XYrY8F2MBQ37LG3sqJlSfK4OCBJSbO0Ozuf5wNPidKyDRCd/sggzTC4iryYUiqFvaf2
         N17ZiDE5KuzB/fKktX4J9MhWS1+hKoHfait8bfGZhAuCG63vSrxs//ejn1FCKkViXAgD
         lt2g==
X-Received: by 10.182.16.33 with SMTP id c1mr78286980obd.4.1389122753332; Tue,
 07 Jan 2014 11:25:53 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 11:25:33 -0800 (PST)
In-Reply-To: <xmqqy52rd30b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240133>

2014/1/7 Junio C Hamano <gitster@pobox.com>:
> Francesco Pretto <ceztko@gmail.com> writes:
>
>> My bottom line:
>> - For what I understand, detached HEAD it's a way to say "hey, you
>> have to stay on this commit. Also don't even think you can push to the
>> upstream branch". This sometimes can't be spurious, as in the use case
>> I wrote above: access control on the remote repositories should be
>> enough. I think maintainers should have the option to make developers
>> to clone a repository starting with an attached HEAD on the branch
>> suggested in submodule.$name.branch;
>> - "git submodule update" is missing a property to do automatically
>> "--remote". I think in the use case I wrote it's really handy to have
>> a "git submodule update" to act like this.
>
> The short version I read in the message is that your workflow, in
> which partipants want to work on a branch, gets frustrating with the
> current system only because the default update/initial cloning
> detaches HEAD and will stay in that state until the user gets out of
> the detached state manually. Once that initial detachment is fixed,
> there is no more major issue, as update will stay on that branch.
>
> Am I reading you correctly?
>

Yep, you got it correctly.
