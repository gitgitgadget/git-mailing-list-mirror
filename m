From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-daemon serving repos with repo.git/git-daemon-export-ok
Date: Mon, 3 Jan 2011 21:09:15 -0600
Message-ID: <20110104030915.GA24324@burratino>
References: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org>
 <4D224475.1090805@ecosensory.com>
 <20110103231153.GA10733@burratino>
 <4D225DFA.50805@ecosensory.com>
 <20110103235501.GA32262@burratino>
 <4D227ED7.9010407@ecosensory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Griessen <john@ecosensory.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 04:09:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZxHC-0006Kx-Nu
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 04:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab1ADDJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 22:09:29 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53182 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab1ADDJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 22:09:29 -0500
Received: by gyb11 with SMTP id 11so5385791gyb.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 19:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mZXNtlZVjVUMdHT8s6dJ9+LB3OkFo/IAcs3cgtGllRU=;
        b=kCf7mPcQzEA+sWv4b1nDAmFNX5olzIZMlrn9QCC9C1XI2ydGj3PwRVeR9T8mFFUWFH
         2eaJwM6u96mda3GUx+TE0B9xzkq/INeLXTG8JAsXbpIuvcDMb7iE+mUawS8HAinu2JvG
         oNH02tmCXppIlRBAHM8qJzJThwXvAcA2lOydM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oHfCCO2Fy6T8LIGOO9TsyqCZv95wLoe9fWUICbGtCGzwoUJoRJLhWuWuTJeqMYWtWR
         JhOLEMEB78Q3q3FbHsF54oMLjhZid+l67um0Z2ooaWLpP28TPyoExEKmAcbEe0CTQiPm
         8vDkz6Bcl2UB6AesXlAYEGOIRpOLRZU51VntY=
Received: by 10.151.105.9 with SMTP id h9mr19915403ybm.127.1294110568577;
        Mon, 03 Jan 2011 19:09:28 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id k2sm10430373ybj.10.2011.01.03.19.09.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 19:09:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D227ED7.9010407@ecosensory.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164471>

John Griessen wrote:
> On 01/03/2011 05:55 PM, Jonathan Nieder wrote:

>>> drwxr-xr-x 7 gitosis gitosis 4096 Dec 30 12:32 extrudator.data.git
>>
>> So the gitdaemon user (used by git-daemon-run) wouldn't be able to
>> access them.
>
> It would be able, since I used
> sudo strace -o strace.out /usr/lib/git-core/git-daemon --verbose
>	--strict-paths --user=git --group=gitosis /srv/gitosis/repositories

Also because the repositories are world readable.  I don't know what
I was thinking; I should get some sleep.

Thanks again for reporting and good luck.

Jonathan
