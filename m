From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 06:40:23 -0800 (PST)
Message-ID: <m3ipwm8yv0.fsf@localhost.localdomain>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<87k4h34bhj.fsf@catnip.gol.com>
	<7vr5bbupj4.fsf@alter.siamese.dyndns.org>
	<AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
	<4D58D2DF.1050205@viscovery.net>
	<AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
	<4D5906FD.7030502@drmicha.warpmail.net>
	<AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
	<4D59316E.5090203@drmicha.warpmail.net>
	<AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>
	<AANLkTi=N7N31D09YoRQsGTntspUfZRjfNHQtVpUfRus_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Miles Bader <miles@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 15:40:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PozbM-00069Z-Ow
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 15:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab1BNOk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 09:40:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63971 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab1BNOk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 09:40:26 -0500
Received: by fxm20 with SMTP id 20so5286902fxm.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=vSSebldwCTrBRMm4qNypgAYMylfr9aMauo0rixkDdCQ=;
        b=w13SzZhVgPgmAFg7E/LzwNcT/1IaV4OAgEMVOmFrnrNJO8+A2KCjWHgwxvZ+GGlMJH
         NBArK2URkEL1gv76qLd6/wgzNRZhePiYfRD82btKcjfEETmDCsrybYUw5X8bk/eb+3pi
         YiB/fjK8JUrgpGmgo3KqnFgIOXYW5phOYHZ0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=IGv6k/SBhmiMWUtfNyXFNwvXytA8eA04YgOHW+RORlC7phO9qilo9E1RBO8U4k4B9j
         BsYRAtVO9Ll7F2akclQ42dM4zH/b89xAz0zU9sBGh8v05zvS6aG4GWi56z+XizUQxCwj
         dO7ET9C2iVkJ1sYNfRufrVHGsHKk/wl034CTk=
Received: by 10.223.100.12 with SMTP id w12mr422518fan.42.1297694424734;
        Mon, 14 Feb 2011 06:40:24 -0800 (PST)
Received: from localhost.localdomain (abvu55.neoplus.adsl.tpnet.pl [83.8.218.55])
        by mx.google.com with ESMTPS id a2sm1082238faw.46.2011.02.14.06.40.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 06:40:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1EEdZ1W001184;
	Mon, 14 Feb 2011 15:39:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p1EEd23t001173;
	Mon, 14 Feb 2011 15:39:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=N7N31D09YoRQsGTntspUfZRjfNHQtVpUfRus_@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166716>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> On Mon, Feb 14, 2011 at 9:17 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Feb 14, 2011 at 3:43 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Nguyen Thai Ngoc Duy venit, vidit, dixit 14.02.2011 14:14:
>>>> On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:

>>>>> Full disclaimer: I have an alias "staged" for "diff --cached" myself...
>>>>
>>>> Be careful with your fingers. There's a command named "git stage".
>>>
>>> I know. Can we remove it as part of 1.8.0? It's our only builtin alias.
>>
>> I have proposed before to extend 'git stage', so you can do 'git stage
>> diff', or if you alias 'git stage' to 'git s', just 'git s diff'. This
>> would not conflict with the old behavior of 'git stage $file'.
> 
> It does. What if I want to stage a file named "add", "rm" or "diff"?

Then you would use

  $ git stage ./diff

or

  $ git stage -- diff

(or even "git add diff" ;-)).

P.S. I haven't checked that above work...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
