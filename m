From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Purging old history
Date: Sat, 31 Mar 2012 16:20:23 -0400
Message-ID: <CABURp0oYJOYvxK54A7e3J2N1V-0pDS_AAoRErXhg6pJ6ZW962Q@mail.gmail.com>
References: <17650-1333167969-40275@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 22:20:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE4n4-0004Th-3v
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 22:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab2CaUUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 16:20:46 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49012 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2CaUUo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 16:20:44 -0400
Received: by gghe5 with SMTP id e5so828533ggh.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 13:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qZcZMxpgAW3T1dXfq1FloaZdwIrMRrBTb8RJ+nZwtgM=;
        b=dDsADZZTRKxizad42BPZQZtY0T9Lfyg1GNtWHtTDJBUbjL5w30OmhSuPiOK03JmawA
         A5ZciGDojr2D1OKcd+Z2nN/z9C5SOE2A84D/U+JuZI8Tlq9XjWFkSWdkZZzTLL1oDpxQ
         PAlDM8cwJGQOm3dKqk5ja/UYNdeVRYBsywkhcSobPnFuWM4u6mh7NcQnKURqRyECFQPV
         epakaAnU4IBsrKm3UDfhHM8USw78J5c0DBJQHXW5l3lCH2Q6mwvbYAt+8xtjtaCY0XFS
         WM4jSDfYuOOWpay1kQY8wUZboGKqfiLMKrGMxWB1Gsj5HkN3Gn86Gapx7Mk//F32wNnN
         5z1g==
Received: by 10.236.193.101 with SMTP id j65mr2504745yhn.47.1333225244066;
 Sat, 31 Mar 2012 13:20:44 -0700 (PDT)
Received: by 10.146.207.6 with HTTP; Sat, 31 Mar 2012 13:20:23 -0700 (PDT)
In-Reply-To: <17650-1333167969-40275@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194462>

On Sat, Mar 31, 2012 at 12:25 AM, John M. Dlugosz
<ngnr63q02@sneakemail.com> wrote:
> Is there a simple way to delete old commits, say beyond a certain age=
,
> before putting it on the server? =A0The ancient stuff is not relevant=
 and
> there are a lot of binaries. =A0Some users may have trouble with an e=
xtensive
> download when syncing the first time.

You may also choose to absolve the old commits of past sins (binaries
and secrets) while keeping them in the history.  See 'git help
filter-branch' for the manual and some pertinent examples.

Phil
