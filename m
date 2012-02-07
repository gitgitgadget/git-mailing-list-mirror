From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: cloning a tree which has detached branch checked out
Date: Tue, 7 Feb 2012 19:57:08 +0700
Message-ID: <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
References: <20120207070628.GA24698@redhat.com> <m362fjklb7.fsf@localhost.localdomain>
 <20120207104100.GA24828@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 13:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukcO-0005vD-0f
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab2BGM5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 07:57:40 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41970 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab2BGM5j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 07:57:39 -0500
Received: by wics10 with SMTP id s10so4874762wic.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rZtEPfHJroaqbgs/e37y06sfqs40MI3BdWjTXAGJ/LU=;
        b=UT8PdGsMx31zdCx8ISOvZ2m2EU7Xp++D8PCQ8g9P6VOdwfbp1eIJ8goeTlgcLrARmv
         f327VAzGEON0Vbx91l3aiyRqfgiE+6BK/SVrTlCQfhBKVuRT4ua8fpshRMZHjyEwLvbF
         OOfQxk54NV2sxQkHYeDtnujEpQ/DXt2ZJnfBk=
Received: by 10.181.13.113 with SMTP id ex17mr33988020wid.15.1328619458563;
 Tue, 07 Feb 2012 04:57:38 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Tue, 7 Feb 2012 04:57:08 -0800 (PST)
In-Reply-To: <20120207104100.GA24828@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190171>

On Tue, Feb 7, 2012 at 5:41 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
>> > #git clone -n lab:/home/mst/scm/linux
>> > ....
>> > error: Trying to write ref HEAD with nonexistant object
>> > cec64082f689f949a397cb9b39423dc41545fa0e
>> > fatal: Cannot update the ref 'HEAD'.
>> >
>> > Looks like a bug, doesn't it?
>>
>> Which git version? =C2=A0IIRC there was some bugfix recently in that
>> area...
>
> Sorry, forgot to mention that. It's pretty recent:
> $ git --version
> git version 1.7.9.111.gf3fb0

The series that Jakub mentioned is probably nd/clone-detached 5ce2b97,
which is already included in your tree. Does 1.7.9 work?

I tried but it was ok for me. I think ref processing at local probably
goes wrong and does not request commit from HEAD.  If the repo is not
confidential, you can zip it and send me.
--=20
Duy
