From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Re: [PATCH] Support wrapping commit messages when you read them
Date: Mon, 20 Feb 2012 16:09:25 -0500
Message-ID: <5171724E-AAE9-4419-9D0F-C09FB8048488@sidneysm.com>
References: <8DE6E894-B50D-4F7E-AE18-C10E7E40A550@sidneysm.com> <7vfwg99dom.fsf@alter.siamese.dyndns.org> <46957CEB-5E48-4C11-8428-9A88C3810548@sidneysm.com> <7vzkcmbcbq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 22:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzaUH-0004rj-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 22:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab2BTVJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 16:09:29 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48887 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab2BTVJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 16:09:28 -0500
Received: by qadc10 with SMTP id c10so3629805qad.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 13:09:27 -0800 (PST)
Received-SPF: pass (google.com: domain of s@sidneysm.com designates 10.229.76.204 as permitted sender) client-ip=10.229.76.204;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of s@sidneysm.com designates 10.229.76.204 as permitted sender) smtp.mail=s@sidneysm.com; dkim=pass header.i=s@sidneysm.com
Received: from mr.google.com ([10.229.76.204])
        by 10.229.76.204 with SMTP id d12mr16822920qck.156.1329772167720 (num_hops = 1);
        Mon, 20 Feb 2012 13:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=i+K1adZtfOHF6f5fesboEyg8k5IiBWP/T0DrMf5cB4Q=;
        b=RYgplQMbyXz3nkgoFogfRjhdTT4QL5+rv5BH4LZLJ1BnEHLXpGOWbcGMHDT3406NLo
         FwgK5gttPzQCaOSIrILhVY3O5Vhjeo+qA9JgRMkLwvSfr88xzYBSS/GfGv7FUFKM4DB2
         HEXfU2TXx7J51CucZyxZq/3h4cjw7x96BSQis=
Received: by 10.229.76.204 with SMTP id d12mr14313752qck.156.1329772167517;
        Mon, 20 Feb 2012 13:09:27 -0800 (PST)
Received: from [10.66.81.18] (h-64-236-128-13.nat.aol.com. [64.236.128.13])
        by mx.google.com with ESMTPS id eo4sm52521668qab.16.2012.02.20.13.09.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Feb 2012 13:09:26 -0800 (PST)
In-Reply-To: <7vzkcmbcbq.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
X-Gm-Message-State: ALoCoQkzSoWmR3Jix36DZZIUIAsNidV6PDmj7/cf6Gl3I9wp9fXJcXJTunt9jSxXsOdythWNtI2s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191105>

On Feb 13, 2012, at 5:25 PM, Junio C Hamano wrote:

> I just typed M-q to wrap the above paragraph from you to make it read=
able.

Out of curiosity, how do you read your mail? I don=92t know anyone whos=
e mail
is set up like that.

I=92m happy to wrap my text if it=92s tricky for you to read it otherwi=
se =97 but
=46WIW my mail client doesn=92t support hard wrapping (I=92m doing it i=
n my editor).

> "Computers are good at automating" is true, and that is why real edit=
ors
> give an easy way to auto-wrap long prose in a paragraph while composi=
ng.
> But "computers are good at automating" is not a convincing justificat=
ion
> to let the composer leave unreasonably long lines in the commit log o=
bject
> and force the reader side to line-wrap the mess only to fix it up.

I asked in #git how other people handle wrapping. Out of three people w=
ho
responded, only one said that they had configured their editor (the oth=
er two
do it by hand). One thought that Git already did dumb (character-level)=
 line
wrapping, but it turns out he had set LESS=3D and GIT_PAGER=3D'less -FR=
X'.

So, even if it is possible to set up your editor to wrap prose appropri=
ately,
I don=92t think it=92s as common as one might hope.

I=92m not suggesting that the reader side should take care of the wrapp=
ing
because it *can*, I=92m suggesting that it shouldn=92t take specially-c=
onfigured
editors to get consistent and good results =97 which I assume is why vi=
rtually
all new prose-writing tools do wrapping on the viewing end.

What do you think about Git UIs which use proportional fonts for text w=
here
hard wrapping doesn=92t work at all? (I brought this up before but want=
 your
take on it).

And, using man and, now, "git help -a" as examples: they both adapt the=
ir
output to the width of the user=92s terminal. Isn=92t that a good thing=
?

If those aren=92t good justification=85 what would be?