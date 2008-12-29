From: "Zorba" <cr@altmore.co.uk>
Subject: Re: turn off "LF will be replaced by CRLF" thingy
Date: Mon, 29 Dec 2008 16:18:23 -0000
Message-ID: <gjat90$5la$4@ger.gmane.org>
References: <gjaqta$tg7$4@ger.gmane.org> <37fcd2780812290758q3ef989c0w5156da3098d06068@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 17:20:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHKr1-0005TD-Gs
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 17:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYL2QSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 11:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbYL2QSw
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 11:18:52 -0500
Received: from main.gmane.org ([80.91.229.2]:33776 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYL2QSv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 11:18:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHKpM-00086H-NW
	for git@vger.kernel.org; Mon, 29 Dec 2008 16:18:48 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 16:18:48 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 16:18:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104107>

Thanks Dmitry,

So I have two options to do this - edit the files direct or issue a command, 
thank you !

Now, my next problem is taking all my changes ($ git add .  -> puts 5k files 
into index, with LF in place of CRLF) out of the index.

Because I haven't committed anything in this repo yet...

$ git reset --hard

....falls over, as it has no HEAD to reset to

I think I read how to do this in a tutorial somewhere, maybe with 
git-checkout, but I'm searching and can't find it.
Any kind soul can point me in the right direction ?

thanks !
"Dmitry Potapov" <dpotapov@gmail.com> wrote in message 
news:37fcd2780812290758q3ef989c0w5156da3098d06068@mail.gmail.com...
>> I'd rather not let git change any files, many of which are PHP that run 
>> on
>> Apache
>> I think I remember reading that this is a config option that gets 
>> swithced
>> on by default on windows (which we are running git on)
>>
>> how do I switch it off ?
>
> git config core.autocrlf false
>
> or if you want to ensure that all your text files have only LF then
>
> git config core.autocrlf input
>
> or if you want to disable conversion for some specific files then you can
> use 'crlf' attribute. See 'gitattributes' for more information.
> http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
>
> Dmitry 
