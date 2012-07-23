From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git with large files...
Date: Mon, 23 Jul 2012 09:53:27 +0530
Message-ID: <CAMK1S_hO5g5p4NjoVcxYFTt_KZ-wBRJk=OCveeszwr8U2LeZbg@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
	<86fw8mf3gp.fsf@red.stonehenge.com>
	<7vvchfple2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StABH-0002Uj-PN
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 06:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab2GWEXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 00:23:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37576 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab2GWEX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 00:23:28 -0400
Received: by obbuo13 with SMTP id uo13so8908799obb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 21:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0gvsyhwcc8bbNERhX6k6+ItVF72WHTsK3Z5wK4rs2SQ=;
        b=kYt0wdTArQGIgujwYfD8HyaFaG7rnxlTfkkKaZ1mJsIkseCKX7uXeVlrapwcfRYHUw
         gcfzD9ff9nPWfmX814jN3mrdt4epCK54ef/B6Pw7V8FqGx7VNm8B1lJM/5MSJ1+Zt5LK
         o3GHP1dc3ODW0OhG0ONomhQoCEO3xTwlO5V9NwCJ3SX/Ud3TZqTpYTnEyEEVn0m7zYxN
         6xPYGPamliQ0DFi1igI+XJPmRm2ic+gu1yL961vPOVukUEjC0E6GpIWZHNEXV5XbjTNz
         O0IbidGAs8ymLvP7STTOT3R0CZ0hQEgmYe4vPrlN+VkF1/Z7TJqOJEE/9c9FBTrhX1EJ
         vWfw==
Received: by 10.60.172.101 with SMTP id bb5mr18678556oec.44.1343017407580;
 Sun, 22 Jul 2012 21:23:27 -0700 (PDT)
Received: by 10.182.44.199 with HTTP; Sun, 22 Jul 2012 21:23:27 -0700 (PDT)
In-Reply-To: <7vvchfple2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201893>

On Mon, Jul 23, 2012 at 2:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>>>>>>> "Darek" == Darek Bridges <darek.bridges@me.com> writes:
>>
>> Darek> I use git for many things, but I am trying to work out the
>> Darek> workflow to use git for deployment.
>>
>> Don't.
>
> Yeah, "don't think 'git checkout' is a way to 'deploy'".  Using Git
> as a transport measure is probably fine.

You can also try
http://sitaramc.github.com/the-list-and-irc/deploy.html.  Whether it's
saying you *can* use git for deploying something, or you *can* but
*should not*, or you *cannot*, will depend on your own thoughts on the
matter ;-)
