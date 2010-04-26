From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] git shortlog hangs in bare repo
Date: Mon, 26 Apr 2010 14:03:22 -0400
Message-ID: <n2i76c5b8581004261103k287ce0fax7b3a511dbb72c95b@mail.gmail.com>
References: <u2i76c5b8581004221222ge8bb0b8cp55cb1f13d5f9692a@mail.gmail.com>
	 <20100425215042.GA25547@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 20:03:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Sey-0007uy-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab0DZSDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 14:03:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61054 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0DZSDY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 14:03:24 -0400
Received: by vws13 with SMTP id 13so36281vws.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QQ4R6Q3altwMCjlByHgOKoYw7fmCbopjMhtFTp8H2Ac=;
        b=hZ2Zacx/wsJbWhwErv6QPdhWHTxpvWF8vQxIod1a+QDDNXlgqWYjwVE0ZIVsz62gv8
         IHUvgU3c1oYvjvTKddpn1eXuj9FVnlnOVUlG4uAhXA7il0drokefqHRIEj9qNw0Cs3ws
         u5r7kZyT9iAB+0HWIcoJVZfafd3kPiYSg0IRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Elwf1WdnloCIeRUCf7CmWIAWP1DnJOCvzP7pDDK6AAMuVkFTPODm5Ko2B0uI0C7EIe
         nXq0ubJ0Yi8NVYiMhcAccMuaOvnRMLrLHHI/NYLwCXjkf+RhNMPJoC8NDD+ySRVJc+d/
         GlDGyHOUv/kK98KoUmSMdJ6A58qlf/5ADgvDw=
Received: by 10.229.222.12 with SMTP id ie12mr1199909qcb.77.1272305002980; 
	Mon, 26 Apr 2010 11:03:22 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Mon, 26 Apr 2010 11:03:22 -0700 (PDT)
In-Reply-To: <20100425215042.GA25547@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145836>

On Sun, Apr 25, 2010 at 5:50 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Eugene,
>
> Eugene Sajine wrote:
>
>> I have tried to run this command in order to get some stats from the
>> mainline bare repo. The result is that "shortlog" hangs for long
>> period of time and nothing happens. At the same time git log works O=
K.
>
> I=E2=80=99m a big shortlog fan, too, but I should mention a certain p=
erformance
> characteristic: to sort its results by author, it has to build the wh=
ole
> log before it can print anything to standard output at all. =C2=A0git=
 log,
> on the other hand, starts printing the most pertinent output right aw=
ay.
>
> Not sure that=E2=80=99s the problem, but thought I should mention it.
>
> It would be nice to know what git version you are using, to be able t=
o
> check for relevant differences between your setup and mine.
>
> Thanks for the report,
> Jonathan
>
> The most interesting recent change I could find is in v1.7.1-rc0~85^2
> (shortlog: warn the user when there is no input, 2010-02-24). =C2=A0T=
hat is
> for the no-repository case rather than the bare-repository one.
>
Hi,

This is happening in Git 1.6.5.6.
The case here is that for the same project (same repo) in bare
shortlog is not working, in non-bare it is working instantaneously.

Thanks,
Eugene
