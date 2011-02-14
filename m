From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 21:21:47 +0700
Message-ID: <AANLkTi=N7N31D09YoRQsGTntspUfZRjfNHQtVpUfRus_@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
 <4D58D2DF.1050205@viscovery.net> <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
 <4D5906FD.7030502@drmicha.warpmail.net> <AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
 <4D59316E.5090203@drmicha.warpmail.net> <AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Miles Bader <miles@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 15:22:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PozJs-0003Np-UO
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 15:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399Ab1BNOWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 09:22:24 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64325 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab1BNOWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 09:22:23 -0500
Received: by ewy5 with SMTP id 5so2236315ewy.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 06:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=5AENnIhDcwYXfRIHbQHURoUnTuTuqWUCIdh6khnl45k=;
        b=wVdIds2CDdztxyrH4ZcK0QYswcmfku1jA/It7g257ezMQygBMWF/CdHza6HCEqmSNy
         bzzqZKxBB4AUmnFX6PR6KFpfKEYU3kO8vjrv0JFJ0sH5o09XzFGFyT40DkDMVERGwViQ
         8qveFG+6pAPuPb5fhUAr5q60uddfK5xqDlxHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fB2rR3YRMlflUyMeMamOvvRV1mZPEFB/xxEM/yl4DrjTt0NSTdQebEElmuVYR0389I
         kbyrWuVNXiaSKTQDj+A6YUCgipWuvYlzyMmr6iOz1fZ4kNCwCmxf42QokxJkJCzLKx8q
         n9EgE47YVj9MOQB0fVAQXtISqpQ6C+QaPm9pE=
Received: by 10.216.184.139 with SMTP id s11mr731397wem.13.1297693341774; Mon,
 14 Feb 2011 06:22:21 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Mon, 14 Feb 2011 06:21:47 -0800 (PST)
In-Reply-To: <AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166715>

On Mon, Feb 14, 2011 at 9:17 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Feb 14, 2011 at 3:43 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Nguyen Thai Ngoc Duy venit, vidit, dixit 14.02.2011 14:14:
>>> On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Full disclaimer: I have an alias "staged" for "diff --cached" myself...
>>>
>>> Be careful with your fingers. There's a command named "git stage".
>>
>> I know. Can we remove it as part of 1.8.0? It's our only builtin alias.
>
> I have proposed before to extend 'git stage', so you can do 'git stage
> diff', or if you alias 'git stage' to 'git s', just 'git s diff'. This
> would not conflict with the old behavior of 'git stage $file'.

It does. What if I want to stage a file named "add", "rm" or "diff"?
-- 
Duy
