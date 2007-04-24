From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: gitattributes
Date: Tue, 24 Apr 2007 18:18:15 +0200
Message-ID: <81b0412b0704240918t70bfb3bt5f0e6e85028be5e6@mail.gmail.com>
References: <1f6632e50704240436l4a81d8c9s1bbf95a7892db68c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthias Kestenholz" <lists@spinlock.ch>
X-From: git-owner@vger.kernel.org Tue Apr 24 18:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgNih-0005fR-Ll
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 18:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161807AbXDXQSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 12:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbXDXQSV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 12:18:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:16905 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbXDXQSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 12:18:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2254712wxd
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 09:18:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NOUIxD5cBJo2e6pw7obKZr9/yn2Lf127KVPJ7/pdVPt+XbxCluFUxqHKgXcGqa2XwQTaUHBHWsJ7Y1059wpCU2wjXEl4UEOhdcEiNoPwrujP1JtHfCqOuyThs21cexhgIhGuovSVxP2PN4An2L365HAa9743hrtgo6gUlTtx0BE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cIFXnvGT/6PGlG+cWjTlIxPpPDYeCTmQ3v2kvJSeHQiGuUXUQjC0R6Rfy2V5pqGv2mTh0+4H81XtyFKpJim86petGSvGOwyik6fPLecURnjHNb3FysuBCQgb587AjQWZoPkikOipDHFAHurtzN+AW5LOQ3fy/CTb9oby+IOkwfw=
Received: by 10.90.95.11 with SMTP id s11mr1990396agb.1177431495188;
        Tue, 24 Apr 2007 09:18:15 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Tue, 24 Apr 2007 09:18:15 -0700 (PDT)
In-Reply-To: <1f6632e50704240436l4a81d8c9s1bbf95a7892db68c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45466>

On 4/24/07, Matthias Kestenholz <lists@spinlock.ch> wrote:
> The .gitattributes system together with input/output filters has already
> proven exceptionally useful for me. I've got some co-workers which
> do not seem to care about CRLF line endings or whitespace damage.
>
> core.autocrlf = input
>
> and
>
> [filter "whitespace"]
>   clean = stripspace
>   smudge = cat
>

Why didn't --ignore-space-at-eol, -b and -w work for you?
