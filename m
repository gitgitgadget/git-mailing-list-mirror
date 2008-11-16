From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 07/11] gitweb: add 'remotes' action
Date: Sun, 16 Nov 2008 03:47:55 +0100
Message-ID: <cb7bb73a0811151847r536e3e57wc1502bcf734e7930@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811151316.32024.jnareb@gmail.com>
	 <cb7bb73a0811150432s2f3ae4bfkc0fc29d92accc635@mail.gmail.com>
	 <200811160129.17319.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 03:53:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Xkx-00054w-B9
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 03:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbYKPCr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 21:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbYKPCr6
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 21:47:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:32978 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbYKPCr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 21:47:57 -0500
Received: by ey-out-2122.google.com with SMTP id 6so787423eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 18:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2pJiytLrZoQWSQLh4lQXSzw4j1pnMbiYzb3A7lwdh3M=;
        b=pXyOXye19iwN9yKcsF9Cew+JytSaNBn6og9PN/HIr67Kdk2ygzHblMp6Ja4xf+nNBw
         rI3CiY4zy8ljEKxnk150AKlSOvIUDgKO7oovbKmIOSqVKAX8trJKyDRppsTzIkRox5pr
         3KH4OpSuqRvaXJHwLj8D3XVD2YMGp/mRpC8ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=m+v6/5iNe3jWemk8y+qOv2Ar6q4SF8O2Y0exIZN8vbYid59DplHKUkWWPsiGHWj9G7
         mSiIUpY7pGEWI3F73Th15HxHjfzj95EXKugDXorLLl30a2/nsiquXZmU13YMVlt3Yz5S
         hGRcdThwtM4s3tmtlxfHGofko0/evcyLZ7qC0=
Received: by 10.210.142.6 with SMTP id p6mr2645345ebd.100.1226803675612;
        Sat, 15 Nov 2008 18:47:55 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sat, 15 Nov 2008 18:47:55 -0800 (PST)
In-Reply-To: <200811160129.17319.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101115>

On Sun, Nov 16, 2008 at 1:29 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 15 Nov 2008, Giuseppe Bilotta wrote:
>> FWIW, I decided to scratch that additional ' remotes' string when
>> squashing this patch.
>
> Hmmm... I'm not sure if $project in git_print_header_div() for those
> two actions is good thing to have...

Considering it links back to summary view, it makes sense to say
$project in there.  If we decide to make it link to something else, we
should change the text accordingly. Suggestions?

-- 
Giuseppe "Oblomov" Bilotta
