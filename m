From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Spec file for StGIT (or equivalent)
Date: Fri, 8 Jun 2007 13:21:58 +0200
Message-ID: <200706081321.59038.jnareb@gmail.com>
References: <200706080224.20493.jnareb@gmail.com> <b0943d9e0706080146n5f19beffi385e706f40146062@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 13:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwcSV-0000vL-4g
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967374AbXFHLQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967559AbXFHLQh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:16:37 -0400
Received: from hu-out-0506.google.com ([72.14.214.235]:4784 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967374AbXFHLQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:16:36 -0400
Received: by hu-out-0506.google.com with SMTP id 19so489227hue
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 04:16:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ai5n0RsUrQP2/D+bIzKMYwbe+fnSHcpIOnCkiQJsgeVudhyVsynuvMZLHqq8mi9NfIzQX6SsSUMznOrOgtQyVpStvRVUkBsUbeYWXX61RHW+MapZcYK0O+0w8NPuCz0EhmnEUaDk/ZGeiACnfocAQxWSbDDy4Ce8ZdpXpMd9F3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cmN2lIdYpRhKcdNthdz0vqAEiViv8GteUR9QVFNjwmqhjWpklATmHId14p0ChCuB9IFJkRaBIv+Z3HFnsRDGZiQG2JvrY7Q2DQhYX+8ztmeA7HbGjY6kXaMP1vFmEpyVp5jCPvKXx14evcEw/kGis0DdS66qJ0hb+SwItppoLuw=
Received: by 10.82.186.5 with SMTP id j5mr5131261buf.1181301394502;
        Fri, 08 Jun 2007 04:16:34 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 2sm9178225nfv.2007.06.08.04.16.33
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 04:16:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0706080146n5f19beffi385e706f40146062@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49462>

Catalin Marinas wrote:
> On 08/06/07, Jakub Narebski <jnareb@gmail.com> wrote:

>> I can see that stgit repository contains some helper files to build deb
>> package. How to build rpm package from current version of stgit?
> 
> python setup.py bdist_rpm

Thanks a lot.

> I have a release script that build rpm and dist, I should add it to
> the contrib dir.

TIA.

It would be nice to have the above instruction, as well as the one
using scripts in contrib/ and debian/ on how to build rpm and deb
packages in INSTALL
 
>> Is here main version planned to be released soon?
> 
> Yes, 0.13, in about a week or as soon as I clear some of the bugs in
> https://gna.org/bugs/?group=stgit.

Shouldn't this URL be in README (or BUGS)?

-- 
Jakub Narebski
Poland
