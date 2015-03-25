From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Wed, 25 Mar 2015 01:37:57 +0100
Message-ID: <CANQwDwfdUDZfgFar3tr8Er3Ha-1hS0Ypkbsbn0UaSJ7HadsR1Q@mail.gmail.com>
References: <538F69DA.9010201@gmail.com> <xmqqmw338khu.fsf@gitster.dls.corp.google.com>
 <xmqqpp7y3ucy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <mail@mwagner.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:38:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaZLI-0001bC-0l
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 01:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbbCYAij convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 20:38:39 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35909 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbbCYAii convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 20:38:38 -0400
Received: by lbbug6 with SMTP id ug6so6564784lbb.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 17:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fsaZpbca6njHb7D5zKNVZZMunGaNt+s0MrW58B4lEOA=;
        b=Z6vjaCFuYUSVJdyfT+AschxkTh1F9NRWevIqJyT+f/Ht7e2QWJeRTfdHHcNU81+KC7
         gFZyf4r85ds0JlV1vKS24wvoDeJ28wlEy2IjZ3/RIx1bYerbdYQE5qhB/+y4AsQFPvr+
         oVwoLNjwqLq3v9McSYnsQTqy7elT7Ie8mlkKQ2hf7xvOQDmEM6G8pwAGp+foD/5C3qlW
         FpVI7O0fKRn3aNSgZGRHZvs5rL2fpnD0rfpc+QeSYQUqOSIPX9hG5teOFKgeWp8VzrDu
         xOaAP4WydXhz5aezyJHE8ADFaMdvSxQv5+ByWlu52Arv8cWsQUNIMG6ptqJHxoYranr7
         9RHg==
X-Received: by 10.112.26.209 with SMTP id n17mr6016226lbg.84.1427243917610;
 Tue, 24 Mar 2015 17:38:37 -0700 (PDT)
Received: by 10.25.88.17 with HTTP; Tue, 24 Mar 2015 17:37:57 -0700 (PDT)
In-Reply-To: <xmqqpp7y3ucy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266243>

On Tue, Mar 24, 2015 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > * jn/gitweb-utf8-in-links (2014-05-27) 1 commit
> >  - gitweb: Harden UTF-8 handling in generated links
>
> This has been lingering in my 'pu' branch without seeing any updates
> since $gmane/250758; is anybody still interested in resurrecting it
> and moving it forward?

I can try to pick it up, but I am no longer sure that it is a good idea
to solve the problem.

In particular git does not require that paths (i.e. filesystem) use utf=
-8
encoding; it could use latin1 / iso-8859-1 and non-utf8 octet.
--=20
Jakub Nar=C4=99bski
