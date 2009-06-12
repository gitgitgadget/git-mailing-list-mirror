From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: EasyGit Integration
Date: Sat, 13 Jun 2009 00:05:19 +0200
Message-ID: <200906130005.20790.jnareb@gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <200906122321.57479.jnareb@gmail.com> <94a0d4530906121448m57f272eej32e8d57e48002f1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:06:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFEt0-0005KY-Ek
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 00:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765143AbZFLWFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 18:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbZFLWFV
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 18:05:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:12527 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934215AbZFLWFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 18:05:19 -0400
Received: by fg-out-1718.google.com with SMTP id d23so41807fga.17
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=P6RNevHvl+evYVrCd9CDbq/fyb3yfNE3zKcOSmGt1Nc=;
        b=HbdXWdLcuLEC+GYTZzKi7vi4D7avkrG3a/fzqiKO23sJYlkyVsx6nVcMBk66+EE/sG
         dUs7KEXhJkNV5CUb9WL/4uG3t8MmlhAvkQ1UEqyr1S1gwtPoLjav89Ez9YgiJpUX7zA8
         Yvs9QeYZjyr6IjKcXghAUjkT1zW88MENPhCMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BfuykM8a4hpc5Wl1XCFxQw/E+nIgtyrm8P1CBoeYpS3rspSel3ey6W4zQhI4ohP3QU
         r/MJJhg/NAFeLNEd5nFGXXsYNaQZBycnU8JM/Y2M9jokyrw38wQFZPf5qHT/xp4keVpa
         fHdGRMVzjcQJ8GgXEAQ5ctN/pxVm+44KDTO+c=
Received: by 10.86.36.11 with SMTP id j11mr4401713fgj.22.1244844321047;
        Fri, 12 Jun 2009 15:05:21 -0700 (PDT)
Received: from ?192.168.1.13? (abwe201.neoplus.adsl.tpnet.pl [83.8.228.201])
        by mx.google.com with ESMTPS id d6sm5245920fga.22.2009.06.12.15.05.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Jun 2009 15:05:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530906121448m57f272eej32e8d57e48002f1f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121455>

On Fri, 12 Jun 2009, Felipe Contreras wrote:
> On Sat, Jun 13, 2009 at 12:21 AM, Jakub Narebski<jnareb@gmail.com> wr=
ote:

>> Nope. 'git reset' always reset some part of state to a given commit,
>> HEAD by default. =C2=A0It can reset current branch with --soft, bran=
ch plus
>> index with --mixed (default), and branch plus index plus working
>> directory with --hard. =C2=A0Source is always commit.
>=20
> You said it: 'git reset --hard' gets something out of the repository
> and into the working directory.
>=20
> Try this:
> git checkout <random sha-1 with no ref>
>=20
> Then what is the difference between:
> git checkout HEAD^
> git reset --hard HEAD^
>=20
> In this case they do exactly the same thing, don't they?

No, they don't.  "git checkout HEAD^" modifies HEAD detaching it.
"git reset --hard HEAD^" modifies branch that HEAD points to (well,
unless HEAD is detached).

--=20
Jakub Narebski
Poland
