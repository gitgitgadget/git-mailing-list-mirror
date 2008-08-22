From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 19:33:18 +0030
Message-ID: <4d8e3fd30808221203r1630addaodb87c0a8b34f0fd2@mail.gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org>
	 <32541b130808221056l75a3fd6bsa6c7933a1c3da60f@mail.gmail.com>
	 <20080822183129.GR23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>, git@vger.kernel.org
To: "Andi Kleen" <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWbw5-0001e6-2I
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbYHVTDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYHVTDW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:03:22 -0400
Received: from mail-gx0-f29.google.com ([209.85.217.29]:47194 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbYHVTDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:03:20 -0400
Received: by gxk10 with SMTP id 10so948047gxk.13
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 12:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6aRcbBXtbyISjbYcum1ueI/ofcMbqFcH/94R+edv9sM=;
        b=t+nw5Amv5/ZOm2LQScj4mDXMWTiOaQTKDG1t8fw0eFvWuIt3Xc4zjnLkkR/9oiiVsJ
         F0xPzmwGGm/Q4IZs9oTDEyfCLca99VGrPg40a6Pq/Uq4hdi0GB8qMq4tqiOfSTF9Ctny
         rdihJLJcrSLlM2fOolI/nFZU81nphTJjPU/lY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SJIii8MSpXL3ZrM3ZCcw+np7tb6Dt3lansDs2blrUOgqEShR6iXccAIA/c9GIORlcZ
         p4XBAQx1A9/pSNDaK5xDPko/NF/tLBJhKwEAEEjchsZcVyd/KDhOODy29JTQJDO5FhCX
         HZ5Ou/FcjB8LzaiyyJvMd2llNnFWM+9gt6BmM=
Received: by 10.142.132.2 with SMTP id f2mr530075wfd.22.1219431798892;
        Fri, 22 Aug 2008 12:03:18 -0700 (PDT)
Received: by 10.142.194.8 with HTTP; Fri, 22 Aug 2008 12:03:18 -0700 (PDT)
In-Reply-To: <20080822183129.GR23334@one.firstfloor.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93342>

On 8/22/08, Andi Kleen <andi@firstfloor.org> wrote:
> On Fri, Aug 22, 2008 at 01:56:39PM -0400, Avery Pennarun wrote:
>> On Fri, Aug 22, 2008 at 1:46 PM, Andi Kleen <andi@firstfloor.org> wrote:
>> > But I presume that's a reasonable common usage. Would it
>> > make sense to have some standard git sub command that does that?
>> > ("get latest state of remote branch, doing what it takes to get it")
>> > Or is there already one that I missed?
>>
>> Isn't that just
>>
>>     git fetch somewhere branchname
>>     git reset --hard FETCH_HEAD
>>
>> ?
>
> My script right now does.
>
> git fetch origin
> git fetch --tags origin
> git remote update
> git checkout master
> git reset --hard origin/master
>


why the two fetch?
isn't git remote update sufficient?

ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
