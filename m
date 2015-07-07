From: Junio C Hamano <gitster@pobox.com>
Subject: Re: No one understands diff3 "Temporary merge branch" conflict markers
Date: Tue, 07 Jul 2015 10:44:44 -0700
Message-ID: <xmqqzj373lrn.fsf@gitster.dls.corp.google.com>
References: <CAOMsSXQVJsd0h1fnNMEJ5+cKpxbeF9mHraXva-wr6Y2zBCADbg@mail.gmail.com>
	<vpqbnfondsr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edward Anderson <nilbus@nilbus.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 07 19:44:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCWvS-00081J-7b
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 19:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbbGGRot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 13:44:49 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35250 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbbGGRor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 13:44:47 -0400
Received: by iecuq6 with SMTP id uq6so139399417iec.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TQ7vLyJJp6FhJ47k1R5cjx+Wz0p0gbvExpBm56daKkQ=;
        b=ZG67FfI8tvCiiIRkvqm7+7zcDBBzC/5uoJvBALb5esTQt0wu0y4IP6PKjskPmRG0sn
         NeMerjEkermbUDQgcvV34n7jMjUzZ0BFwjAgx7/Xpb83PDc+s7Ct9vE7xtxJrJdKGzRR
         B7wYAS1tNtcZfj+gcadpZc/5T7U/aC/SsuA59e/4GdZGuotumMWg8PFWqs2D6AgmpwLy
         23dmO2i7ygHWgunASwX02RIGBT549d3kVRqlumJsgRz1HOJGDBKQzpNzfyhQj5Vz8WN7
         Bz3BLNUroRbC8rERBxTVoJ+jKm028Ze3xVRlZp3zmnkprvWs/w4zNM3d6lLBG89T2j2m
         2SIg==
X-Received: by 10.107.36.140 with SMTP id k134mr8524210iok.5.1436291087194;
        Tue, 07 Jul 2015 10:44:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id o2sm8388igr.9.2015.07.07.10.44.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 10:44:46 -0700 (PDT)
In-Reply-To: <vpqbnfondsr.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	07 Jul 2015 18:16:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273589>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> ... I would say: the
> recursive merge-base was computed internally, but not really meant to be
> shown to the user.

I wonder if the output becomes easier to read if we unconditionally
turned off diff3-style for inner merges.
