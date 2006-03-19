From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Sun, 19 Mar 2006 14:25:21 +0100
Message-ID: <4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 19 14:25:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKxuc-00010f-NA
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 14:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWCSNZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 08:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWCSNZ1
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 08:25:27 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:1171 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751496AbWCSNZ0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 08:25:26 -0500
Received: by xproxy.gmail.com with SMTP id s19so690239wxc
        for <git@vger.kernel.org>; Sun, 19 Mar 2006 05:25:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sLERuT0LI9oOZZLcvUu096ldZArnBbzYm5OjRvBbDY38KQEpDEyvqWkCXB87qFeHkJUl0S+lemP8y8f+OrBqfSPRuhwh5IqzwXj2sUGGbsxhpkKuAhC0a2NAAI83QHmuKPuUy2IDBNm/bHSx2NaqboJHkXsmHDJ9tEdtOxV4LO8=
Received: by 10.70.125.3 with SMTP id x3mr1028636wxc;
        Sun, 19 Mar 2006 05:25:21 -0800 (PST)
Received: by 10.70.69.16 with HTTP; Sun, 19 Mar 2006 05:25:21 -0800 (PST)
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17714>

On 3/19/06, Marco Costalba <mcostalba@gmail.com> wrote:
> Hi all,

Ciao Marco,

>     I have set a git repository on a hosted public site:
> http://digilander.libero.it/mcostalba/scm/qgit.git
>
> I cannot run any process (read git-daemon) on that site, so git-clone uses
> a 'dumb server' type protocol and this is what I got.
>
> $ git clone http://digilander.libero.it/mcostalba/scm/qgit.git
> error: File 8dea03519e75f47da91108330dde3043defddd60
> (http://digilander.libero.it/mcostalba/scm/qgit.git/objects/8d/ea03519e75f47da91108330dde3043defddd60)
> corrupt
> Getting pack list for http://digilander.libero.it/mcostalba/scm/qgit.git/
> Getting index for pack fe1f3586b38e70e963de47f31379ef170adc5ca9
> Getting pack fe1f3586b38e70e963de47f31379ef170adc5ca9
>  which contains 8dea03519e75f47da91108330dde3043defddd60
> walk 8dea03519e75f47da91108330dde3043defddd60
> walk ec47dab590fb838ba2be7af5bf9aa46d9f2e502d
>
> -------------- cut ------------------------
>
> walk 907d47e836f4f174386d02d21e38aeafc1e79626
> walk 5d3454248bbb3aaba080057dc9666a3c3aaeca1f
> $
>
> The above mentioned error belongs to git requests a non existing object
> (8dea03519e75f47da91108330dde3043defddd60) _and_  the site answers with
> a pre-canned 'page not found' html page instead of reporting 404 error.
>
> After some research I found it is quite common for public hosting
> sites to use a pre-canned
> 'Sorry, no page here' html stuff instead of 404.
>
> So my request is if it is possible for git to _learn_ this and to
> avoid been fooled by
> these kind of public sites.
>

How about getting an account on kernel.org?

Anyway, here is what I did:
paolo@Italia:~$ cg-clone
http://digilander.libero.it/mcostalba/scm/qgit.git qgit defaulting to
local storage area
Fetching head...
Fetching objects...
error: File 8dea03519e75f47da91108330dde3043defddd60
(http://digilander.libero.i
t/mcostalba/scm/qgit.git/objects/8d/ea03519e75f47da91108330dde3043defddd60)
corr upt

Getting pack list for http://digilander.libero.it/mcostalba/scm/qgit.git/
Getting index for pack fe1f3586b38e70e963de47f31379ef170adc5ca9
Getting pack fe1f3586b38e70e963de47f31379ef170adc5ca9
 which contains 8dea03519e75f47da91108330dde3043defddd60
Fetching tags...
Missing tag qgit-0.93... retrieved
Missing tag qgit-0.94... retrieved
Missing tag qgit-0.94.1... retrieved
Missing tag qgit-0.95.1... retrieved
Missing tag qgit-0.96... retrieved
Missing tag qgit-0.96.1... retrieved
Missing tag qgit-0.97... retrieved
Missing tag qgit-0.97.1... retrieved
Missing tag qgit-0.97.2... retrieved
Missing tag qgit-1.0... retrieved
Missing tag qgit-1.1rc1... retrieved
Missing tag qgit-1.1rc3... retrieved
New branch: 8dea03519e75f47da91108330dde3043defddd60
Cloned to qgit/ (origin
http://digilander.libero.it/mcostalba/scm/qgit.git available as branch
"origin")


Why am I getting this error?
error: File 8dea03519e75f47da91108330dde3043defddd60
(http://digilander.libero.i
t/mcostalba/scm/qgit.git/objects/8d/ea03519e75f47da91108330dde3043defddd60)
corr upt


--
Paolo
http://paolociarrocchi.googlepages.com
