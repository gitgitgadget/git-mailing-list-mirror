From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major bugs.
Date: Wed, 2 Jan 2013 17:48:07 +0100
Message-ID: <CABYiQpkLze8aBZecGovBdMbxSE=kYH__KZntQDt7KwqUadUYdg@mail.gmail.com>
References: <20130101172645.GA5506@thyrsus.com>
	<7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
	<20130102003344.GA9651@thyrsus.com>
	<20130102080247.GA20002@elie.Belkin>
	<20130102105919.GA14391@thyrsus.com>
	<20130102153933.GA30813@elie.Belkin>
	<20130102161848.GA18447@thyrsus.com>
	<CACPiFCKDoAoKxM4YU6uKoOGcDgLbXnCoUMO5iyf-wCWXh3j70A@mail.gmail.com>
	<20130102164107.GA19006@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Jan 02 17:48:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRUS-0001OY-4y
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab3ABQsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:48:09 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:41339 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab3ABQsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:48:08 -0500
Received: by mail-vc0-f178.google.com with SMTP id l6so604039vcl.9
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 08:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HNTAmmC86XgCvokB9JewyYLaPlfrhODqZFIhVpz1Vr0=;
        b=fMQBLWJaRShb/cGKsoeNK/OITwtgn7KigdSsR1uPneKe/2Sag573wcjuUfz3Km8C2Y
         6hkeDNr0y+MYRXKfl6ObbTixMFFVrKfe6kONIbQZF3BfmZY2Rlf+ixUNCiWkD5Qc9lVv
         b7c10tPLdu7ayCMOlKG+NpNXZwVq+ifWv0ZUkW1beGzZYF0XvD2hBeydm6ZQ+JLj4Xkn
         qbbNQly/nD9wxzlGluNAiRzWVszqgc1aQ72SZFaR6Y4CbqOfymAFcK1IJI/8MTP+FyEf
         I107BEGsRiv13AcwxqsTM0+C4ZKF7/0vypKveGAT8KTz9ZWmottpfNX0kuw42i7Xkfa1
         3NoA==
Received: by 10.58.223.200 with SMTP id qw8mr73999219vec.12.1357145287469;
 Wed, 02 Jan 2013 08:48:07 -0800 (PST)
Received: by 10.58.233.197 with HTTP; Wed, 2 Jan 2013 08:48:07 -0800 (PST)
In-Reply-To: <20130102164107.GA19006@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212525>

On Wed, Jan 2, 2013 at 5:41 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Martin Langhoff <martin.langhoff@gmail.com>:
>> Replacement with something more solid is welcome, but until you are
>> extremely confident of its handling of legacy setups... I would still
>> provide the old cvsimport, perhaps in contrib.
>
> I am extremely confident.  I built a test suite so I could be.

I too am glad to see some work go into the cvsimport script. So just
to clear things up, previously you said this:
> Yes, they must install an updated cvsps.

This is the problem, and one that is easily "solved" by just keeping a
copy of the old command.

Remember that for many users of these tools it doesn't matter if the
history is correct or not, as long as the head checkout contains the
right files and they are able to submit new changes. With this
definition of "works" git-cvsimport is not that broken I think.

Cheers,
- Thomas
