Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783831FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 09:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934286AbdAKJoD (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 04:44:03 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35429 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934256AbdAKJoA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 04:44:00 -0500
Received: by mail-wj0-f193.google.com with SMTP id ey1so10951780wjd.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 01:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N8xcBDfU1RI/DnVW+OJJAFaV1us0etFnXPojQuh0XpY=;
        b=RlBp0bO8QhsSnHhd6yuHhC6UMAUvqdTbfD6QhB3Ev3bOQ9HhGCU/dfSWGKUXNLB9eq
         p+S9rZ7zM+MMmn6No856vi8PhsQNXXHAlP3Gmi8qKOPCEgttrJAMeO2Up5RW7q5EG/HQ
         3oPAC2osNeAdclJaPcjWF7b2J6D8JRvJFD4fug6LDfVO3R4LlRv7dLFrsrhlPADLmZai
         zDboFz7pWOqT6Mlbf3qQB9ymRDdNpdlw2zwgtCoQDRU5QIkW0yUeP+C1C25/F0IrJDmp
         x8xSwi26pkoiSy9HcOEurV4ALRrzN7wrSGHbLOV5i7+nxhwJ9X18A7z2ll33Pv35zlhH
         ez7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N8xcBDfU1RI/DnVW+OJJAFaV1us0etFnXPojQuh0XpY=;
        b=ZqlqJNGdX5MX9ThNdKfPdVBKJT+s4rjvM6jWqw4g+DLvCPTLhVE4PwkUtLKzTcCUqy
         it1HY/8Xn/1byKAbqaTplvBhQdE0yCT4XvO7H8jGZ6Oixe4qZrsVeVyso6kNGqFkM430
         IVegARJN3g+s9nWA8aW8lCLqodSRgY8gkrHPIs2vuQDmhsOQRNrfBrD49oeaRfqM6y2i
         Iilq01ZiH2ZOj0aDMbHIaA6q9SWBb1CnQQivHvDyKEUvm/TNjNVvX7aZhFCz5wYeK1cL
         hO80Zj31Ib10S+BkIxeQyCjdlrzAZbH5F46LGDCH9N+N8x5sl1vo5x+d2n3QOVEUYgst
         tLyg==
X-Gm-Message-State: AIkVDXLHyWs9jiIWlSDKVixBhMM2zgIRULbYhRCnDTkdH8pmft9ySG1qNok4QYfoAJis4Q==
X-Received: by 10.194.155.36 with SMTP id vt4mr5228158wjb.48.1484127838255;
        Wed, 11 Jan 2017 01:43:58 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5866.dip0.t-ipconnect.de. [93.219.88.102])
        by smtp.gmail.com with ESMTPSA id x140sm28762295wme.19.2017.01.11.01.43.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 01:43:57 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 11 Jan 2017 10:43:55 +0100
Cc:     Git mailing list <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Taylor Blau <ttaylorr@github.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3165D057-7486-4ACB-8336-E63F49182CBE@gmail.com>
References: <20170108191736.47359-1-larsxschneider@gmail.com> <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Jan 2017, at 00:42, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Some `clean` / `smudge` filters might require a significant amount of
>> time to process a single blob. During this process the Git checkout
>> operation is blocked and Git needs to wait until the filter is done =
to
>> continue with the checkout.
>>=20
>> Teach the filter process protocol (introduced in edcc858) to accept =
the
>> status "delayed" as response to a filter request. Upon this response =
Git
>> continues with the checkout operation and asks the filter to process =
the
>> blob again after all other blobs have been processed.
>=20
> Hmm, I would have expected that the basic flow would become
>=20
> 	for each paths to be processed:
> 		convert-to-worktree to buf
> 		if not delayed:
> 			do the caller's thing to use buf
> 		else:
> 			remember path
>=20
> 	for each delayed paths:
> 		ensure filter process finished processing for path
> 		fetch the thing to buf from the process
> 		do the caller's thing to use buf
>=20
> and that would make quite a lot of sense.  However, what is actually
> implemented is a bit disappointing from that point of view.  While
> its first part is the same as above, the latter part instead does:
>=20
> 	for each delayed paths:
> 		checkout the path
>=20
> Presumably, checkout_entry() does the "ensure that the process is
> done converting" (otherwise the result is simply buggy), but what
> disappoints me is that this does not allow callers that call
> "convert-to-working-tree", whose interface is obtain the bytestream=20
> in-core in the working tree representation, given an object in the
> object-db representation in an in-core buffer, to _use_ the result
> of the conversion.  The caller does not have a chance to even see
> the result as it is written straight to the filesystem, once it
> calls checkout_delayed_entries().

I am not sure I can follow you here. A caller of =
"convert_to_working_tree"
would indeed see filtered result. Consider the following example. The=20
filter delays the conversion twice and responds with the filtered =
results
on the third call:

CALL:     int convert_to_working_tree(*src=3D=3D'CONTENT', *dst, =
*delayed=3D=3D0)
RESPONSE: return =3D=3D 1; *delayed =3D=3D 1, *dst=3D=3D''

CALL:     int convert_to_working_tree(*src=3D=3D'CONTENT', *dst, =
*delayed=3D=3D0)
RESPONSE: return =3D=3D 1; *delayed =3D=3D 1, *dst=3D=3D''

CALL:     int convert_to_working_tree(*src=3D=3D'CONTENT', *dst, =
*delayed=3D=3D0)
RESPONSE: return =3D=3D 1; *delayed =3D=3D 0, *dst=3D=3D'FILTERED_CONTENT'=


I implemented the "checkout_delayed_entries" function in v1 because
it solved the problem with minimal changes in the existing code. Our =
previous=20
discussion made me think that this is the preferred way:

     I do not think we want to see such a rewrite all over the
     codepaths.  It might be OK to add such a "these entries are known
     to be delayed" list in struct checkout so that the above becomes
     more like this:

       for (i =3D 0; i < active_nr; i++)
          checkout_entry(active_cache[i], state, NULL);
     + checkout_entry_finish(state);

     That is, addition of a single "some of the checkout_entry() calls
     done so far might have been lazy, and I'll give them a chance to
     clean up" might be palatable.  Anything more than that on the
     caller side is not.

c.f. =
http://public-inbox.org/git/xmqqvavotych.fsf@gitster.mtv.corp.google.com/

Thanks,
Lars



