From: "Eric Raible" <raible@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 16:49:54 -0700
Message-ID: <279b37b20809111649h77666a46u362dddfa1b40e0ca@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
	 <279b37b20809101946k309ad113neb7d051f1c6c410e@mail.gmail.com>
	 <eafc0afe0809102305u6de85ef3ib2c08004dea8d6f9@mail.gmail.com>
	 <51419b2c0809110932r4e8c833fx740ccb0c8e46f0af@mail.gmail.com>
	 <3ab397d0809111022m24c81bd9y2520f6be478babd3@mail.gmail.com>
	 <279b37b20809111424y73a3f6b9xe7f5019b9ba0da16@mail.gmail.com>
	 <20080911233941.GP4829@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Elijah Newren" <newren@gmail.com>,
	"Changsheng Jiang" <jiangzuoyan@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:51:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdvwE-0003L6-Ly
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYIKXt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbYIKXt4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:49:56 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:65419 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbYIKXtz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:49:55 -0400
Received: by mail-gx0-f16.google.com with SMTP id 9so17891698gxk.13
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wFbODns/CyxjxI50h9MgyKVGUUipmWH/2xznTpxwqbU=;
        b=oxdahMIR3xFPvzCWjFyWdz3noZ1RXyO83c2AXhz82O8VE17OGxGYp5KjuAbjDTk5Ci
         ojxieybI/76LTZz7ENmkZTGX3F8AweNRy/EtvCV1K6u+wlpCCSJMvziWXIAnacgQ9s6H
         RbYZw92W1Q//JG2UKp9E3kDodszu8U22Pv/TI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PNEWQOVNkqWJlTjFxDC6Aea0crRn40gwO+kejcFRtRqBpdUuzdPKdczW1c0xGuXX2v
         A1H4y1QBk5NvXGBeYr0ZmDCPMO6eussCuLSg4AbIrgA/GTFGbquWUp2g2egfP8vr8tVb
         w5faK6zqx7L893P7lGCLy29+CgbP1vw/yfjIc=
Received: by 10.150.12.3 with SMTP id 3mr5025707ybl.16.1221176994648;
        Thu, 11 Sep 2008 16:49:54 -0700 (PDT)
Received: by 10.151.113.10 with HTTP; Thu, 11 Sep 2008 16:49:54 -0700 (PDT)
In-Reply-To: <20080911233941.GP4829@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95672>

On Thu, Sep 11, 2008 at 4:39 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Thu, Sep 11, 2008 at 02:24:51PM -0700, Eric Raible <raible@gmail.com> wrote:
>> My question is why "git reset --hard" can't make a special case for
>> _newly added_ tracked files.  After all, "git status" knows that they're
>> "new files", and "git reset --hard" could realize that wiping them off
>> the face of the earth isn't the most helpful thing possible.
>
> I rarely need this, but I use 'git read-tree -m HEAD' before git reset
> --hard in case I want such a behaviour.

What advantages does "git read-tree -m HEAD" have over "git reset" or
"git rm --cached <file list>"?
