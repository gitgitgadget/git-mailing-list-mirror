From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-grep while excluding files in a blacklist
Date: Wed, 18 Jan 2012 08:24:03 +0700
Message-ID: <CACsJy8C0aXgecCWHrCK3yzNLWnWX4g81x-OzZCY0xtonbspzXw@mail.gmail.com>
References: <CA++fsGHGrNQzR-schP0yTXnD4jkYJjHHVk6QoJvfxPX9mguJPQ@mail.gmail.com>
 <CACsJy8A8eWt_wcxWrdjgmkHZpS1bBet7DTT-bRf9zrxfszUtjw@mail.gmail.com> <7v4nvurszj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dov Grobgeld <dov.grobgeld@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 02:24:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnKGW-0001yD-SA
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 02:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab2ARBYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 20:24:36 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab2ARBYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 20:24:35 -0500
Received: by bkas6 with SMTP id s6so2282564bka.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 17:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OTnodAWid9rV5qf2Yh2ipqkwL/osih4joyexwUw9Ikc=;
        b=jaJyrFfhVxXE458q7tackFvI0Pdt9EF/B7CKKz61ULdM49iY25853Rvmy+nADjvu5+
         T6XDITOWQ0aLqqGb8bEC7RYQBHWWVU1jU8urdnDQMZiCOGrhNoIZyLJNlAHpSri52Lsa
         TIOuIpWaapH6bCJfJDcSj5Cq3cwBvKxUmHL14=
Received: by 10.205.132.14 with SMTP id hs14mr7862430bkc.130.1326849874289;
 Tue, 17 Jan 2012 17:24:34 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Tue, 17 Jan 2012 17:24:03 -0800 (PST)
In-Reply-To: <7v4nvurszj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188734>

On Wed, Jan 18, 2012 at 3:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Tue, Jan 17, 2012 at 4:14 PM, Dov Grobgeld <dov.grobgeld@gmail.com> wrote:
>>> Does git-grep allow searching for a pattern in all files *except*
>>> files matching a pattern. E.g. in our project we have multiple DLL's
>>> in git, but when searching I would like to exclude these for speed. Is
>>> that possible with git-grep?
>>
>> Not from command line, no. You can put "*.dll" to .gitignore file then
>> "git grep --exclude-standard".
>
> No rush, but is this something we would eventually want to handle with the
> negative pathspec?

Definitely. But because I'm stuck at adding "seen" feature from
match_pathspec_depth to tree_entry_interesting, that probably won't
happen this year. Adding "--exclude=<pattern>" to git-grep is a more
plausible option.
-- 
Duy
