From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What does "properly support iconv" in git Makefile (NO_ICONV) mean?
Date: Tue, 5 Sep 2006 01:26:56 +0200
Message-ID: <200609050126.56423.jnareb@gmail.com>
References: <200609050108.57695.jnareb@gmail.com> <20060904231609.GA6855@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 01:27:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNq7-00054A-Ii
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 01:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWIDX0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 19:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWIDX0s
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 19:26:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:10596 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965030AbWIDX0r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 19:26:47 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1115605nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 16:26:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cLfbJtCRe62r1ViqTwBRFUF5WGaYOIprDJnTndwEPQorvWu11/ybaAyA0FFUKFmlXhKiUJpOb9LrEnEFT7z63u9EDfj1BpwLoO8wB6OxsUm/9qBmgrlfjIk1TT71eSkSgOHoUUlhEHl19sbFokkWySwPd7B4wSCtKYaUOvG6zyM=
Received: by 10.49.8.15 with SMTP id l15mr7118218nfi;
        Mon, 04 Sep 2006 16:26:46 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id r34sm9938085nfc.2006.09.04.16.26.45;
        Mon, 04 Sep 2006 16:26:46 -0700 (PDT)
To: "Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20060904231609.GA6855@ferdyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26452>

On Tue, Sep 05 2006 at 01:16, Fernando J. Pereda wrote:
> On Tue, Sep 05, 2006 at 01:08:57AM +0200, Jakub Narebski wrote:
>> To add autoconf support for checking if NO_ICONV has to be defined
>> (Define NO_ICONV if your libc does not properly support iconv.)
>> one needs to know what does "properly support iconv" mean.
>> 
>> The commit message of a commit which introduced this compilation 
>> variable (commit b6e56eca8a4eb74a86e9f2d99aa480c665458aa7) tells:
>> 
>>     Systems using some uClibc versions do not properly support
>>     iconv stuff.
>> 
>> At what exactly iconv fail? What should the test to put in
>> configure.ac check?
> 
> As far as I know, iconv stuff is not supported on uClibc. Thats the
> reason I sent the patch. Gentoo bug #115826 [1].
> 
> You should probably set it if you are building for uClibc. Not sure
> how you'd test that in configure.ac though.
> 
> [1] https://bugs.gentoo.org/show_bug.cgi?id=115826

Gaah, I have some problems accessing the Gentoo bug database.
Is the problem that iconv does not exist in libc, or it exist but 
misbehaves?
-- 
Jakub Narebski
Poland
