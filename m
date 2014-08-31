From: Bostjan Skufca <bostjan@a2o.si>
Subject: Re: Configurable filename for what is now .gitignore
Date: Sun, 31 Aug 2014 03:55:48 +0200
Message-ID: <CAEp_DRATLprK9LZg45dn5LY=3C8cLM1BNg4rmi0XxJmdPhDGBw@mail.gmail.com>
References: <CAEp_DRDCQqkwL1N-PemLtOvPEv-xfBW4MatAOomwi+my9QeK8g@mail.gmail.com>
	<20140830054312.GA28512@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 03:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNuN9-0002yg-5i
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 03:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbaHaBzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 21:55:55 -0400
Received: from portkey.s.itsis.si ([78.47.12.76]:41057 "EHLO
	portkey.s.itsis.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaHaBzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 21:55:54 -0400
Received: from undisclosed (undisclosed [127.0.0.254]) (Authenticated sender: undisclosed) by portkey.s.itsis.si (Postfix) with ESMTPSA id 8381880051
	for <git@vger.kernel.org>; Sun, 31 Aug 2014 01:55:50 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.98.4 at portkey
Received: by mail-ig0-f171.google.com with SMTP id l13so11338455iga.16
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 18:55:48 -0700 (PDT)
X-Received: by 10.50.25.41 with SMTP id z9mr13245259igf.0.1409450148499; Sat,
 30 Aug 2014 18:55:48 -0700 (PDT)
Received: by 10.50.218.174 with HTTP; Sat, 30 Aug 2014 18:55:48 -0700 (PDT)
In-Reply-To: <20140830054312.GA28512@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256275>

Hi Jonathan,

nope, haven't seen zit before, it does partly what I would need, but
just for one file at a time (a "bit" awkward) and not really portable
(git clone will not clone .FILE.git/exclude, for example).

Anyway, do you think that a patch which makes .gitignore filename
configurable would be appropriate for inclusion in future git
releases?

b.



On 30 August 2014 07:43, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Bostjan Skufca wrote:
>
>> Git is great for tracking code development, but when deploying
>> mentioned code by using git itself, various configuration files must
>> be created additionally, which are normally .gitignored, for various
>> reasons (code portability, sensitive data, etc). There is currently no
>> simple way of tracking changes to those critical configuration files
>> (at least none that I am aware of).
>>
>> One way to approach this would be tracking those changes in separate
>> git repository.
>
> Have you seen zit
> <https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Zit>?
>
> Curious,
> Jonathan
