From: Wink Saville <wink@saville.com>
Subject: Re: asciidoc 8
Date: Mon, 18 Feb 2008 09:37:27 -0800
Message-ID: <47B9C257.5050109@saville.com>
References: <47B8CFFF.6090902@saville.com> <54BC65FA-F388-458F-9610-76B7C1413AD3@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR9wN-0005cO-03
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbYBRRhc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 12:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYBRRhb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:37:31 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:37859 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbYBRRha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:37:30 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1331644rvb.1
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 09:37:29 -0800 (PST)
Received: by 10.141.20.7 with SMTP id x7mr3990696rvi.207.1203356249730;
        Mon, 18 Feb 2008 09:37:29 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id b39sm9888458rvf.8.2008.02.18.09.37.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Feb 2008 09:37:28 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <54BC65FA-F388-458F-9610-76B7C1413AD3@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74319>

Wincent Colaiuta wrote:
> El 18/2/2008, a las 1:23, Wink Saville escribi=F3:
>
>> I ran into the asciidoc 8 issue where some of the docs don't
>> get generated properly on my system with asciidoc 8.2.1.
>>
>> Should I just downgrade? What would be the "best" version
>> to use.
>
> I ran into problems with 8 a while ago, poked around for a while,=20
> couldn't find the cause of the problem, and so downgraded to the 7=20
> series (don't recall the exact version, but it was the last release i=
n=20
> the 7 series). I figured this was just the simplest thing to do seein=
g=20
> as the official manual page archives are generated with 7, as far as =
I=20
> know.
>
> I know that later a fix for the breakage that I was seeing was checke=
d=20
> in (see 5162e69), so in theory 8 should be fine now (at least, the=20
> latest version of it, but I see you're using an older version which=20
> probably isn't affected by the link problem). What problem are you=20
> seeing? What version of Git are you using?
>
> Cheers,
> Wincent
>
>
>
I'm seeing the missing "+" problem which, after reading INSTALL, was=20
fixed by adding
ASCIIDOC8=3DYesPlease to my command line. But after doing that I was st=
ill=20
seeing .ft C like
this:

           .ft C
                   URL: one of the above URL format
                   Push: <refspec>
                   Pull: <refspec>

           .ft

where "<pre>" blocks in the html documentation show up. I was first=20
seeing the problems
with git 1.5.4 and then yesterday built 1.5.4.2 and still have the abov=
e=20
problem.

Wink Saville
