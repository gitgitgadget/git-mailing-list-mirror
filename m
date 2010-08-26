From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Does anyone use git-notes?
Date: Thu, 26 Aug 2010 09:56:55 +0200
Message-ID: <AANLkTim01==of5ce07F4MFVazevNiRQLBMv38ferSgKB@mail.gmail.com>
References: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 09:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoXKY-0007aT-AZ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 09:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab0HZH45 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Aug 2010 03:56:57 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51775 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab0HZH44 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 03:56:56 -0400
Received: by qyk9 with SMTP id 9so5734912qyk.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZL678qYHAARSQa1m7BdbWQQhpmnmT40/MxPsHIqgQOI=;
        b=tk0IwAjC7ya52exWCD4JdyAeifitIzFIqDqgm/DAXeYXSo3LUAWczkzSDcuynKEJAU
         Ib/F/AxkHE/+9qQuqxNkKykoLX1KzYck7WDgMGPDwzd9IoH/OV2ymjVZgZrOqn66Lk2T
         +tlH93BLA5uXOenS9o8WGxODCJoaicZTZXMOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=IMpIKbDZ38l7YmNYhmhNFePV5ybAs6ddjFz4wajdcFdGmkTKZ+QXwnpq4Q3KfCFw18
         onuLzogbIm4ackuOqCgiApgG3MQlb542TlUcKfJzBBi89GEj8ZQtW73lyiNriYeGDI4o
         RXdMcdZvmokpqMokamcl6N7AZDbD0gZZTs+hM=
Received: by 10.224.28.71 with SMTP id l7mr6426986qac.387.1282809415531; Thu,
 26 Aug 2010 00:56:55 -0700 (PDT)
Received: by 10.229.100.18 with HTTP; Thu, 26 Aug 2010 00:56:55 -0700 (PDT)
In-Reply-To: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
X-Google-Sender-Auth: _bBBwp__7GfBtisECn8AYq_eJxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154529>

On Wed, Aug 25, 2010 at 20:15, Scott Chacon <schacon@gmail.com> wrote:
> I would like to write a post on how to use them, but I'm a bit
> confused as to how people actually use them on a day to day basis. =A0=
I
> appears to me in trying to work out a flow for them that the lack of
> an ability to merge them makes them very difficult to use for anythin=
g
> practical. =A0Can someone share with me how they use them and what th=
e
> cycle is?

I use Notes in a very simplistic way. For example, with an emulator
I'm writing I have two or three ways of using git-notes:
1: I commit fixes and changes with a commit message describing the
fix. Later I may find out that the fix made a couple more programs of
the set I have run in the emulator, so I add a note to the commit
saying 'This change makes X and Y work'.
2: I add test cases to the instruction validator I wrote for the
emulator, if the test currently fails I say so in the commit message.
At some later point I may commit a fix that lets the test pass, then I
go back to the original commit message (which said the test currently
failed) and add a note saying 'Fixed by [commit] nnnnnnn'.
3: Occasionally I just use notes as a reminder. If a commit adds a new
feature I may later (after using the feature) add a 'todo'-note about
what improvements I should add.

One use case I have thought of for the company case is to add notes to
a release commit with information that wasn't  or couldn't be added at
the time of the commit, e.g. a list of problem reports closed by the
release.  But I haven't actually figured out how I can get Notes
transferred over a pull yet.. although I haven't tried since 1.7.0.

-Tor
