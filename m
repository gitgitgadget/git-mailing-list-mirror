From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Sat, 19 Mar 2016 22:34:58 +0530
Message-ID: <CAFZEwPP1GwH6a1kLTCn6ETov6YeK-t9PFJ_-wWP2P6v7CObiGQ@mail.gmail.com>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Chirayu Desai <chirayudesai1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 18:05:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahKJE-0002R0-Vv
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 18:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbcCSRFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 13:05:00 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33090 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbcCSRE7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2016 13:04:59 -0400
Received: by mail-yw0-f169.google.com with SMTP id h65so30854491ywe.0
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=q/T+zXdeo4EMauPi7PC9yUhXqTCnrBIOYcC/4e4qhjg=;
        b=gyjvuxuS+ft6HSJR03K52CMMs8EpZL0yxjiwoxWyYTehS0VqTMwOjLScCKReg/7APN
         yUoMu6c6GLpxNCdDXPQdPk1/ZmvkW8IqR1uo3o77h1IxH+3VwauoJoERlzvR35e/mxy1
         cO9RukWjOK7/axmvpH/5HL9jiea99+hFqeh+uZ6FdF9LB+BHP4tyH3i+HmIegXwUobtZ
         QU1+UdD07yWF99Cf7J+6Fe5CgClEyIMEV7+Sg0vcyMHn16bM5cBeWgdhBHxuoPFMnxVX
         dDNAQx004Kg4EYKY4A6y+Jh8Qxtyrcs/1js0KHG/t2rcMH408ieoQcpb3KA3fWOxdUVG
         JnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=q/T+zXdeo4EMauPi7PC9yUhXqTCnrBIOYcC/4e4qhjg=;
        b=Gc0UMbCTWYsKE/etDkjlpPCOjP+ztSiKV1DwH0QPGqqiO5o8Ole+ClzF54iiqTNGvh
         aAdxLIYurWq5YwyHuv0QVfVEJBe5IT3wP6rG5cj8SThqbwyk9TMjd0Woo2hhtriSggx2
         7w2LnFqoYbManBjpm5Go6wVMgHKqz85ePQjgoi+zChdVbZDdp1IW7xZzoVXkEo9D8+hY
         Ai3miAIxdPj7lYawXGNmWQZt/JWjARqeahCunY8WAAGBfy1wy23c3GJ4EUOb1pRECzYl
         S7Cq4weCDg/M5rNyQa2TW44MuPaQM8MxZlofKKKEuawKLhDPWxFuMevWBkJfLIufnS5F
         ALJA==
X-Gm-Message-State: AD7BkJIAW69DQ8CMXFQXyu+VsytD/4BoEmWbkhnmrpTYwpuOGkKK31+6oQsGBta2IABdG6nuUbPGQibYCjm8BQ==
X-Received: by 10.129.9.214 with SMTP id 205mr9458003ywj.53.1458407098400;
 Sat, 19 Mar 2016 10:04:58 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sat, 19 Mar 2016 10:04:58 -0700 (PDT)
In-Reply-To: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289315>

On Sat, Mar 19, 2016 at 10:19 PM, Chirayu Desai <chirayudesai1@gmail.co=
m> wrote:
> Hi, I want to work on this as my GSoC micro project.
>
>> On Mon, Jan 18, 2016 at 10:24:31PM +0100, Toralf F=C3=B6rster wrote:
>> > very first line is "error: malformed object name <id>" which tells=
 all, or ?
>> Yeah, I agree that showing the "-h" help is a bit much.
>> This is a side effect of looking up in the commit in the parse-optio=
ns
>> callback. It has to signal an error to the option parser, and then t=
he
>> option parser always shows the help on an error.
>> I think we'd need to do one of:
>> 1. call die() in the option-parsing callback (this is probably a bad
>> precedent, as the callbacks might be reused from a place that wants
>> to behave differently)
> I assume you mean parse-options-cb.c:parse_opt_commits() by the callb=
ack.
> I see that it is currently used only by commands which have a "--with=
"
> or "--contains" option,
> and all of them behave the same way, printing the full usage, so a on=
e
> line change in that function would fix it for all of those.
>> 2. have the callback just store the argument string, and then resolv=
e
>> the commit later (and die or whatever if it doesn't exist). This
>> pushes more work onto the caller, but in this case it's all done by
>> the ref-filter code, so it could presumably happen during another
>> part of the ref-filter setup.
> I'm not quire sure how exactly to do that.
>> 3. teach parse-options to accept some specific non-zero return code
>> that means "return an error, but don't show the usage"
> This sounds good, but also the most intrusive of 3.
>> I think any one of those would be a good project for somebody lookin=
g to
>> get their feet wet in working on git. I think (2) is the cleanest.
>> -Peff
>
> What would be the best way to proceed with this?

The extract that you posted isn't very clear.
I guess posting a link with the previous discussion would be quite
helpful as some people don't have the previous emails in the inbox.
The archives can be found at
http://dir.gmane.org/gmane.comp.version-control.git .
