From: Ammon Riley <ammon.riley@gmail.com>
Subject: Re: [PATCH] Add a post-tag hook
Date: Fri, 17 Apr 2009 15:28:04 -0700
Message-ID: <cd3664ac0904171528p3ed55071p4e098f5181fb0b27@mail.gmail.com>
References: <cd3664ac0904171515u1e2fce41ubd34f60ec43fcafd@mail.gmail.com>
	 <20090417221944.GS23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwZ4-0003Bt-BX
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZDQW2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbZDQW2H
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:28:07 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:21338 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbZDQW2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:28:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so264203and.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bfjBBq0TaaHZhu8KvfGgnyETbK6MJV1JjBcVF6KmPoA=;
        b=ptESLW8xFOCqfYAlNcZeZ7EGaULfxHRZWAriiNnyJU8DMEt7HkMJtX7+tcQwTjPNSS
         U71lFUYP4tx5akY99l0s9BN592vPqSHKClOE9nuyVi12RybvSfT4Gq3QM06oOTh5RH9s
         sAmYh2JlS6phhXBQlN9UIWfvmL2V9C5Ssh9NE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NPcp0a9Rx/GBiOElg9gn6mRzEzP0d+o9vOOalwFwhloorgKKgL5G7+BDxLe9ATX7E6
         4UuqsWEou4xdZ/mX/2NPo9EaF9PMiJgw6iDw8v4gSV/o7KEp33wG1CCZWsGMli8+bMRs
         t9iSOKwrxO1BHaLk8woDCy1kPjnFd4URBEhmQ=
Received: by 10.100.240.9 with SMTP id n9mr4468214anh.135.1240007284814; Fri, 
	17 Apr 2009 15:28:04 -0700 (PDT)
In-Reply-To: <20090417221944.GS23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116799>

On Fri, Apr 17, 2009 at 3:19 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Ammon Riley <ammon.riley@gmail.com> wrote:
>> Add a post-tag hook, to allow notifications when a tag is created.
>> The hook is given the name of the newly created tag.
>
> Why would you want to send notifications upon creating a tag in
> your local repository?
>
> Usually a tag is only interesting when it has been sent to a shared
> public repository, which is by git push, and thus is caught by a
> git receive-pack hook like post-update or post-receive.

On the particular project I'm working on, we're not really using git
in the most distributed fashion -- it's completely internal to the
company. In our case, the tags are being created directly on
the shared repository, rather than on a local repository and being
pushed.

Cheers,
Ammon
