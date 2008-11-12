From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Newbie questions regarding jgit
Date: Wed, 12 Nov 2008 08:24:46 +0600
Message-ID: <7bfdc29a0811111824v759e4afbu399b79b3dab068dd@mail.gmail.com>
References: <4919EECB.7070408@wellfleetsoftware.com>
	 <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com>
	 <20081111214434.GS2932@spearce.org>
	 <2c6b72b30811111401i3c995889n54407243a1072599@mail.gmail.com>
	 <20081111231106.GT2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jonas Fonseca" <jonas.fonseca@gmail.com>,
	"Farrukh Najmi" <farrukh@wellfleetsoftware.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 03:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L05Sk-0004em-8A
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 03:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYKLC0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 21:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbYKLC0y
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 21:26:54 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:53249 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYKLC0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 21:26:54 -0500
Received: by gxk4 with SMTP id 4so301755gxk.13
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 18:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=y9qo3F3eze+51o4t44kCtMNWmnJTL3aHsK2JxaMyPOk=;
        b=mckqY5idhSO5PT5euFn1PbxnthjHS++R6hfEupNRVoHSOFQ5u7EDP91Yk6nPyhupzS
         L3DoZNG3NO7KPFQKK7fIu6ZUu105Yeo4mMbOFoS2vs7tCuKXjH/ZQxbBib+IBOgUNacU
         qG/KCWh4aeDYdMtPpm1OdWJxcRItfM1mursZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rXw0qIKBUM+O0n0GKliZBv/6wh1kaLiCmQ3QHGC5vF/8p7nxiB70gHrYPYfpMVdtsY
         Krr3J5iYjV3shYGjGiOk8aX+XE/fxLq8Amis3+NHkpcaNV8qvwpiSrP+s3+IYqe3B7VO
         U5WZ1Dl4hPIzCmyM7wTAuWe4zwF/Ny6oohWic=
Received: by 10.151.145.21 with SMTP id x21mr2070840ybn.156.1226456686817;
        Tue, 11 Nov 2008 18:24:46 -0800 (PST)
Received: by 10.150.225.1 with HTTP; Tue, 11 Nov 2008 18:24:46 -0800 (PST)
In-Reply-To: <20081111231106.GT2932@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100713>

On Wed, Nov 12, 2008 at 5:11 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
>>
>> I don't think admin rights are necessary as long as I have
>> "commit"/webdav access. And no svn or git-svn interaction should be
>> needed to upload to the maven repository.
>>
>> Take a look at the distributionManagement section of the
>> google-maven-repository:
>>
>>  - http://google-maven-repository.googlecode.com/svn/repository/com/google/google/1/google-1.pom
>>
>> Looks pretty easy to set up. About maintaining it, I don't mind doing
>> "mvn deploy" once in a while, but some kind of update policy should
>> probably be worked out in any case.
>
> Then have at it.  It sounds like it would be worthwhile setting up.
>

This idea is cool!

> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
