From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Re: Adding spell checker to GIT
Date: Sat, 6 Jan 2007 08:51:56 +0530
Message-ID: <b5a19cd20701051921j69f1a85bo97e39db7d8401222@mail.gmail.com>
References: <b5a19cd20701041246we052685hd700580df2cc120d@mail.gmail.com>
	 <Pine.LNX.4.63.0701052147070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 04:22:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3289-0004vk-8i
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 04:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbXAFDV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 22:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbXAFDV7
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 22:21:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:35803 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbXAFDV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 22:21:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8620837nfa
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 19:21:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dpKgCsCKWElKYFYHszpMLtdz2eDTUiBWiAFe5DTZtyzXi4n1R+zcZMqxc5Gk59nADI2tfE0+1hJG3IqM0tY2+COL5zUwpmMcNXZGH1jieKHhDZLbY5t4JSBTkTzZFYN/PzfSYkTJOIDqckB1eJlmLvTMNz1BM6GKgoKBu64Ix7E=
Received: by 10.49.20.15 with SMTP id x15mr17700726nfi.1168053716614;
        Fri, 05 Jan 2007 19:21:56 -0800 (PST)
Received: by 10.49.11.7 with HTTP; Fri, 5 Jan 2007 19:21:56 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701052147070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36074>

Hi Johannes,
                    I spell check "//" comments in
in find_ext()

if($_[0] =~ /\.cc|\.java/) {

                $start_pattern  = qr!\s/\*\s|\s//\s!;
        }

and

$chosen_pattern eq qq!\s//\s! ? $end_pattern=qq!\s\014\s! : "End
Pattern Not Found" ;

Also yes i didnt include to use spell checking in string literals , i
thought that would be irregular and cumbersome.

Could you please test the code then i can include it in a seperate file ..?

Regards
Deepak

On 1/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 5 Jan 2007, Deepak Barua wrote:
>
> >         I and sasikumar have designed and built a spell checker into
> > the pre-commit hook, could someone please test it and give us your
> > comments.
>
> It's a rather big chunk of code, and it is in perl, so I'd rather put it
> in another file, but oh well.
>
> There are a few remaining problems, and I don't even know if the second
> can be solved:
>
> - you miss "//" comments,
> - if the diff is only about a small part of a comment, you do not spell
>   check that
> - you do not spell check literal messages (i.e. printf("No such fiel!"))
>
> Ciao,
> Dscho
>
>


-- 
Code Code Code Away
