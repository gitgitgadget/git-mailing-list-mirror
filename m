From: David Roundy <roundyd@physics.oregonstate.edu>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Sat, 24 Oct 2009 10:59:47 -0400
Message-ID: <117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
	 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
	 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
	 <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
	 <20091022062145.6117@nanako3.lavabit.com>
	 <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>
	 <7vzl7h8fjp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 16:59:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1i5z-000356-41
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 16:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbZJXO7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 10:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZJXO7o
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 10:59:44 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:50280 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZJXO7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 10:59:43 -0400
Received: by qyk4 with SMTP id 4so7124613qyk.33
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=bR2ZlJkyYpnjXiZ4PwiEkjQkCLixPyE2469lZJt/quc=;
        b=xd1z2MOAbqxweWILbfe9yc+h8xCUfyjE2jlqmb2ch3HneUQXHwni4XQ/Z6qEq5+8ZA
         xMLj4KKxBCB/AQP7x054t8ob6+UNqX2wDgh2FFSoqx7j8STX6tmyHfhOkN7MfBxIXeg5
         vrVS37gg+TSLvqbY+Ll1aYy0YB4aWwycHWNUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=lkh6KzueGIbpWmMoDZiaNEBd/U55EnO0w+TTTO3k+dq9ge2gbikJ47VfqP+B0rh0TV
         y8xnM+qaH1muxKbA9NPV7H+PchQoeycgWpuhGApqE8LAgqWDZTqxe0nWW+EKH6Rz4VQP
         K9fHfcnn1waL8ZvS9M+6NPomWVxLS1k+yqJK4=
Received: by 10.224.96.88 with SMTP id g24mr6161256qan.361.1256396387962; Sat, 
	24 Oct 2009 07:59:47 -0700 (PDT)
In-Reply-To: <7vzl7h8fjp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: b814141dd4bfd500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131167>

On Sat, Oct 24, 2009 at 2:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> My take on it:
>>
>> 1) --no-porcelain
>>
>> 2) we all are bike-shedding, not being constructive at all
>
> You are right about (2), regarding the option name. I've queued one that
> uses --no-guess.

Perhaps a universal --plumbing flag would be handy? It'd be nice to be
able to pass any command --plumbing and it'll either behave in a
stable, predictable, plumbing-like way, or die with an error message
stating that it isn't a plumbing command.  Right now, it's sort of
hard to figure out what is plumbing and what is porcelain.  Some
commands are clear, but other commands labelled as plumbing in git(1)
are deprecated in favor of commands labelled as porcelain.

David
