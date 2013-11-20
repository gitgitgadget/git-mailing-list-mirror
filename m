From: Benjamin Pabst <benjamin.pabst85@gmail.com>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Wed, 20 Nov 2013 23:10:47 +0100
Message-ID: <CAM-uYMiLpsQdN41Gs8iJOT-v0qKgod2vEeoC3C+QJ5+wKiVK-Q@mail.gmail.com>
References: <CAM-uYMgy8duxdGY8rbCJv9To3FFMAUDv22nnzbQ+e3QrTCLLpQ@mail.gmail.com>
	<CAM-uYMigCTK=j3HkyT0F=jtDoDERdtkpZiTXRvBhSHJW3edJ-w@mail.gmail.com>
	<CAM-uYMiK4wkQyGJLemSAbNwHJNoH-k8Zv0W2yBtnTCbsFLj8Fg@mail.gmail.com>
	<5285CE6C.2030609@futurelab.ch>
	<CAM-uYMgn4SGqurqRG-RDiicLxpf9NfTPUvNn9FaFUUbxFRJsZw@mail.gmail.com>
	<5286235D.9060602@futurelab.ch>
	<20131115225316.GF27781@google.com>
	<52894951.7000303@futurelab.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 23:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjFzA-0004mE-Ep
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 23:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab3KTWKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 17:10:50 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:53411 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab3KTWKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 17:10:47 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so3048309qac.14
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 14:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=bHIEYICqGJeccRfzcJUyp6KTlU1VcLOVLjR1/v6clvw=;
        b=Hqd5XM+9yR63jxQcSlGLhD+B0JsNf4PgF0Li9xzZiLoI9IkPhLDEWi299YwNQmH9V9
         1eNNkLPDedZAG1ESLf2eAPo2VKJSyVQIr/7FxYQ4M6OQHNbc4q3rWPnbNHjq4Rfy9F0e
         CwszFR9qdYXTLUO3WrcmRS8SAOpJnhTS3vqKZ6jZipTQsqdFPziBAlfcVqkmM2N5ihsg
         76Lz/pwL5UgFVSAb8oLZ2qTogyBDUXIBrS5tMrbH5LRZVRrI5shBW8+EpQqzh/TTmxZi
         S/MeCe4PnnTvi3Xiz6km0igUUgCZm4ijJzEXyGhPE8GjOlBKSs7AzzD6CoiuOVIo5/sa
         FBKQ==
X-Received: by 10.49.127.205 with SMTP id ni13mr3886015qeb.40.1384985447333;
 Wed, 20 Nov 2013 14:10:47 -0800 (PST)
Received: by 10.140.84.104 with HTTP; Wed, 20 Nov 2013 14:10:47 -0800 (PST)
In-Reply-To: <52894951.7000303@futurelab.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238100>

Hi,

is it possible to debug git-svn or get a more verbose / debug output
from it? I already tried with the "GIT_TRACE" variable, but it does
not include any further output on the svn methods.

Regards, Benjamin

2013/11/17 Andreas Stricker <astricker@futurelab.ch>:
> Hi Jonathan
>
>> Can you give an exact sequence of steps (including "Upgrade Subversion
>> at this step") to reproduce the problem?  That would help immensely
>> --- if at all possible, I would very much like to keep existing
>> git-svn repos working on upgrade.
>
> Of course. I've attached a text file with the commands required to
> reproduce this error.
>
> From my experiments it looks like after the subversion is upgraded
> to 1.8 the problem only occurs if "git svn fetch" fetches new changes
> from the subversion repository. Without changes in upstream subversion
> repository I couldn't reproduce the error. And a rename is required too.
>
> Hope this helps.
>
> Regards, Andy
