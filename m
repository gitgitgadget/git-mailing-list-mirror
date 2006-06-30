From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.pm
Date: Fri, 30 Jun 2006 02:29:12 +0200
Message-ID: <200606300229.17607.jnareb@gmail.com>
References: <20060628183557.GA5713@fiberbit.xs4all.nl> <e81jr5$l1c$1@sea.gmane.org> <1151625780.10358.13.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 30 02:29:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw6sw-0002RN-RZ
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 02:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWF3A3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 20:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWF3A3T
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 20:29:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:41963 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964825AbWF3A3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 20:29:16 -0400
Received: by nf-out-0910.google.com with SMTP id m19so37915nfc
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 17:29:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F84C5k1Y4+zvhAMY8OrqItEvV6lAQaGrIoSBMoKXBq8UqteE0IydKN0XYxCFdeQgwn++ZqfvKUTLJ6+OB6LFWZqN4HpE39ZCupHl4lHY5MOPM/hUaZBLAitzvQivFF3dnOP6CAquG9WCenAXP24fwewozgdHlc4QrLIKE0ZHGp8=
Received: by 10.49.43.8 with SMTP id v8mr183861nfj;
        Thu, 29 Jun 2006 17:29:15 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id a24sm941958nfc.2006.06.29.17.29.14;
        Thu, 29 Jun 2006 17:29:14 -0700 (PDT)
To: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <1151625780.10358.13.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22935>

Pavel Roskin write:
> I don't have the newsgroup access, so I'm copying to the mailing list
> instead.

Newsgroup should be tied to mailing list, so messages on newsgroup 
would appear on mailing list and vice versa. Patches were sent to 
mailing list.

>> I'm trying to do inobtrusive _optional_ autoconf support in the patch series
>> beginning with
>>   Message-ID: <200606290301.51657.jnareb@gmail.com>
>>   http://permalink.gmane.org/gmane.comp.version-control.git/22832
> 
> The problem with optional support is that you suddenly have two
> alternative mechanisms to adjust the build to the system, and both
> should be kept in a  working condition.  But it's a good first step.

The idea I started working with autoconf was to be able to say
%configure in .spec file. Then I thought that it would be nice
to have --without-expat, --with-curl=PATH etc. options. Then...

Additionally, optional support would be easier to accept I think.

[repeated]
>>   Message-ID: <200606290301.51657.jnareb@gmail.com>
>>   http://permalink.gmane.org/gmane.comp.version-control.git/22832
> 
> The link doesn't show the "@" characters correctly.  Maybe somebody
> could establish a git repository?  Ideally, the autoconf changes should
> go to one of the Git branches.

Try yet another git mailing list archive:
  http://www.gelato.unsw.edu.au/archives/git/0606/23225.html

I'll try to publish changes at
  http://front.fuw.edu.pl/jnareb/scm/git.git/
  http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi?p=git.git
after I learn how to setup ssh proxy or equivalent...

-- 
Jakub Narebski
Poland
