From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Sun, 7 Oct 2012 15:13:46 +0200
Message-ID: <CA+EOSBm-Z7RMb16Vk36+ek3Y1aRVTZ0mp0OPMB2iwU5_rtLOjA@mail.gmail.com>
References: <50706B54.8090004@ramsay1.demon.co.uk>
	<7vbogfquc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 15:14:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKqgK-0007tp-3W
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 15:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304Ab2JGNNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 09:13:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47534 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2JGNNr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 09:13:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7287961iea.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=kSxtEh49/LgOR6gv17vCj+Xr6i6zeOlx0P3rihYJIJU=;
        b=hI+bpO9kKoyXz/s7DeatwWkpgkaPOZ86SR83oF0yU2jnd71X/sFVfHt2BaVozuK8cs
         bgIpAN1tQwOfa2boddrD5Ysp2IMgNB4YMhSTMUun+AGPM3P87ycyeS6P6tja2bHjEKEA
         AloV5lDCQu4iDMDP4rx89xczSvaERNv3x7+vhzFRgZoXwhv3UElidCNge/0w5ZaIJ/+n
         3wfF8ZkHd3LJR4KCIlz3qhZWfANl6GkhqswPUI+P2KboLHIhax6MAqCskJqQAsFb2LxZ
         /5OmvzKVstYkqhhjvKPS/n20wRXQMd5aJq5zxq4dGr1BXTR0WoWmmNWrnQ9IRjPsWo2i
         6XZA==
Received: by 10.43.7.132 with SMTP id oo4mr10868554icb.6.1349615626913; Sun,
 07 Oct 2012 06:13:46 -0700 (PDT)
Received: by 10.64.58.135 with HTTP; Sun, 7 Oct 2012 06:13:46 -0700 (PDT)
In-Reply-To: <7vbogfquc8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207179>

Hi Julio.

No, i don't know this message before. Difficult that can be related to
a recent glibc change, i think. Perhaps eglibc ? I tomorrow take a
look, i am on travel now.
Best

2012/10/6, Junio C Hamano <gitster@pobox.com>:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> The malloc checks can be disabled using the TEST_NO_MALLOC_CHECK
>> variable, either from the environment or command line of an
>> 'make test' invocation. In order to allow the malloc checks to be
>> disabled from the 'config.mak' file, we add TEST_NO_MALLOC_CHECK
>> to the environment using an export directive.
>
> We would want to encourage people to test with cheap but effective
> checks when available.  I do not see "malloc: using debugging hooks"
> message anywhere when I run tests, but if you do, I'd rather see us
> check if we can tell glibc to stop doing so first without disabling
> the whole test.  Your patch feels like the first step to a slipperly
> slope whose destination would make us say "we get too many messages
> so let's do nothing in "make test" with this configuration." when
> taken to the extreme, and obviously we would not want to go there
> ;-).
>
> Elia, you brought the MALLOC_CHECK_ up.  Did you hear about this
> issue elsewhere before, and if you did, do you know how other
> projects solves it?
>
> Besides, doesn't a simple instruction to export TEST_NO_MALLOC_CHECK
> to your environment before running "make test" suffice?
>
>

-- 
Inviato dal mio dispositivo mobile
