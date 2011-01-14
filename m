From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <totte.enea@gmail.com>
Subject: Re: weird github capitalization problem
Date: Fri, 14 Jan 2011 16:30:24 +0100
Message-ID: <4D306C10.4000103@gmail.com>
References: <1294146242606-5888573.post@n2.nabble.com> <4D26DA12.50002@futurelab.ch> <4D303D5D.6090108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Stricker <astricker@futurelab.ch>,
	bolfo <boflor@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 14 16:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdlbn-0001Y3-J2
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 16:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680Ab1ANPaa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 10:30:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44919 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757490Ab1ANPa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 10:30:29 -0500
Received: by eye27 with SMTP id 27so1446595eye.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 07:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QwJNX1h7IvHEPc854pca/RG9jIin+zG2LDFSxvvZT0o=;
        b=uMgHMQqmGLU9LXbtYmqGp/ld6AJyPN6sj1x5Y9982CJTUItiSUW6M0TLAWnFEgmQrd
         g9+JvY3hoBvt92fWqXe70x/NTlkSt4avOgRC5pfsH7gZEXw0eCYH9Z1ElYfS6QXXBpRa
         vrSXag58J3XWt103I/Q/4lJW+aLESJh3ur2uI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=GhAo/Svww7VOHrGcAAcEIB9wsnImEp0OD5CgBJubZkkDC6QEOlrPtb11ScMoJUj6eM
         5eddKoG5DzcPWZAJMiCrhQMsI8rqbUlx3LkLy6tEuNc8uiZNV0/1HVAZbzvja2YWPlnl
         Fnh3TsMgTZjIsxXgZd/pdhMZjfLohH8p6j1ck=
Received: by 10.213.23.12 with SMTP id p12mr851483ebb.50.1295019027732;
        Fri, 14 Jan 2011 07:30:27 -0800 (PST)
Received: from birne.lan (h195n4fls31o954.telia.com [213.64.3.195])
        by mx.google.com with ESMTPS id b52sm1027310eei.7.2011.01.14.07.30.25
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 07:30:26 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D303D5D.6090108@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165106>

On 14.01.11 13:11, Torsten B=F6gershausen wrote:
> On 07.01.11 10:17, Andreas Stricker wrote:
>> Am 04.01.11 14:04, schrieb bolfo:
>>> I first installed everything on my laptop, coded some stuff and the=
n
>>> pushed
>>> to github. Apparently something went wrong because there was a new
>>> directory, while at first the directory was OurProjectsources, ther=
e
>>> now was
>>> a new directory called OurProjectSources. Weird since my local
>>> directory has
>>> the s not capitalized.
>>
>>> I work on a windows PC while the original author works on a Mac,
>>> could this
>>> be the problem?
>>
>> Yes, Mac OSX HFS+ filesystem ignores the case by default (you'll nee=
d
>> to reformat to change this). So OurProjectSources and OurProjectsour=
ces
>> both refers to the same directory on Mac OS X. On Linux there are tw=
o
>> different directories
>>
>> This frequently causes issues here too. An example:
>>
>> me@mac:t $ git init r
>> Initialized empty Git repository in /private/tmp/t/r/.git/
>> me@mac:r (master) $ mkdir OurProjectsources
>> me@mac:r (master) $ touch OurProjectsources/a
>> me@mac:r (master) $ git add OurProjectsources/a
>> me@mac:r (master) $ git commit -m "initial import"
>> [master (root-commit) c2cb2f3] initial import
>> 0 files changed, 0 insertions(+), 0 deletions(-)
>> create mode 100644 OurProjectsources/a
>> me@mac:r (master) $ mv OurProjectsources/ OurProjectSources
>> me@mac:r (master) $ touch OurProjectSources/b
>> me@mac:r (master) $ git add OurProjectSources/b
>> me@mac:r (master) $ git commit -m "added b"
>> [master 4de780c] added b
>> 0 files changed, 0 insertions(+), 0 deletions(-)
>> create mode 100644 OurProjectSources/b
>> me@mac:r (master) $ git stat
>> # On branch master
>> nothing to commit (working directory clean)
>> me@mac:r (master) $ scp -r .git linux:t.git
>> me@mac:r (master) $ ssh linux
>>
>> me@linux:~ $ git clone t.git/
>> Initialized empty Git repository in /home/me/t/.git/
>> me@linux:~ $ cd t
>> me@linux:~/t $ ls
>> OurProjectsources OurProjectSources
>> me@linux:~/t $ find *
>> OurProjectsources
>> OurProjectsources/a
>> OurProjectSources
>> OurProjectSources/b
>>
>> And there it is, our mess. The mac user accidentally created
>> two different directories but didn't see them.
>>
>> ~/Andy
>>
>
> The following is on next from git.git:
> (And more commits fixing more core.ignorecase issues)
> You might give it a try.
> HTH
> /Torsten
>
>
>
> commit 50906e04e8f48215b0b09841686709b92a2ab2e4
> Author: Joshua Jensen <jjensen@workspacewhiz.com>
> Date: Sun Oct 3 09:56:46 2010 +0000
>
> Support case folding in git fast-import when core.ignorecase=3Dtrue
>
> When core.ignorecase=3Dtrue, imported file paths will be folded to ma=
tch
> existing directory case.
>
> Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
Hm,
that didn't work.

See the test on my linux box, after the clone:


config core.ignorecase true && rm -rf * && git reset --hard && ls && gi=
t=20
config core.ignorecase
HEAD is now at 2dac314 Added b
OurProjectsources  OurProjectSources
true


  git --version
git version 1.7.2.1.105.g50906

More work seems to be needed, sorry for the noise.
/Torsten
