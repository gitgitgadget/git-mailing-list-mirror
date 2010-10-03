From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Advertising the Git User's Survey 2011
Date: Mon, 4 Oct 2010 01:29:21 +0200
Message-ID: <201010040129.22302.jnareb@gmail.com>
References: <AANLkTim1mLhQnJPT9KiinR4L3C=O9L=V9M3X9x7Cr+oC@mail.gmail.com> <201010031655.40521.jnareb@gmail.com> <20101003180743.GK328@kytes>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Xze-0004vR-CZ
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab0JCX3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:29:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47819 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab0JCX3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:29:06 -0400
Received: by fxm14 with SMTP id 14so1439314fxm.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 16:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tEmIMJX/aP9GNC3fePXdMs9EQf/DUfUPDDBa5j6cZJI=;
        b=TYos2iThG4Dq/l1uZ0xrGLqJWTs0YX8Qd4TyLy2G7IbHMZDGFcBBuI3Pw28E7S/ZV0
         fvjrafoBKbvdJvLL+/e6nziAqxPQxn80x+g9nCEuu9NaBLWzCDaONjE3eiJEA+V9HthH
         GyLIPUHTmdjdKPjIeWoIbrT85L/vP1aZ2R4oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D3fHd8rxDSaSt0IpnoXQ/07yQrNGRKk8kDifpFk616GQlvaOYlBoDN15PLE3Dv6dbO
         8xtilxc7OmfWBluo6G3Fz+05tiV1g4e8ewJQ5RzypfHyeYs2GTaVT6ed/QJ9dXRibE6s
         0agB3aIDhAJnwl79+oiQpzwlhbiGRcadLFQCc=
Received: by 10.223.125.70 with SMTP id x6mr7984591far.85.1286148544981;
        Sun, 03 Oct 2010 16:29:04 -0700 (PDT)
Received: from [192.168.1.13] (abwo152.neoplus.adsl.tpnet.pl [83.8.238.152])
        by mx.google.com with ESMTPS id r4sm1857858faa.43.2010.10.03.16.29.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 16:29:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20101003180743.GK328@kytes>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157947>

Ramkumar Ramachandra wrote:
> Jakub Narebski writes:
>> On Sun, 3 Oct 2010, Ramkumar Ramachandra wrote:
>>> Perhaps we can email survs.com and ask them?
>> 
>> Should I do it, or would you do it?
> 
> Er, why will they know who I am and give me this information? You've
> been in touch with them before, I hope?

Well, I sent a bit of feedback, bugreports and feature requests while
Survs.com was still in beta...

[...]
>>> I suppose we could always work out a way to display the results from
>>> the information Survs.com gives us.
>> 
>> Do you have any idea how to display such geographical information, and
>> what tool to use for that visualization?
> 
> A quick Google search pointed me to several tools that parse a
> plaintext file of (lattitude, longitude) entries and use the Google
> Maps API to plot them. I'm sorry, but I don't know much more about
> this.

What we have is the names of countries (which can be quite large) rather
than geographical coordinates.  Perhaps use color to mark countries on
the political map, or something?

>>> Nice histogram! How did we manage to do this in 2009? Did we use a
>>> custom-made application to do the survey?
>> 
>> I used a Perl script, which uses Text::CSV to parse data exported from
>> Survs.com in CSV format (and PerlIO::gzip to not have to decompress it).
>> Each survey page on Git Wiki, except for the very first survey, contains
>> link to file with such exported data.
>> 
>> For example for age it extracts digits from the response, and assumes
>> that it is number of years.  It also creates this nice table of ranges
>> that you can see in the mentioned section of GitSurvey2009 page.
>> 
>> I can publish this script, e.g. the one used for 2009 survey on the
>> GitSurvey2009 page, but it is rough'n'dirty script.
> 
> Sounds good- we should create a small repository that contains all the
> tools used, notes made, and results (in semantic format) of previous
> surveys. Embarrassingly enough, I can't read Perl myself, but I'm sure
> the others will find it useful. Also, isn't there some Perl module to
> use Google Maps API to draw that map?

Good idea.

-- 
Jakub Narebski
Poland
