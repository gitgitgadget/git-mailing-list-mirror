From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 0/2] git-p4: kill watchdog and suppress irrelevant output
Date: Tue, 22 Dec 2015 10:12:15 +0100
Message-ID: <F3AA0745-A9C1-40D4-AF63-EDBFB7A5DB19@gmail.com>
References: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com> <xmqqh9jbfsra.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 10:12:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBIze-000527-KC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 10:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbbLVJMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 04:12:20 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35242 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbbLVJMR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 04:12:17 -0500
Received: by mail-wm0-f49.google.com with SMTP id l126so101537769wml.0
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 01:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JMFPTDCJ0PvswKZYy7XjZd7YFqTAvSeSCwyIYTjDZQc=;
        b=cGcNlwxO59WOLIw3eW4o9LKeGSHTRkkQEWenBeVkZD33A1sgwo4TsopaTxunVU0mi7
         vbbkUbtquX0KTqbPnSRVPaEejI1PKaYQjeQ6PfRT3XjvvPs6tnxIbZOk2x/s3CfTZZJK
         PYmyylBjbDsbrqCiYy3yXfU3z6oVZO9VFV5BuieCQr0pWVGaWhtzT6Cef50XkOBYLpMk
         tNeC+qVwItTByamRbO1iYpyHXX3xTLIauRiAyawOxKhLyN8QiCMZAT3Ylv1ihGU3WA4l
         9eNI47DS7KDsp5EiAYqnfCfm1cId8LauD41onfTmQcZq/2OLrhcVWSsuAql0Z/44aboP
         X0eA==
X-Received: by 10.194.222.135 with SMTP id qm7mr26256083wjc.106.1450775536209;
        Tue, 22 Dec 2015 01:12:16 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB452E.dip0.t-ipconnect.de. [93.219.69.46])
        by smtp.gmail.com with ESMTPSA id u126sm23796554wme.3.2015.12.22.01.12.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Dec 2015 01:12:15 -0800 (PST)
In-Reply-To: <xmqqh9jbfsra.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282837>


On 21 Dec 2015, at 21:31, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Hi,
>> 
>> these patches extend "git-p4: add trap to kill p4d on test exit" (dfe90e8)
>> and therefore should be applied on master.
> 
> Wait, wait.  Please be a bit more careful when you use such a
> phrasing.  Did somebody review these and said that these are
> trivially correct improvements?
> 
> This depends on what you exactly meant "extend" and "improve" (for
> the other one); if the "improvement" were to make something that
> used to be unusable to usable, then the more sensible way forward
> during the -rc stabilization period might be to revert the earlier
> merges to 'master' that brought in undercooked topic.

Oh. Thanks or making me aware of the inappropriate phrases! 
Nobody reviewed these patches, yet! 

My intention was to let the reviewer know that this patch series is based on 
"master" and not on "maint". Sorry for the confusion!

The patch series "git-p4: kill watchdog and suppress irrelevant output" fixes
something annoying that I did not spot earlier. In other words it changes
"usable but a bit annoying (dfe90e8)" to "usable".

The patch series "git-p4: ignore P4 changelists that only touch files" changes 
"usable (4ae048e)" to "maybe even better" depending on the reviewers
opinion.

Thanks,
Lars
