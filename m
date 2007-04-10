From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 17:48:13 +0200
Message-ID: <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
	 <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
	 <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 01:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbIa3-00010Z-N8
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 17:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030903AbXDJPsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 11:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030905AbXDJPsP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 11:48:15 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:10680 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030903AbXDJPsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 11:48:14 -0400
Received: by an-out-0708.google.com with SMTP id b33so1995707ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 08:48:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UZuJPgund+5g5kth/bVsQKdHuCY5A6/3OEgn4V7TtnU/ns7Exk1/pZ7Cfo004qxjiXF54PhuzwoHHwZK0okToo8G9dhV8QWju76LBkdgV5l7DrXhIZKGNPfPXWBebk7fDVslaccDKEjAMhBCxIScgd8nYkoOq1LvCBeN/vZi8p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dP9xVsMEkDOl43QcN3LevdR3Hd5tNg5n1+T62hn/lKGnsbm6ApY6w4/FnY4o7pUxN2UjOJMtItUH4f8b2eHmM6dMshwos8iZP4ltRkEgDM4mY01GvFQMa0/E/y5QUZOmhLbYa+uS97iWKRiT4qdpQ7nLWo8nB8N6KxtEU7ufa3U=
Received: by 10.100.32.1 with SMTP id f1mr4980306anf.1176220093655;
        Tue, 10 Apr 2007 08:48:13 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 08:48:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44148>

On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> So I'd like this to be merged somewhere, not because "it works" or "it's
> complete", but because it's in a shape where I think a lot of people can
> start fixing small details.

It is already "merged somewhere": as soon as the patches left landed
on vger, it is not possible to loose (and even destroy) them.
The feature is just too much sought after.

> For example, with just two smallish updates:
>  - teach "git upload-pack" not to try to follow gitlinks
>  - teach "git read-tree" to check out a git-link as just an empty
>    subdirectory

which also should fix switching between the branches with subprojects.
