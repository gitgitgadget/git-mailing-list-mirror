From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Re: Adding spell checker to GIT
Date: Tue, 16 Jan 2007 23:04:29 +0530
Message-ID: <b5a19cd20701160934s16b8717er69b950cff055a5ae@mail.gmail.com>
References: <b5a19cd20701041246we052685hd700580df2cc120d@mail.gmail.com>
	 <Pine.LNX.4.63.0701052147070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <b5a19cd20701051921j69f1a85bo97e39db7d8401222@mail.gmail.com>
	 <Pine.LNX.4.63.0701161709570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 18:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6sCq-0003jQ-Pw
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 18:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbXAPRel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 12:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbXAPRel
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 12:34:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:48010 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbXAPRek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 12:34:40 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2472875nfa
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 09:34:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WjwicQ5vzlTQ+Nm6pH5yrGiJV4H1RgG99Pjg4j+n0Z0Xjm5S+qR0eIZMOJ/XoY0uyiWcZKZB6T60NlAatQ3+M9a8J+3ZkbPcB75GhwR+NFIA9fnFo/hGXucs4xFpRgTZZS2JWYOgUShhj5IxLrBqDjJncWCHymeOWKg3Fi8qn2o=
Received: by 10.49.13.14 with SMTP id q14mr6213356nfi.1168968869689;
        Tue, 16 Jan 2007 09:34:29 -0800 (PST)
Received: by 10.49.60.3 with HTTP; Tue, 16 Jan 2007 09:34:29 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701161709570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36949>

Hi Johannes,
                  It's okay take your time and suggest any changes and
teach me how to make this code into a proper patch.

Regards
Deepak

On 1/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 6 Jan 2007, Deepak Barua wrote:
>
> > Hi Johannes,
> >                    I spell check "//" comments in
> > in find_ext()
> >
> > if($_[0] =~ /\.cc|\.java/) {
> >
> >                $start_pattern  = qr!\s/\*\s|\s//\s!;
> >        }
> >
> > and
> >
> > $chosen_pattern eq qq!\s//\s! ? $end_pattern=qq!\s\014\s! : "End
> > Pattern Not Found" ;
> >
> > Also yes i didnt include to use spell checking in string literals , i
> > thought that would be irregular and cumbersome.
> >
> > Could you please test the code then i can include it in a seperate file ..?
>
> Sorry, I am a little bit stressed at the moment... And I don't have the
> required dependencies installed.
>
> Ciao,
> Dscho
>
>


-- 
Code Code Code Away
