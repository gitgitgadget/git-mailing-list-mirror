From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Mon, 12 May 2008 13:19:20 +0200
Message-ID: <200805121319.37512.jnareb@gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com> <m3d4nr4ykr.fsf@localhost.localdomain> <bd6139dc0805120319s5ad37867k392eff88616b689e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon May 12 13:21:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvW5m-0005oP-0W
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 13:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbYELLUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 07:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbYELLUK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 07:20:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:23749 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758771AbYELLTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 07:19:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1763084fgg.17
        for <git@vger.kernel.org>; Mon, 12 May 2008 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=ZbgQZMi9ANXRCPZ338rhiHLKpp8EyaeISxuKMWDyW1E=;
        b=eq0FPHvLC51GzgDTmh1JXBgqA4D7TahU4Cwr85q757GGn1MEWapuBvmob4DLlwZBYPaatNzh5DpXSHlcfQkiNmjTFywlqa9nzQpUZh5dQLoDf9mOgM8Xy4BGMLVu7M0bkcS87sIlUSTwRWLmwA6dXcN2MscjP3a2hfujTwpN8+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a8XdUJncfwTdPdQlgTVEtnTvJkqIzQrPEZVTimQKzJdsb/1iu0JbFgm74CCGivOzegA3GsLkwcvLf/MErlzBezOpIA6Ks5Xy9VBjSf9UwlFR19shdgMW4btwlWT2DN2ewwQmxY/SIvP1QqgDKkRFlpCYnsU3JTmpfTSdsWfPnuo=
Received: by 10.86.77.5 with SMTP id z5mr11740202fga.42.1210591187508;
        Mon, 12 May 2008 04:19:47 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.115])
        by mx.google.com with ESMTPS id 4sm5953387fgg.6.2008.05.12.04.19.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 04:19:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <bd6139dc0805120319s5ad37867k392eff88616b689e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81852>

On Mon, 12 May 2008 12:19, Sverre Rabbelier wrote:
> On Mon, May 12, 2008 at 12:16 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> One comment: did you take a look at 'owners.sh' script posted some
>> time ago by (IIRC) spearce to check who "owns" egit/jgit and relevant
>> git code?  This is one interesting, and useful, statistics.

First I have to admit that I haven't read your email carefully.
One note: why not provide HTML version in addition to PDF?

> Ah, yes, I did see it, and something similar to that I intend to
> include. I reckon his script would fall under the "Finding a
> Contributor that is active in a specific bit of content" use case.

I don't agree.

This is "Finding the owner of the code" (i.e. something like
non-existent 'git blame --summary') with the goal of "Find who
needs to be contact about changing (or adding) license / relicensing".

This is similar, but not exactly the same as "Find maintainer of given
subsystem", or "Who is responsible for this part of code".


A few use cases I thought about (perhaps repeating what you have wrote,
see note above):

* Maintainer: how close should I examine provided patch?
* Contributor: who is maintainer of the code / whom should I contact
  and send copy of a patch?
* Bug-fixer: who is responsible about this part of code? Who might have
  introduced the bug?
* Contributor: what happened with my code?
* Searching where to contribute: what are oldest part of code dealing
  with error messages (find ancient code)?

HTH
-- 
Jakub Narebski
Poland
