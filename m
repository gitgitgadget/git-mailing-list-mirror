From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Correcting forgetting to make a new branch
Date: Fri, 11 Mar 2011 15:53:19 +0000
Message-ID: <AANLkTikjonZxcHk3a4HvEhiDfcBqwgpqzFP2F=8tF7qv@mail.gmail.com>
References: <AANLkTi=fp=-pwi7Mj9TptP22mtP51bzq5UwTLRx9LnNB@mail.gmail.com>
	<op.vr6rgcqs56e9f9@xman.eng.oslo.osa>
	<vpqk4g57j1h.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Alexey Feldgendler <alexeyf@opera.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 11 16:53:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py4ec-0000a4-01
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab1CKPxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:53:20 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40941 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1CKPxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 10:53:20 -0500
Received: by ywj3 with SMTP id 3so1224778ywj.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=YGhbzlovisyIAhSZYojfGZ2aPYgISEpew4yeu2X9dNk=;
        b=T0vuJBEnvD+wXRTpihJtpDo2poX8umfgWGhvFHTA6FA4rinNV03gLSk9umwXicMnOH
         yKUMxdcs1aU/zFGF4lyYhfMw01KWVWssp/U2YdOVQgA6bl7Cw7CnlvvtEEWTXtAe1cyh
         ui5xWaVY4kiL/Gcsa790HzJVRKcSE22OJGFKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=F9MyD6SAIB1xRo1go3RQkmUXUh5tjbBnXzIQ7s97QMo8oQNdwkXgED9PQ4+1Rr4Zkk
         DTz8A0DeT364F/poEDleoioHcgrkFeZ2Lz5j7BvsRrGy0jb+SiJ6hQaZxJBJfIeh7Wsy
         xCqD/uHAEjPVLTFlu5nruYDty9cs+SV5eoJjA=
Received: by 10.91.4.36 with SMTP id g36mr36492agi.21.1299858799555; Fri, 11
 Mar 2011 07:53:19 -0800 (PST)
Received: by 10.90.94.9 with HTTP; Fri, 11 Mar 2011 07:53:19 -0800 (PST)
In-Reply-To: <vpqk4g57j1h.fsf@bauges.imag.fr>
X-Google-Sender-Auth: sA8F-7Vl666gfFAEA1Y_ZUSnAWs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168915>

> "Alexey Feldgendler" <alexeyf@opera.com> writes:
>
>> However, the branch that was active before when you should have
>> branched will have been unintentionally updated. To fix that, you'll
>> need to move the old branch a few commits back:
>>
>> git branch -f <old-branch> <where-it-was-before>
>
> This is correct, but for completeness: don't do that if you've already
> pushed your changes. If you pushed them and people already pulled them,
> you can hardly do better than appologize to your co-workers that you
> shouldn't have done that, and possibly create a new commit on top of the
> branch reverting what you did.

I hadn't (luckily), so that worked fine. Thanks for your help - both of you :)
