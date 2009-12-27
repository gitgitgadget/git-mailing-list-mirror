From: Howard Miller <howardsmiller@googlemail.com>
Subject: Re: Newbie to git
Date: Sun, 27 Dec 2009 20:12:09 +0000
Message-ID: <26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>
	 <3a9710ae6b01fabf3b462da607af2534@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mysql.jorge@decimal.pt
X-From: git-owner@vger.kernel.org Sun Dec 27 21:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOzU3-0006C6-2h
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 21:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbZL0UMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 15:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbZL0UMM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 15:12:12 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:40743 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbZL0UMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 15:12:10 -0500
Received: by ewy19 with SMTP id 19so1319160ewy.21
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FVF3T2kKmiF/65w/6z4R94deWj88H0oTX4FrHFmY3Mg=;
        b=LmKlrmeKSZEJF/HzGOTcH+HLrL6cJUeKfLa609+96MqvoYJlU2TZHK+xZ4dEQgTJ3M
         wxBj93UQLdJEmsI2ZtUJaiBSweMU/zWRXBBWJ7CYX1SWHz0xxPEL5W0oNfpQvjYmEaJ0
         /wF3osuB3DouhI3ZF4nbx3APBRKuf7tgYJxNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WyBbbcIA3tio7XSffYQ5a1mLWgDsdb6v9JQB2TYbtkb6kys5BKPsRHcg8wGwm3FLH5
         W0vF+zdDchXW2G6KI+WR2NX2uvVy9md6LVNuoA/LKVS64dVXCnBLPG/trv96ETV1pz7d
         SWhURNCwS2qvgpBje0IYkqYRChSXcO4qkaUc0=
Received: by 10.213.96.6 with SMTP id f6mr11576461ebn.81.1261944729193; Sun, 
	27 Dec 2009 12:12:09 -0800 (PST)
In-Reply-To: <3a9710ae6b01fabf3b462da607af2534@192.168.1.222>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135711>

2009/12/27  <mysql.jorge@decimal.pt>:
>> I'm a using of git for several time, but now I have the need to a gi=
t
>> server.
>> My question, where can get a howto for reallyyyy newbies on git serv=
er?
>
> One question:
>
> I've created a project on the server with:
>
> mkdir project.git
> cd project.git
> git init
>
> -and now locally, created a directory, and cloned this, it said that =
i was
> cloning an empty repo, fine about that.
> -now i added something locally, i get: (locally this is on a windows
> machine with tortoiso git)
>
> --
> git.exe push =A0--tags =A0"origin" master:git://192.168.1.206/project=
s.git
>
> error: src refspec master:git does not match any.
> error: failed to push some refs to 'git://192.168.1.206/projects.git'

=46irstly, I would have a serious look at 'gitosis' for the server end
(there are other similar projects I believe).

Secondly, the push command is wrong. You don't need to supply the
remote URL again... that's what 'origin' is telling the push command,
which remote to use. This would have been established by the original
clone.

Also, again, be careful with 'empty' repositories. (again AFAIK) an
empty repository is just that, it doesn't even have a master branch so
you really need to check out a branch and commit something before
pushing makes much sense. I'm sure this is not 100% correct but you'll
be safe that way!

Howard
