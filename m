From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2] branch.c: simplify chain of if statements
Date: Thu, 20 Mar 2014 20:40:40 -0400
Message-ID: <CAPig+cQpO+0hfqVKCzi1DwbosQ=smK=JiTPcYM8iP4r7VnSKjQ@mail.gmail.com>
References: <1395071493-31435-1-git-send-email-dragos.foianu@gmail.com>
	<CAPig+cS9QApn1T3-R8n+W+1ee9FbNftsmhrr90SJKs+gqzvC5A@mail.gmail.com>
	<CAPig+cQKHQFNBob18g9UmZuE_mOpF3UMCBPfSKJYEYQpk1Z_tw@mail.gmail.com>
	<loom.20140320T001131-702@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 01:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQnVy-000350-6A
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 01:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966060AbaCUAko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 20:40:44 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:51521 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965157AbaCUAkl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 20:40:41 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so1720414yho.32
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XOjG2W2Uhe8cN9qlrJr0uc6XSDYPQhnWrCTRq4gG9ig=;
        b=rZrTAQTmUA7y3xDYCq9dwSSS7guf6OKTzRTVDIXx0V58lZRhsM1tfWA2o/Em71F2kr
         6c1WS9A7jxd1P+85msGJkahHciAunaHNSxmegt/JW7zFAMH9JE1PgRX9V7MTS9lfyvcI
         ZU9DyIkRiMlHkqgxNJtEvudDM8pZ/uBZ43Ihjn3mGzFKo0HxoTAhnVpYAYAidnw7xpNr
         sQOqydYiwbouRwUFtI8Llw/fT6LLcU/dWyjr9fDmvwkD809Q23GRRehRoUPoH5G7Bq8J
         MRLr2aH+4dM2okUa/scK//uz4v1naMZc7qO2ybZtNz8DlejhdutvVbdOktbSkAV0p632
         wL1A==
X-Received: by 10.236.143.148 with SMTP id l20mr23108192yhj.102.1395362440264;
 Thu, 20 Mar 2014 17:40:40 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 17:40:40 -0700 (PDT)
In-Reply-To: <loom.20140320T001131-702@post.gmane.org>
X-Google-Sender-Auth: ob3GNxzoll0gweQ7raBX2OR_SNc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244623>

On Wed, Mar 19, 2014 at 7:12 PM, Dragos Foianu <dragos.foianu@gmail.com> wrote:
> Eric Sunshine <sunshine <at> sunshineco.com> writes:
>> On Tue, Mar 18, 2014 at 6:31 PM, Eric Sunshine <sunshine <at>
> sunshineco.com> wrote:
>>
>> One other observation: You have a one-off error in your out-of-bounds
>> check. It should be 'index >= sizeof...'
>
> Well this is embarrassing.

It's a good illustration of the value of the review process. It's easy
to overlook omissions and problems in our one's work because one reads
it with the bias of knowing what it's _supposed_ to say. Reviewers
(hopefully) don't have such bias: they read the code afresh.

> Thank you again for the feedback. It's incredibily helpful and I learned a
> lot from submitting these patches. Making the code simple is harder than it
> appears at first sight.
>
> I'm not sure it's worth pursuing the table approach further, especially
> since a solution has already been accepted and merged into the codebase.

Agreed.

> In this case, is it okay to try another microproject? I was thinking about
> trying #17 (finding bugs/inefficiencies in builtin/apply.c), but I've
> already had my one micro project.

According to the description for #17, there are plenty of opportunities, so...

> All the best,
> Dragos
