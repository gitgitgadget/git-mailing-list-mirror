From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: What is the mechanism of a git checkout?
Date: Thu, 28 May 2009 12:26:53 -0400
Message-ID: <eaa105840905280926k482b6a3an82836c123cc38f6f@mail.gmail.com>
References: <23764024.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: mastermindxs <mastermindxs@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 18:27:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9iRY-0000K2-CJ
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 18:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236AbZE1Q0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 12:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbZE1Q0x
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 12:26:53 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:50632 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbZE1Q0w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 12:26:52 -0400
Received: by ewy24 with SMTP id 24so5559597ewy.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=FQ2RUlLePdDpElZrRSRT6bQgWpJP9oAM9c8V/U+gyKc=;
        b=R30lubsBRtzOlR9BR8ojTkbrQMjsSbZkzvgVUSzyptD6fSvjFVyh/fUl92OtdXMfC9
         VWZm6t7m4GBXoJO5r2XD5r+mm+9OE2hRS1siVlnrZm7zRFCszMvF4ZXo7BGUEYOxuemW
         LjID0YyZARMXdjKYin6raSQgcF6oTA23SfbPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=O7FrK0cmYam4GkbXqfcJ6drf7wrbqUZ5ySiu13CtBUdF2nwmf503NZAYLzKIfxmuxm
         DKj/yVpkzy768y/UVs3VoEZ3b67z9nZ4CH46bgkL2Q0g0973t9T2HeAni4lWtt0Vdojl
         Uw26E4aG/Co2wUg0cdKbqPtGwZH5Wc6zPzYNY=
Received: by 10.210.36.8 with SMTP id j8mr1248805ebj.44.1243528013170; Thu, 28 
	May 2009 09:26:53 -0700 (PDT)
In-Reply-To: <23764024.post@talk.nabble.com>
X-Google-Sender-Auth: 1adbc6a49725749c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120196>

On Thu, May 28, 2009 at 11:21 AM, mastermindxs wrote:
>
> Can anyone shed more light on the underlying mechanisms of git checkout
> maybe even branch and merge as well?

This may help you understand Git: http://www.youtube.com/watch?v=8dhZ9BXQgc4

Also: http://eagain.net/articles/git-for-computer-scientists/

Peter Harris
