From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Fri, 29 Aug 2008 19:28:39 +0300
Message-ID: <94a0d4530808290928w3b1decd4o2e77349d793ffff0@mail.gmail.com>
References: <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>
	 <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
	 <20080828212346.GA27867@coredump.intra.peff.net>
	 <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
	 <20080828215907.GE27867@coredump.intra.peff.net>
	 <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
	 <881C17DA-2FE2-49A7-A4A9-FACA7720599C@cs.indiana.edu>
	 <20080829152451.GA20629@yugib.highrise.ca>
	 <94a0d4530808290911j32bf5ee0q869dfe39483297f8@mail.gmail.com>
	 <20080829162420.GB20629@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Aidan Van Dyk" <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:29:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ6r3-0007Sx-Ud
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 18:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbYH2Q2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 12:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbYH2Q2l
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 12:28:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:57626 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYH2Q2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 12:28:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so947924rvb.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VGtlre1GJxwR8oxGrDdFh4mrbCj1kBAKPEl5dyyFYXg=;
        b=lek3LNl61vtJ3oK+IvlA87M3owyQmQQ8hv//9/aweTzQPT9is9Wwcj5w6AfyQ4vlnx
         Vpyuhf7DctLvlhxMfZQA97CKWoPByeKJRRxpMeWqeKAmc+/38EoYrLYhipdHxP83TXwy
         ircCurKKtneMmPCfsHwkelIMJh0XLhbLzA9xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FfszHFYVmn/BuqQQU47rSAHGCQmeZRDkyFxJJwJfJ1EC4zHOC36+IUZObjlRXM7atl
         iEYU04DgP/TjTGMNmfp14beRTX7wZDEEtxlfH0sis87QNmbBzXuw0zNyboWhzO8dPEWX
         DFGL100XhkrTCQIM9gFSlFQZnM/HkQmsnlOi4=
Received: by 10.140.166.21 with SMTP id o21mr1597277rve.254.1220027319708;
        Fri, 29 Aug 2008 09:28:39 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Fri, 29 Aug 2008 09:28:39 -0700 (PDT)
In-Reply-To: <20080829162420.GB20629@yugib.highrise.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94310>

On Fri, Aug 29, 2008 at 7:24 PM, Aidan Van Dyk <aidan@highrise.ca> wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [080829 12:11]:
>> On Fri, Aug 29, 2008 at 6:24 PM, Aidan Van Dyk <aidan@highrise.ca> wrote:
>> > * Perry Wagle <wagle@cs.indiana.edu> [080801 00:00]:
>> >> Jeff King has convinced me that it's perfectly legitimate to introduce
>> >> non-upward compatibilities in minor version releases of "young"
>> >> software.
>> >
>> > This is the gist of the problem.  You keep hammering about a
>> > "non-upwards compatibilities in minor version releases", yet you have
>> > *not* pointed out one such in-compatibility in a minor version release..
>> >
>> > Remember, in git, 1.6 is a "major version" release, with release notes, etc.
>> > 1.5.X is a "minor version" release.
>> > 1.5.X.Y is a "patch" release.
>>
>> What is X (2.0)?
>
> X would be a digit, like 0, 1, 2, 3, 4, 5, 6, 7, 8, or 9, as in the git
> 1.5 releases:
>        1.5.0
>        1.5.1
>        1.5.2
>        1.5.3
>        1.5.4
>        1.5.4
>        1.5.6
>
> And now also:
>        1.6.0, being the first of the 1.6 releases...

I meant 'X.0.0', if 1.X is major, what is X.0? Huge?

-- 
Felipe Contreras
