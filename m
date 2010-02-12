From: david.hagood@gmail.com
Subject: Re: Git under Windows should warn or fail on entities differning  
 only in case
Date: Fri, 12 Feb 2010 15:02:48 -0600
Message-ID: <c246ad02f9dc741974dda45533bc83bd.squirrel@localhost>
References: <1265978433.7519.6.camel@chumley>
    <alpine.DEB.1.00.1002121412300.20986@pacific.mpi-cbg.de>
    <4B75908E.3060407@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"David Hagood" <david.hagood@gmail.com>, git@vger.kernel.org
To: "Pete Harlan" <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 22:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng2gY-0007mK-Rg
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630Ab0BLVER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 16:04:17 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:44677 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450Ab0BLVEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 16:04:16 -0500
Received: by iwn39 with SMTP id 39so278670iwn.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 13:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:message-id
         :in-reply-to:references:date:subject:from:to:cc:user-agent
         :mime-version:content-type:content-transfer-encoding:x-priority
         :importance;
        bh=pHE07oVWMemTTzkTeS1qjAWUSy7a+jfST1kTDuZqR4A=;
        b=dGVcdw5jGJtWw28sWv5tQVprKE3BB37gtp2JDPMR5LakWifiGzuWYm7KlrxB8ETVEb
         C+UgzDmawn0DVX/AP+HAfz1YxkPpC9QlcKwssphwk5aLzA6rMfLhXybvr6ZuLoWqQlj+
         w7lySThZ6EaNpwiFb+W+Sf5Q/iSxEeD1pCFOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:in-reply-to:references:date:subject:from:to:cc
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-priority:importance;
        b=E0FSl1V4Wgpkr0SMNs13kgMvigmNvuBU/3qp81X4QAQcw12OmhQfJjUPd/hx8Ql/BY
         Jiio7q5hPdbeerkx58z2aAb9VBRlMnuO26XU/zSy8xlNmE1uc9/Te19ecMlX4tWOPzAT
         G6n7vs7EITXs0oU0C8W1qHDUIy+g1LfyMWBWk=
Received: by 10.231.153.1 with SMTP id i1mr876671ibw.35.1266008655397;
        Fri, 12 Feb 2010 13:04:15 -0800 (PST)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.120.40.clradsl.sktc.net [64.71.120.40])
        by mx.google.com with ESMTPS id 22sm3224639iwn.0.2010.02.12.13.02.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 13:04:13 -0800 (PST)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id E9D91C7B8042;
	Fri, 12 Feb 2010 15:02:48 -0600 (CST)
Received: from deathwish ([127.0.0.1])
        (SquirrelMail authenticated user wowbaggr)
        by localhost with HTTP;
        Fri, 12 Feb 2010 15:02:48 -0600
In-Reply-To: <4B75908E.3060407@pcharlan.com>
User-Agent: SquirrelMail/1.4.19
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139746>

> On 02/12/2010 05:14 AM, Johannes Schindelin wrote:
> I didn't read David's patch as anything other than floating an idea.
It also gets the issue out there and searchable.

> It sounds like this is a (3), which is doing pretty well for an idea
> about how to change Git :)
If only I weren't working on a 15 man-year project that has a 4 month
delivery time, trying to keep all my sub-ordinates unblocked.
