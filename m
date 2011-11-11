From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Disappearing change on pull rebase
Date: Fri, 11 Nov 2011 11:08:16 +0100
Message-ID: <CAGK7Mr6GHNXLCaP94-peUd2TgBn16boLDVKkniPi-=p_WdV7LA@mail.gmail.com>
References: <3FF1328CB05DB74898F769F1BA17812C3E49B74671@GVW1348EXA.americas.hpqcorp.net>
 <B5934593-5EE9-4A9F-96D5-0E36B696EFBD@jetbrains.com> <3FF1328CB05DB74898F769F1BA17812C3E49B74699@GVW1348EXA.americas.hpqcorp.net>
 <4EBCC71D.6000505@viscovery.net> <CAGK7Mr6D6-4aNceTDCYTHabA3vnxh+uvQ=GOeS_3nrL9rjmc9w@mail.gmail.com>
 <4EBCF34A.3090908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Pitucha, Stanislaw Izaak" <stanislaw.pitucha@hp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 11 11:08:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROo2Y-000133-Eb
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 11:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab1KKKIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 05:08:48 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43197 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1KKKIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 05:08:47 -0500
Received: by iage36 with SMTP id e36so3974481iag.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JYfit9C40U5m7KEXxDRrWAinnvNbC+TB81s+nkz5uV8=;
        b=Ryv8+H1gScLA0rA/MQb6BMYGa1wTkBIVtI+dN6rdVDWDAauvYwhEuCs+GNVI6gqELa
         9nQXmAUFvX+bY2/LO+xiV+QjSAbz4h5xAc6CeNUl4b8m9NuAx4HT0BQwqYpY0lw2sn4y
         EZyCn4h591+yi8znk5j+sSoBt8aT0Ug7niAi8=
Received: by 10.50.17.199 with SMTP id q7mr11721078igd.20.1321006127072; Fri,
 11 Nov 2011 02:08:47 -0800 (PST)
Received: by 10.50.195.199 with HTTP; Fri, 11 Nov 2011 02:08:16 -0800 (PST)
In-Reply-To: <4EBCF34A.3090908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185260>

>> Doesn't this create a problem if you pull, resolve a conflit but do NOT
>> push, then pull --rebase some more commits later on? As I understand
>> it, the conflict resolution commit will be a merge commit and will be
>> thrown away by the git pull --rebase.
>
> You are correct, but it is not a problem: During the rebase, the same
> conflicts will arise as during the merge, and you will be forced to
> resolve them before you can complete the rebase. Therefore, nothing will
> be lost.

Doing the same conflict resolution twice is kinda irritating... but
ok, fair enough.
I guess when you resolve a conflict you're supposed to push to avoid this :)

Philippe
