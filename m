Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A432018E
	for <e@80x24.org>; Mon,  8 Aug 2016 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcHHR1V (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 13:27:21 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:32805 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbcHHR1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 13:27:20 -0400
Received: by mail-io0-f171.google.com with SMTP id 38so364115343iol.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 10:27:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lG4CNGH9iApuHKUzRq84/ZQqGJSahZDSqgDbcAfrU5w=;
        b=D4f1O+QHb0BgR6FNwHxYYFr0QHikPLVdnH15fhr2oaJkKbxOkwDpzE+vSfHY/zG+lM
         J9RY5NATYggQnlLXGr3S+H+5qt0sPi2BECjAs2s2PJskq4WfFmEHXOVi/JfIl5F7oBR0
         717ts4lfrC4DWtw4VsF+6Eql7AdYwmmJDtq9HEEOPCpa87ER9iVR5y7lw/zgQUfStWX1
         vK2pIsLvFOhxFBAbEgUBvWb+ojiLtOaZIEj9VvgnAe5qgglT3ETxWv4faIXJDy6x/GM3
         NjwD/NKDR5YHBBD5hyJyOEfm7TWVVnhqPgcBLFJqUFjVIf9mzIvNmzC/kbsNeKVWTuJr
         Ke6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lG4CNGH9iApuHKUzRq84/ZQqGJSahZDSqgDbcAfrU5w=;
        b=AdJvMGE4L9U9j4VmuvZqnnW9JOjBh+oH7NpANUqxuHcm4ggJS3WUf0387V8sDpP7Iv
         b/zgAhZavUcUOujJvjcKUeENUU3T9l89VXMspe18x884yiOmaVdJUexF6u3V63I5ySQ/
         VcNjHz9Y8BtyCyAO4lxHku6WZwKREU+a+iy3C5LGvPgehdLi71uw1Iwy3H9y2ygj2Fvm
         6WUVBtXX+p/JoZTiiUwZ4HV3AwKkj4gM7Yl5JuQJjrscI4fOx4JMdk/oN8l2HKlWCcnQ
         TPadCcNCpNmu5lx3L1CvLmthJW12dBEbBeB2oIDKMHeL4EqgIEZVu265U3AhvTSSn9JZ
         NfrA==
X-Gm-Message-State: AEkooutCJVijibkcNtatF0zhHpdeg+geflnZgCTJxizpI+bcxnT32ugSmse3l6oz9rnfOpm68ylzNJyFqJWQU1Kq
X-Received: by 10.107.131.38 with SMTP id f38mr98963742iod.173.1470677239404;
 Mon, 08 Aug 2016 10:27:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 8 Aug 2016 10:27:18 -0700 (PDT)
In-Reply-To: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 8 Aug 2016 10:27:18 -0700
Message-ID: <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Sep 10, 2015 at 9:28 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hey,
>
> does anyone know of any tricks for storing a cover letter for a patch
> series inside of git somehow? I'd guess the only obvious way currently
> is to store it at the top of the series as an empty commit.. but this
> doesn't get emailed *as* the cover letter...
>
> Is there some other way? Would others be interested in such a feature?

Being late to this thread, but I think

       branch.<name>.description
           Branch description, can be edited with git branch
           --edit-description. Branch description is automatically added in
           the format-patch cover letter or request-pull summary.

is what you want. Maybe we want to see a patch that adds the reverse
functionality as well, i.e. git-am will store the the cover letter as the
branch description and git-merge will propose the branch description for
the merge commit.

>
> I get very annoyed when I've written a nice long patch cover letter in
> vim before an email and then realize I should fix something else up,
> or accidentally cancel it because I didn't use the write "To:" address
> or something..
>
> I really think it should be possible to store something somehow as a
> blob that could be looked up later. Even if this was a slightly more
> manual process that would be helpful to store the message inside git
> itself.

I agree here. I personally do not use that variable (yet), as it doesn't seem
to be editable easily.
So here is what I do:
1) First series is generated with format-patch --cover-letter
2) any following v{2,3,4} is generated without the cover-letter but with
  --subject-prefix=PATCHv{2,3,4}
3) the cover letter is manually edited to be the next version and a section
  is added why the next version of the series is sent.

>
> In addition, this would help re-rolls since it would mean if I go back
> to a topic and re-roll it I can just update the message. If it were
> properly stored in my local history that would also mean I could see
> revisions on it.
>
> Any thoughts on how to do this?
>
> Regards,
> Jake
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
