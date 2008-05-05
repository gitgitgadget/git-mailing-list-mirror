From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Pay attention to GIT_DIR when searching the git directory
Date: Mon, 5 May 2008 18:48:31 +0200
Message-ID: <200805051848.32216.jnareb@gmail.com>
References: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de> <m3r6cg6dur.fsf@localhost.localdomain> <20080505153029.GA12733@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?q?J=C3=B6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon May 05 18:49:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3sX-0003Ej-7v
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbYEEQsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 12:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbYEEQsl
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:48:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:58191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbYEEQsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:48:40 -0400
Received: by ug-out-1314.google.com with SMTP id h2so98491ugf.16
        for <git@vger.kernel.org>; Mon, 05 May 2008 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=mqeq3ywREcDJyyCd48mNOtegMWEzLMawv2CpzX+4FHw=;
        b=ePCBYQpWBVMGBJnmLCXR4hPG2z+2Wp/ET4tscjY+6b+0fZ/ZR2KN/HfLS+vV8b+LW1Z6SRXsUPYvcLUmxssID8Df+imhF16/nmqv2CP2a/psqirv5BZ1VqauqpRUA8Tp+LChXQPuGtJyQYCL9nHtwUqqQxo2WUOKkfOizMM8f0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f0BtOhdAo/IESmsF2fs/T9WdzjOiT5a0jyAXxEdM78Goxs60SItF+kuTm3z49Jb9IGUZRa3IBmayU+nWFOGw7K5dykiZOvU24K0O2YhrJFu1O5N6qTA8ExtEs8O/E76LFO1oJMIh4B+xJtfca5ISoqgfxny/mgJIFSDnj/WUGwA=
Received: by 10.67.97.15 with SMTP id z15mr3918512ugl.26.1210006119178;
        Mon, 05 May 2008 09:48:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.199.6])
        by mx.google.com with ESMTPS id q1sm7984077uge.7.2008.05.05.09.48.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 May 2008 09:48:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080505153029.GA12733@alea.gnuu.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81299>

On Mon, 5. May 2008, J=C3=B6rg Sommer wrote:
> Hi Jakub,
>=20
> Jakub Narebski schrieb am Mon 05. May, 07:10 (-0700):
>> J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:
>>> Johannes Schindelin schrieb am Mon 05. May, 12:36 (+0100):
>>=20
>>>> If you do not say _what_ is affected by the change, you only confu=
se
>>>> the readers.
>>>=20
>>> Do you want something like =E2=80=9Cinitialization: Pay attention t=
o GIT_DIR when
>>> searching the git directory=E2=80=9D?
>>=20
>> I think the idea was to use
>>   "contrib/hooks/setgitperms: Use GIT_DIR if set"
>> or something like that.
>=20
> Well, if this is the prefered form, I'll use it. But I don't like it,
> because the affected file is a piece of information that's already in=
 the
> commit object.=20

=46irst, it is "subsystem", not the affected file. 'git-svn', 'gitweb',
'bash', 'completion'; in this case perhaps 'contrib/hooks', i.e.
  "contrib/hooks: Use GIT_DIR in setgitperms hook, if set"
or something like that.  IMVHO if a patch affest specific subsystem
only, and not the core part of git, you should always use subsystem
prefix, unless the name of subsystem can be put / is put in the commit
subject (first line of commit message).

Second, commit message should be written in such way that it is easy to
understand what the commit does from the first line (the commit summary=
),
and easy to understand the whats and whys of change from the full commi=
t
message.  In "git log" output you don't see files affected by a commit.

> And it makes the :/ syntax useless, because in a series of=20
> commits all commits start with the same string: the filename.

Commits affecting core don't need to start with a filename, dirname,
or subsystem name.  I gave an example _without_ prefix, didn't I?

[...]
>>> Is there a document with guidelines for commit messages, e.g. write=
 the
>>> first letter upper or lower case?
>>=20
>> There are a few unwritten conventions.
>=20
> Are there any plans to write them down?

I think it is true for every project that to send good commit you have
to lurk a little, and examine existing commit messages when writting
one.  Linus Torvalds usually writes good commit messages here.

--=20
Jakub Narebski
Poland
