From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/6]
Date: Tue, 23 Jul 2013 19:18:49 -0400
Message-ID: <CAPig+cRfPeHZ-rmOzRTqdw7QkJKf4e2CxMr4-zDvekxH=ROBew@mail.gmail.com>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
	<loom.20130723T113216-324@post.gmane.org>
	<7v8v0x874x.fsf@alter.siamese.dyndns.org>
	<68F84DC48FCA4226A8F3C00AC42A9598@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jul 24 01:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1lr6-00049X-0T
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 01:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934131Ab3GWXSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 19:18:52 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:46695 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386Ab3GWXSv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 19:18:51 -0400
Received: by mail-la0-f51.google.com with SMTP id ga9so5014545lab.10
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=wW6o4ABBV4NrNiS/weNJYDRbj6KU2aWO0qKXqpgfAnA=;
        b=XtX5qkPWf0kobGNekAcir0AtUCGnI+d0oxyTgor6Hh5GEIfOSWzy7xGzZQ7DDSt9BK
         NFKcCzdQUYGwHQDX6GWTM7WR/jvTd/fgj0E410ACxjtFttyI1zFO3C+8TXqVCsOpoPfd
         3DVNPg+9HkqTiL8CwfGxcGvTy+IyCmYPOLW88PZsNF2RHifteOsZWYwApMvBfCcv7IA5
         390ds/hLa+Gp3MIuPRq4ifu26qjurs+zXnnKzq+aY8Mchu3mSDV/u90356Yr1wszbhtr
         S1f6oXxt8gVhnoQp5yPoleeWP+HLdwYY8srjXOHXMWo6HTLdMDY/559PUgGB52aGZQXv
         K2Yw==
X-Received: by 10.112.144.35 with SMTP id sj3mr15443438lbb.4.1374621529800;
 Tue, 23 Jul 2013 16:18:49 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 23 Jul 2013 16:18:49 -0700 (PDT)
In-Reply-To: <68F84DC48FCA4226A8F3C00AC42A9598@PhilipOakley>
X-Google-Sender-Auth: VYX-YUDXUKQuvaXT_IBwPYF49-I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231071>

On Tue, Jul 23, 2013 at 5:26 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Tuesday, July 23, 2013 7:26 PM
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> Junio C Hamano <gitster <at> pobox.com> writes:
>>>> This is mostly unchanged since the previous round, except that
>>>>
>>>>  * The option is spelled "--force-with-lease=<ref>:<expect>".
>>>>    Nobody liked "cas" as it was too technical, many disliked
>>>>    "lockref" because "lock" sounded as if push by others were
>>>>    excluded by it while in fact this is to fail us.
>>>
>>> Perhaps "--force-gently" ? :-)
>
> Or "--force-carefully" to better indicate the safety / care that is being
> applied?

[bike-shedding: on]

--force-if-safe

[bike-shedding: off]
