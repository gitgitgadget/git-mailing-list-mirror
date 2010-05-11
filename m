From: Miles Bader <miles@gnu.org>
Subject: Re: git-gui disagrees with git status
Date: Tue, 11 May 2010 15:27:23 +0900
Message-ID: <AANLkTinYJuyfqRr8C8QD_OTTvlyY_zmTqic_JoGy-WtE@mail.gmail.com>
References: <y2m3b1db1e51005101432je9e75a53vbb3781fa33aa83e7@mail.gmail.com> 
	<20100510213926.GA7156@spearce.org> <buo632vj8px.fsf@dhlpc061.dev.necel.com> 
	<4BE8F1DB.2060205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bill Winspur <bwinspur@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 11 08:27:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBiwX-0004ey-TZ
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 08:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898Ab0EKG1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 02:27:44 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:61997 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab0EKG1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 02:27:43 -0400
Received: by pxi5 with SMTP id 5so2047914pxi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 23:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=KofIYdLx/Ag6x//V4n7tGXvCaSUq0RtYbPj9qtdRZyk=;
        b=hKTAX6QSiPp55laN5Cd6K8JHZzj5YKleDl8KStjK2s82zF5D+TrR4pNo3rotNqGQ/U
         SuiebUsp1CFn1d9RtUUDOmoZdbNFnCM2cvWUHP6YTPMTCNz5B6qxKcbOkJNE/8tAL2O5
         nFIHok+ZhTTZSPh0MSxH/CzN4uoZyzr6y2aEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=IB64NSRaMBYne6v7yWobgOhUSvYPmIBMdEdaSM0M05DHzW3JgM0Wia/FpOBLDq3vsK
         xaIHSn71U1l7dUWPailWBM581s/b3et78v72rk8skDgplZ2c5DxTsZLRERoH3iwgh+6x
         RYPfzzRKqAFl7z6OyfWleCRkf/ag2TJsEInMQ=
Received: by 10.143.26.39 with SMTP id d39mr3704148wfj.10.1273559263089; Mon, 
	10 May 2010 23:27:43 -0700 (PDT)
Received: by 10.142.222.16 with HTTP; Mon, 10 May 2010 23:27:23 -0700 (PDT)
In-Reply-To: <4BE8F1DB.2060205@viscovery.net>
X-Google-Sender-Auth: VoZoSlT4MrsJEmdilV-zUzJ7okY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146873>

On Tue, May 11, 2010 at 2:57 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>>> Its more a feature.
>>>
>>> git-gui shows all untracked files, recursively expanding any
>>> directories which contain untracked files. =A0git status collapses
>>> them up.
>>
>> Wait, why is this a feature, exactly...?
>>
>> It may be well known that git-gui works this way, but that doesn't m=
ake
>> it good behavior for the user.
>
> Oh, it *is* good behavior. Otherwise, it would not be possible to sta=
ge a
> file that resides in a currently untracked directory; you would have =
to
> fall back to 'git add' on the command line.

Since it's a GUI, though, it's allowed to use interaction -- so even
_better_ behavior would be to only show unknown directories as single
entries but allow the user to expand them interactively in the
(probably rather rare) case that they want to add some file in an
untracked directory.

-Miles

--=20
Do not taunt Happy Fun Ball.
