From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 14/14] Add README and gitignore file for MSVC build
Date: Mon, 7 Sep 2009 14:26:48 +0200
Message-ID: <40aa078e0909070526x479dc769v39d6bbaf27a401a9@mail.gmail.com>
References: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
	 <6dd71f163e5410e401fc66088405736d1978ec55.1250860247.git.mstormo@gmail.com>
	 <cover.1250860247.git.mstormo@gmail.com>
	 <54673ddb6bef681194e141e5e05e930cdfaa07bc.1250860247.git.mstormo@gmail.com>
	 <e82f1930173966ebb6b2d2815e037a26e079f969.1250860247.git.mstormo@gmail.com>
	 <a4c8a6d00908230926of0ea10bhd8f66e7d37c3b39b@mail.gmail.com>
	 <3f4fd2640908231122m34604196pc98c5871cf5925b5@mail.gmail.com>
	 <4A91917F.9000709@gmail.com>
	 <a4c8a6d00908231229v56eceeddue1b927a4e4e49ee3@mail.gmail.com>
	 <1976ea660908250732q1e1fc153g663f3a9c13f1c902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thiago Farina <tfransosi@gmail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 14:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkdJB-000477-Ct
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 14:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbZIGM0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 08:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbZIGM0r
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 08:26:47 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62793 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZIGM0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 08:26:46 -0400
Received: by bwz19 with SMTP id 19so1535954bwz.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=puAVF/9aRHuazwWvVO+rrRkH7soIw3dXHvDz3SzgFac=;
        b=tVh69T80yndex3Q2Vf8HYKIsRC7edfNsjWZFxlMQVkVfE8y2eeDVvdA6SBSqmL9RAz
         tDbJDOV4qKYZ/j+M14ZJNy8fbnCmF++7PP8OyF+5x8Iq+orJAkhow9c3smFTESw0Yjui
         1ZNx7aakt9Qkyfd0ETA+oXD6GGD2rPjoEaw+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bV8YTAmPT6YnumOkncOIdBk8BV1HqpQarIzeT5790irn91wrrMzMTeiIsGctUx+7wG
         FihcMEYMFoEfPP7GZC3ZcosP7fV7YiQpddny7u/GM//8fQt2p2qy8PC0BFuKjq3gS+c+
         dQ42WwQ5egOFjvyW63VYl5eVidJaxfGYKMqqg=
Received: by 10.204.19.144 with SMTP id a16mr11970868bkb.9.1252326408249; Mon, 
	07 Sep 2009 05:26:48 -0700 (PDT)
In-Reply-To: <1976ea660908250732q1e1fc153g663f3a9c13f1c902@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127922>

On Tue, Aug 25, 2009 at 4:32 PM, Frank Li<lznuaa@gmail.com> wrote:
> I update http://repo.or.cz/w/gitbuild.git.
> Add create_command.bat to create common-cmds.h.

I just gave this script a try, but if I simply click the .bat-file, I
get the following crash in sh.exe: "Unhandled exception at 0x77ba8e7c
in sh.exe: 0xC0000005: Access violation writing location 0x00000014."

Here's the output I get on the console:

--->8---

C:\Users\Erik\src\git-msvc\gitbuild>setlocal

C:\Users\Erik\src\git-msvc\gitbuild>set tools=C:\Users\Erik\src\git-msvc\gitbuil
d\tools

C:\Users\Erik\src\git-msvc\gitbuild>echo C:\Users\Erik\src\git-msvc\gitbuild\too
ls
C:\Users\Erik\src\git-msvc\gitbuild\tools

C:\Users\Erik\src\git-msvc\gitbuild>set path=C:\Users\Erik\src\git-msvc\gitbuild
\tools

C:\Users\Erik\src\git-msvc\gitbuild>cd ext\git

C:\Users\Erik\src\git-msvc\gitbuild\ext\git>sh generate-cmdlist.sh  1>common-cmd
s.h

abnormal program termination

--->8---

Since the path is set to only point to the tools, my guess is that
other msys installations (I've got two) shouldn't affect this, no?

I'm running Vista 64bit.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
