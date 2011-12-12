From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Auto update submodules after merge and reset
Date: Mon, 12 Dec 2011 18:43:22 -0500
Message-ID: <CABURp0r37+VHBVVKepHPC4jwa-wJ0b+qwLrhhFR8KXnMQYTT3w@mail.gmail.com>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de>
 <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx>
 <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com>
 <4EE51D7B.7020806@ursus.ath.cx> <4EE682A3.8070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 13 00:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFXB-0004WT-Mx
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 00:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab1LLXnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 18:43:45 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62448 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab1LLXno convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 18:43:44 -0500
Received: by wgbdr13 with SMTP id dr13so12318512wgb.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 15:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+tMmuqTZGO9ICfwXjqkjAyLIFAbQMhIvz5f3ZzK6xn8=;
        b=IxpewXdIrXreqHtAp59GKzSU+bDjfSlUfjWxQU0u09VrBS4qavqYUa29X2eVZJgPY4
         32ohjNRLw3fpzgoRhZFSdRQ5HCRfbe6jOxgZ5ofLfVxbQWPq70Rl3FxQXiDcpml13N2j
         qJP6No0se4mrCvsHI6s59PiOIcsuGkUSYWLaA=
Received: by 10.227.205.130 with SMTP id fq2mr18629095wbb.17.1323733423528;
 Mon, 12 Dec 2011 15:43:43 -0800 (PST)
Received: by 10.216.120.199 with HTTP; Mon, 12 Dec 2011 15:43:22 -0800 (PST)
In-Reply-To: <4EE682A3.8070704@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186975>

On Mon, Dec 12, 2011 at 5:39 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 11.12.2011 22:15, schrieb Andreas T.Auer:
>> In http://thread.gmane.org/gmane.comp.version-control.git/183837 was discussed whether the gitlink in the superproject should be set to all-zero if updates follow the tip or maybe use the SHA1 of the commit when the submodule was added. I think the gitlink should be updated everytime when a new commit in the superproject is created.
>
> Nope, only when "git submodule update" is run. Otherwise you'll spray the
> history with submodule updates totally unrelated to the commits in the
> superproject, which is rather confusing.


And this is why my superproject is a makefile, a .gitmodules file and
a bunch of gitlinks.  We only use it to track the advancement of
submodule activity.

So yes, I want my superproject's gitlinks to update automatically.  I
just don't know a smart way to make that happen.

Phil
