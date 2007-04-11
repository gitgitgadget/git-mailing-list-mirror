From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 10:29:24 +0200
Message-ID: <81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
	 <20070411080641.GF21701@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Martin Waitz" <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbYCm-0003J9-MJ
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXDKI3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbXDKI3Z
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:29:25 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:24077 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbXDKI3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:29:25 -0400
Received: by an-out-0708.google.com with SMTP id b33so113061ana
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 01:29:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XezeeRqRmXDMh+FQeJSAXxWgo05SerrZ4XQBRxdc2l2F8CWe7Jh5Ebm1f4KH+31FfGjEyxePg1U8iIwo0g6XXIR8kcs9LEHijQQpTPEOMtbFoAOEHThDDdIJ2Vj6UwdpRgtPW93IE6oDA73nPm42bBSeb8QfOnotl8veKtPU8DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LorsquhoW6bjvfiwKDffMCxVNV+eYQRAB55IS2KQZMxHtdZr0mL35Ta5jF9nznU+tZdQsnVhwEJh4p5TZxZj8SW2mGaMVJj300F52Uv9NT1r5r12BWYmKVjtlBohNlWZ4hD2Aro+eW4ourqDyVQjBiqVYdBpxbXKi5WdkkjES3w=
Received: by 10.100.43.9 with SMTP id q9mr239068anq.1176280164404;
        Wed, 11 Apr 2007 01:29:24 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Wed, 11 Apr 2007 01:29:24 -0700 (PDT)
In-Reply-To: <20070411080641.GF21701@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44221>

On 4/11/07, Martin Waitz <tali@admingilde.org> wrote:
> So my advice is:
> Always read and write one dedicated branch (hardcoded "master" or
> configurable) when the supermodule wants to access a submodule.

In this case it does not correspond to the working tree anymore.
HEAD is the "closest" to working tree of submodule.
