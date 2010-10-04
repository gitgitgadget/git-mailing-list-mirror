From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Useful tracking branches and auto merging
Date: Mon, 4 Oct 2010 23:56:02 +0300
Message-ID: <AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
	<20101004204625.GH6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 22:56:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2s5C-00034N-9f
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab0JDU4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 16:56:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55412 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160Ab0JDU4E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 16:56:04 -0400
Received: by bwz11 with SMTP id 11so3997913bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y/4PdAzR5r3hAzFqn+XxauBWqstdL6wKDx9VJzrtZhg=;
        b=x9mdLi2ky1368/WOge5OaHEQOj/ss/nw9m/NW4pK5f03HGrU82Y3MfwWnPhvJH8SND
         5EOhR6B9ZJOUhbS4Q+omQOItLPQgV5iKqRb+AAi8hSTaUzJUa9I7r1MetxOXW24pjQbR
         DsDXGe7pYeIqJkRLzF7cRUTGUI/Pi3SeB4lJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vsKjMlWWj7n+qU8azJpTO9uaAYlvPzMXQjmE8y4LkPHsGdzW4GFGXwtBiIraRat/vv
         bwu0mSZzQxEY9KP5pCC6vwt7f0oClnNF64XzrJowf4IA+lZx7/wzOQm9jY6NH+UoJ+Fu
         OmUDXPFXaTW0j5Cg/GF9RH/Pmj1dNOVfsjNcI=
Received: by 10.204.131.209 with SMTP id y17mr7733764bks.32.1286225762642;
 Mon, 04 Oct 2010 13:56:02 -0700 (PDT)
Received: by 10.204.152.142 with HTTP; Mon, 4 Oct 2010 13:56:02 -0700 (PDT)
In-Reply-To: <20101004204625.GH6466@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158114>

On Mon, Oct 4, 2010 at 11:46 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>> =C2=A0Your branch is behind 'origin/master' by 17 commits, and can b=
e fast-forwarded.
>>
>> This message doesn't tell me _how_ I can 'fast-forward', I do 'git
>> merge origin/master' but if git already knows 'master' is tracking
>> 'origin/master' why should I specify that? Perhaps 'git merge
>> --tracking'.
>
> git merge @{u}

Interesting, I don't find anything like that in the documentation.
Moreover, wouldn't it make sense to make 'git merge' =3D 'git merge
@{u}'?

>> But, while we are on that, why not automatically merge the tracking
>> branches?
>
> Maybe 'git pull --all' could be taught to eventually do this? =C2=A0T=
hat
> would be incompatible with its current behavior of fetching everythin=
g
> and merging some random branch, but I don't think anyone is relying
> on that.

Maybe, I feel 'git pull' is for single branches or repos, whereas 'git
remote update' is pretty clear it's for all the repos, so if some
merging is to be done for all the repos, it should be some form of
'git remote', no?

--=20
=46elipe Contreras
