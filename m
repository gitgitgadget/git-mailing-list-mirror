From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 19:50:31 +0000
Message-ID: <32541b130908191250w79461592vf1bed7874aa4138b@mail.gmail.com>
References: <m33a7noc3u.fsf@localhost.localdomain> <4a8c51f5@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ingo Brueckl <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdrBU-0004KI-18
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 21:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbZHSTuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 15:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbZHSTuu
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 15:50:50 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:53570 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbZHSTuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 15:50:50 -0400
Received: by ywh3 with SMTP id 3so177315ywh.22
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jx5CxaFhqYNPKMZWwzagEurkFcbYksb5Uz0yKH504Os=;
        b=Qc16AXzj11qTtk5Wnnr3xh/B5ZS6TcOGf1R+BeJVhWzEc76ZaYmhcD91J7ckGjkCai
         oJBPJ2+XglRh5D99FRQW/x3jiwCR875tEakudE24hh5dgZFOjA3ahVgNCCFAUyVIOwiJ
         iTYxQWu9+3KQNoWoQauNp3rSK2GG1lgyXYLYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lxDmctcSMRBVaNO9PZo2i6FNRpAQ2YWcozaLYczp5bn+ba17c46K5exkIrcsdoEdCB
         Sn5s6rbt0jHJoA8BylJRRlXq8ycH7fixh9X3rCQO+f9i9fLtYXuOaSQ89Fl6zpkikOPJ
         sv5er78BUtiNzhEBKedoexK2TRZKTiH/cqsMc=
Received: by 10.150.163.5 with SMTP id l5mr11054827ybe.315.1250711451266; Wed, 
	19 Aug 2009 12:50:51 -0700 (PDT)
In-Reply-To: <4a8c51f5@wupperonline.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126578>

On Wed, Aug 19, 2009 at 7:45 PM, Ingo Brueckl<ib@wupperonline.de> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> You finish old work (or stash it away), _then_ you begin new work.
>
> Ok, this helps me a little bit to understand.
>
> The branches aren't designed to split my work, but rather something to
> collect the different parts of my work.
>
> But as software development often is something where you are coding on
> several issues at the same time which can't be committed immediately, it
> sounds that 'stash' is the developer's best friend.

Or you could just 'commit' more frequently, but don't 'push' so you're
not disturbing anyone else until you're done.

This is a big difference from how centralized VCSs work: there, a
commit is a major operation that you're afraid to do in case you make
someone else mad.  In git, commits are cheap, you just need to be
careful about pushing.

(You can also clean up your series of commits before pushing by using
'git rebase')

Have fun,

Avery
