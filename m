From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: Newbie questions regarding jgit
Date: Tue, 11 Nov 2008 23:01:01 +0100
Message-ID: <2c6b72b30811111401i3c995889n54407243a1072599@mail.gmail.com>
References: <4919EECB.7070408@wellfleetsoftware.com>
	 <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com>
	 <20081111214434.GS2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Farrukh Najmi" <farrukh@wellfleetsoftware.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 23:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L01Ji-00075A-Fl
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 23:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYKKWBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 17:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYKKWBF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 17:01:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:48960 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbYKKWBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 17:01:04 -0500
Received: by fg-out-1718.google.com with SMTP id 19so152343fgg.17
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=i655QR2Vdvt99ZdMvqkcNu8VtEQP5SqXHNlZAY1+HO8=;
        b=DV99u5bjzFbWz0ig5Oo1RqWSH1mICqBIL0Qbnn1uoOmcd7l/AXX/I5uuSYBLR/ghZP
         55ApnKvqSsq88TSUZhvGuYz8yKoWFEAT2DJfIthopmAHUUlLoj3NbH/QJmOJ6yXB7FKT
         IaTcFGvJ+s/+GVdcAUUvh0IHzWoavBqQQS62Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rVxhKuu9pJCgFv8dPSkYHLy3GHcNAIjGkckLOju2EbVLZrX5sK+CBLeoqdJUmeh/xn
         cxME4cyvGNnLMYoVsfXa8HsPP5jJC79IWxLX/FbmgrxV9K6fLqcMTyYA6AToi80bRBm/
         4SRkZH720FsIQGNvOjLEjpGDmJ7cTftdYOQ5s=
Received: by 10.181.159.11 with SMTP id l11mr2638903bko.186.1226440861062;
        Tue, 11 Nov 2008 14:01:01 -0800 (PST)
Received: by 10.181.232.9 with HTTP; Tue, 11 Nov 2008 14:01:01 -0800 (PST)
In-Reply-To: <20081111214434.GS2932@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100685>

On Tue, Nov 11, 2008 at 22:44, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
>> I would also like to have a public available maven repository for
>> JGit. If Shawn or Robin acks, I can look into hosting one in the SVN
>> area of the Google Code project page. Given the lack of a real release
>> cycle it probably only makes sense to have a snapshot repository.
>
> I have an account on kernel.org and was planning on hosting snapshots
> there, but I haven't had time to think about setting up a jgit area
> and pushing something into it.  ;-)

If you prefer that ...

> We could also just host it in SVN in Google Code.  I can give
> you admin rights on the egit project if you want to set it up and
> maintain it there.  The downside is you need to use svn or git-svn
> to upload files to it, right?

I don't think admin rights are necessary as long as I have
"commit"/webdav access. And no svn or git-svn interaction should be
needed to upload to the maven repository.

Take a look at the distributionManagement section of the
google-maven-repository:

 - http://google-maven-repository.googlecode.com/svn/repository/com/google/google/1/google-1.pom

Looks pretty easy to set up. About maintaining it, I don't mind doing
"mvn deploy" once in a while, but some kind of update policy should
probably be worked out in any case.

-- 
Jonas Fonseca
