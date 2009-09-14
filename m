From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Tracking remote branches
Date: Mon, 14 Sep 2009 15:30:10 -0300
Message-ID: <a4c8a6d00909141130o628a069fu4c489b25f95f543d@mail.gmail.com>
References: <a4c8a6d00909131737v35d7c63dsea669f47456f5acb@mail.gmail.com>
	 <20090914050145.GA12985@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Sep 14 20:31:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnGJz-0005iE-3F
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 20:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933222AbZINSaM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2009 14:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933218AbZINSaK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 14:30:10 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:60360 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933216AbZINSaI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2009 14:30:08 -0400
Received: by ywh4 with SMTP id 4so4607374ywh.5
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BlfuyJWN+aWHE4VazoeKZ7wlSKCfgCetbzmQvuAL92o=;
        b=BMe5RIbRdYMXS18Ipg+/yemHJ5MYYjSSl1cPcUziGduLpOWvCAv14bpyUU3IXpBFT2
         Oj67bHTqIvztLp0H2IfTSJCa2oDmsg2M8754zvPhNOghf/kblN9t4Bw8j3+a5LwUrbBu
         6xDr/gWouwm1ort4xgcU38M09rRdGoI02BMTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AN+mK5A0KTK61fpiFiA3LSmiwsR9tQLVSySiKncDxIpgnuX4Qd8qwGcSo8oQALc3+U
         fv3U5yipKuepP6lQ1h8IQ7Auw2wypX3Ix3MYADUGuws24zVKZ0Sl9H/SUGaMOQsZIzZi
         7u1fonKZCb6rtaWQpQkxW5BFbj6Zwj1du191s=
Received: by 10.101.180.33 with SMTP id h33mr6561790anp.155.1252953010982; 
	Mon, 14 Sep 2009 11:30:10 -0700 (PDT)
In-Reply-To: <20090914050145.GA12985@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128487>

On Mon, Sep 14, 2009 at 2:01 AM, Nicolas Sebrecht <nicolas.s.dev@gmx.fr=
> wrote:
> The 13/09/09, Thiago Farina wrote:
>> Hi,
>>
>> I know that I could do simply, instead of above:
>> $ git checkout --track -b maint origin/maint
>
> Or
> $ git checkout -t origin/maint
>
>> OK, now I switched to maint branch. And then I did:
>> $ git status
>>
>> # On branch maint
>> # Changes to be committed
>> # =A0 =A0(use "git reset HEAD <file>..." to unstage)
>> #
>> # =A0 =A0 =A0 =A0 =A0new file: =A0 =A0git-remote-curl
>> # =A0 =A0 =A0 =A0 =A0new file: =A0 =A0git-replace
>> #
>>
>> What happened here? What I have to do now?
>
> You've probably added these files to the index, mistakenly. If you do=
n't
> have uncommited changes, try :
>
> =A0git checkout -f master
> =A0git branch -D maint
> =A0git checkout -t origin/maint
> =A0git status
>
> The files should now be shown as "Untracked files".
Yeah, now the files has this status. But I don't have anything related
with these files, I didn't add these files.
Why these files has this status? Is supposed to me to do something
about that when this situation occurs?
