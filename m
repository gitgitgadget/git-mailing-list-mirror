From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-cache-meta -- simple file meta data caching and applying
Date: Thu, 8 Jan 2009 19:28:18 -0500
Message-ID: <76718490901081628x62da43bcia5cdbb160b0ff24a@mail.gmail.com>
References: <87hc49jq04.fsf@jidanni.org>
	 <76718490901081622q618c43d0t333882cbe44f6b30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Jan 09 01:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL5Fw-0000uu-FL
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbZAIA2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbZAIA2T
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:28:19 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:18480 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbZAIA2S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 19:28:18 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8655176rvb.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 16:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iLGUunnCkB5Cm1jCa+ebWe5qtEZ5mAWRHpr+qRSwH2Q=;
        b=aeZ8UIzlV+OFG7XPpsdq2esqsJFvXZyqg+KGantipAYAAH8MdZQp67KgBegYBJnDs9
         b6YzofWgg1nl5uckMsWgD+iN5logtg90BrL/Kva/X/oko9WcNZBHoXx88UdHUWpiEiRT
         //G+nJPCzcaPwQY8XvgVjeOzTFfwlGhieMC/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cbRCRujJ5GwXYSUyBeECHo5Ua7B1U7rspydGsf7KpJaWG8d37cMfzszLXG5NK9K0eA
         MV/p2ZLk7umYa8Rfgv4/6IGeJoPPgJjlhzuRNxXIrZQ9qI0YcnrqwzrJJiA/W+Nemwji
         IxftccC6XvVUUSxVKZZpEFxWADSodVTP1EZ9Y=
Received: by 10.140.170.21 with SMTP id s21mr12396268rve.205.1231460898161;
        Thu, 08 Jan 2009 16:28:18 -0800 (PST)
Received: by 10.140.135.1 with HTTP; Thu, 8 Jan 2009 16:28:18 -0800 (PST)
In-Reply-To: <76718490901081622q618c43d0t333882cbe44f6b30@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104977>

On Thu, Jan 8, 2009 at 7:22 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> It doesn't handle paths which contain white-space. "chown" is typo'd
> as "chowm". To be useful, the contribution might also include
> instructions on how it should be used with git, and perhaps also
> reasoning for why someone would want to use it in place of etckeeper,
> metastore, setgitperms, etc.

It will also blow-up if the output of "git ls-files" exceeds
limitations on number of arguments. Also, might be worth mentioning it
requires GNU find.

j.
