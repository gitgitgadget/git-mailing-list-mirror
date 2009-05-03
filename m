From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 2 May 2009 21:18:29 -0400
Message-ID: <ca433830905021818v5c99cce4q57902eba8ff3d7fc@mail.gmail.com>
References: <200904240051.46233.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <20090424231632.GB10155@atjola.homenet>
	 <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com>
	 <20090502155348.GB6135@atjola.homenet>
	 <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com>
	 <20090502211110.GC6135@atjola.homenet>
	 <b4087cc50905021613j1d269757g8c599b484208c188@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 03:18:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0QLo-0006X7-N7
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 03:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbZECBSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 21:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbZECBSa
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 21:18:30 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46879 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbZECBSa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 21:18:30 -0400
Received: by fxm2 with SMTP id 2so2958202fxm.37
        for <git@vger.kernel.org>; Sat, 02 May 2009 18:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p4/CEmzsb5C3osk7gcZFujUL5l1oe8MczLewYyrYITw=;
        b=KgzvmfVK0o7pDSNhi1UCqXqfXEAIFI7SLQfpJRoI7A46h0pHlOk/cAfMT6Cy1aviHN
         1621olcCk/xw9X7+tRDdRquXZrg4u4aczzlxKmvdydvidIgOc9A+u4rNcymO0aJ9mCC1
         fuHwRvJsiogJEhztDKin2WsiGD5EKXRsyJeE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A/E7ybs9v6I15zF0YOV5iCJwIX7sUcgIts651B6U0++g8I5hOJFF+hMVbXLl+Lkme4
         LU4/1oM8wxSXD2Y/dROIiTKxzCj1Lm8mXX1NgPKHc1tcpDe8k8EJhqqnP+w4upvvzuUH
         bDhrlqlg851ZFPEhx5oTPIEuIklc/yRyZJjrE=
Received: by 10.223.105.9 with SMTP id r9mr1535314fao.66.1241313509486; Sat, 
	02 May 2009 18:18:29 -0700 (PDT)
In-Reply-To: <b4087cc50905021613j1d269757g8c599b484208c188@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118159>

2009/5/2 Michael Witten <mfwitten@gmail.com>:
> I also dislike the use of 'name' rather than 'hash'; a name is
> something provided by the user, but a hash is something computed. The
> use of sha[-]1 is even more egregious.

What about "identifier" as a compromise between "hash" and "name"?
This is really what we're talking about - a way of identifying
objects.
