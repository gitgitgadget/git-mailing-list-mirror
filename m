From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 13:35:39 -0400
Message-ID: <CAD0k6qQhER7cDsSG21CnnMxZE+B1BbQh1AkcAgiS3Jpm6WEMcQ@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
 <xmqqegkl2qu2.fsf@gitster.dls.corp.google.com> <CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
 <xmqq615x2ph1.fsf@gitster.dls.corp.google.com> <CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
 <xmqqwpyd19dy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAJL-0001wj-SA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbbGFRgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:36:04 -0400
Received: from mail-vn0-f44.google.com ([209.85.216.44]:34020 "EHLO
	mail-vn0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbbGFRf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:35:59 -0400
Received: by vnbf7 with SMTP id f7so17817034vnb.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OLRwFd4ildzYaV1RDODaooZl8JbjdjXux6H+EtTr2hE=;
        b=aWcB94HI7N8Qf9wBLTp3MZS0d2w4/VAz4PKKJFYXLU/0xv9EEE7jWMngkP9t4/K709
         vKuJiHUXZECFhGNXRCoYIEaTUbXN85p6LxIklrTJa4IyT5P293DgAMZk8bUA6EqtZP3w
         /ROngSIjM2tB9jofsnLh2Lzz7oMdZvJ73205MvdyOAQ2QDQMP1c4TahLwxtekXTlYNh6
         Qv9anOP0ABfAjcdfqoApG2WDoI3TnnLc4tmVWAfnrYRsoTCSlC6F4mi3jKgF0JoWiSFx
         GQ8J7zqYiPGDk0/0ntzi492NwwXuXSHwEIBixsU2MJAH4cH6dApn5fwalUQYWcP/WUNA
         Lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OLRwFd4ildzYaV1RDODaooZl8JbjdjXux6H+EtTr2hE=;
        b=MlOrGALNyJ+psp/he30rgH0vklju9aoFMzJqkj7Tc+jwC6TB+uzygFyWCV6MrquVaB
         VCJ5vl7cmsToUFRhLhxD5kCKJ/rF/0UlK80j5fI9XxsWSIqAUNoIpZOpQjCewaffhqI2
         oqzEMU9Lu032tvfny1epa551aMc35NXAzziUqKTvT1D8CeaQvBzZW7OXaq+gRsaKtG9r
         7oN9wVu2SaQ7qMBpGvscFA3vfjOHL7CGdlCwdnktc7AJeuP4nrYRd04QrQH4vRGQJLxh
         UcJulhLVVGB9tWk/+9Fwb58kqYOJPR3qqizrzKCBGDDcpcQjF2gDo7b63kOZmsp58H33
         N5Hg==
X-Gm-Message-State: ALoCoQmX4TpoQk7jS0taXRR2AVeseGxna3UPTCAN6K+g1GXLkBXlpAzMLYQY9sQL+t4Q2pO0uOtd
X-Received: by 10.52.2.193 with SMTP id 1mr39082vdw.44.1436204158669; Mon, 06
 Jul 2015 10:35:58 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 10:35:39 -0700 (PDT)
In-Reply-To: <xmqqwpyd19dy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273438>

On Mon, Jul 6, 2015 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> I think I understand the confusion now. I think you and I are working
>> from different assumptions about the client behavior.
>
> I agree that we now both understand where we come from ;-)
>
> And sorry for not being clear when I did the "push-cert" originally
> in the documentation.  As I already said, "packets between push-cert
> and push-cert-end are contents of individual lines of the GPG signed
> push certificate"

This sentence makes sense to me now, but only because we now agree
that "contents" does not include the LF. Different people may have
different initial assumptions about whether the "contents" of a line
includes the trailing newline or not.

> was the design meant from day one, and a85b377d
> (push: the beginning of "git push --signed", 2014-09-12) could have
> made it clearer.
>
>> The problem with the documentation, then, is that the documentation
>> does not say anything to indicate that the signed payload is anything
>> other than what is on the wire.
>
> Yeah, that was untold assumption, as I considered "what is on the
> wire" to include pkt-line framing when I wrote a85b377d (push: the
> beginning of "git push --signed", 2014-09-12).
>
>> So maybe this series should include an explicit description of the
>> singed payload outside of the context of a push. Then, in the push
>> section, we can describe the set of transformations that the client
>> MUST perform (splitting on LF; adding pkt-line headers) and MAY
>> perform (adding LFs).
>
> Yes, and the latter is not limited to push-cert but anything sent on
> pkt-line.
>
> That incidentally is the only point I deeply care about.  I just
> want to minimize "the protocol is this way in general, but only for
> this one you must do it differently".

Understood, and I'm glad we have finally come to an arrangement that
is both consistent and easy to implement on the server side.

> One example of "only for this one you must do it differently" is
> another caveat for protocol implementors for the sending side (again
> not limited to "push cert").
>
> That existing implementations of the receivers treat an empty packet
> (i.e. "0004")

or "0005\n" ;)

> as if it is the same as a flush packet (i.e. "0000"),
> so even if the sending side chooses to ignore the "SHOULD terminate
> each non-flush line using LF", it is strongly advised not to do so
> when it wants to send an empty payload.  This needs to be documented.
>
> The receiving end SHOULD NOT treat "0004" the same way as "0000".
> I think that must be documented and implementations (including our
> own) should be fixed.

Agreed.

> Thanks.
