From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Wed, 24 Mar 2010 10:30:06 +0800
Message-ID: <41f08ee11003231930t3508994atb7cfc6bb354048@mail.gmail.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <201003231222.40745.jnareb@gmail.com>
	 <41f08ee11003230523h2c5f93b1l7e94d6c85a93a706@mail.gmail.com>
	 <201003231449.42190.jnareb@gmail.com>
	 <41f08ee11003230823i1ca677b8q51b2413040c45c44@mail.gmail.com>
	 <20100323195724.GA1843@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 03:30:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuGMK-0006Xw-BR
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 03:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122Ab0CXCaK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 22:30:10 -0400
Received: from mail-qy0-f195.google.com ([209.85.221.195]:59206 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab0CXCaI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 22:30:08 -0400
Received: by qyk33 with SMTP id 33so3163720qyk.28
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Cx0sCiEeeMlnDPrOOHytYREFJWtFZNhBwN0NcH56aIU=;
        b=Fkrkbl3drwTrbf9kljJKyGp1zDpRGkxQds7ggKOgsXQqsmLkh70THt+fT3oM7Epsjc
         JTgD4B0LHTrAWM85zDba6M5s8K0EJ6T1a0zwNG3iR9tlf/wKvd5WeUkSxQ/YiVkOKl0B
         Czo7PUw9hEG/CLzHpnqgRwvf/H6lOAm3rJoSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZWgXiHMImsOOF028kWA1otl/8EKakzXChG1rXylyw8iZPnBk6CPidTEosvm6DhXCBz
         CdjTPhlyhH732irUdT+yu16kZjemlE4NR/bLV8GBbJa21/hRrApbnN8poN7ulcZQyIB7
         WsKwQB0Qh7giQHldjkyfVgEXMwSu9ST4flWfE=
Received: by 10.229.14.157 with SMTP id g29mr534908qca.57.1269397806795; Tue, 
	23 Mar 2010 19:30:06 -0700 (PDT)
In-Reply-To: <20100323195724.GA1843@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143064>

Hi,

On Wed, Mar 24, 2010 at 3:57 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Bo Yang wrote:
>
>> It traces the preimage of the minimum related diff hunk carefully, i=
f
>> there is any case that there are more than one commit intersect with
>> the preimage, we will stop and ask the users to select which way to =
go
>> on tracing.
>
> That might be necessary, but I will admit that I suspect it to be
> harder to make useful. =A0One of the very nice things about =91git lo=
g=92 is
> that it is easy to browse through history in a nonlinear way in a
> pager (by using a pager=92s search functionality). =A0The =93backend=94=
 =91git
> rev-list=92 is easy to write scripts with, also because of its simple
> input and output.
>
> If your program requires input from the user, how will it paginate it=
s
> output? =A0Most pagers expect the standard input to be available for
> input from the user.
>
> One approach (I will not say it is a good one) to the problem of
> ambiguous origins for a line is to blame _both_ parents. =A0That is,
> start following both lines of history in your revision walking.
> Perhaps higher-level tools like =91git log --graph=92 and gitk could
> visually represent the branched history you are showing.
>
> Another approach is to just choose one parent automatically: for
> example, prefer the first parent, or assign some score representing
> the relatedness of each parent and choose the most related one.

Both the approach is very precious for me. I think maybe I will
propose the first one in my real proposal to Git, thanks a lot! You
really help my too much! Thanks!

Regards!
Bo
