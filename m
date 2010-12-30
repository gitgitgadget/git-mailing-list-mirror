From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: custom diff - text file diary entries
Date: Thu, 30 Dec 2010 23:36:15 +1100
Message-ID: <AANLkTinAJ=Dzn6u7Xu=dqkzm+tiB2M_nGE2=EzRDnPEa@mail.gmail.com>
References: <AANLkTimPTYEWr0qQwYM4jmJSLcrLRt27GC0nTVgVzHK2@mail.gmail.com> <4D1C7979.9050400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 13:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYHkS-0000bC-4R
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 13:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab0L3Mgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 07:36:47 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43662 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0L3Mgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 07:36:47 -0500
Received: by bwz15 with SMTP id 15so11672673bwz.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 04:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=zGxgai6xis1ern9o79+STjNaB/pYI+9211irrNGHws8=;
        b=d3sPL6a/zGXLHEt8hQCHZDDQwgFZeV67dG1P7vop2m8tY1mowIoqgW73iztlCoo2U5
         aYHThgcfV6M2p1od+JL9ZRM3v3Tk4Uhp95JgY9EH+OHtpCVChtxl/UZKaKD09YKp3S3l
         0RS1dMSsT6DQv7ijgebn1xDfj+EfKcjIQGLAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        b=c6UbIMoz/X+Z0ZtBsX5U5z2CLyVv3Cncwf13uLY9KS0zoaEveoWbZ/08r9Yf4LtupG
         BkZwASeW3WW26bsNPOxEc3QuhNR0AubzLWuPD2Izb3VhT9myIjI52P3K9r/62ZkJYjn9
         mKlpmoSMTXKL5x6Zt0mr5MKniKtGAZ1CIvrTI=
Received: by 10.204.112.196 with SMTP id x4mr10717170bkp.133.1293712605669;
 Thu, 30 Dec 2010 04:36:45 -0800 (PST)
Received: by 10.204.112.210 with HTTP; Thu, 30 Dec 2010 04:36:15 -0800 (PST)
In-Reply-To: <4D1C7979.9050400@op5.se>
X-Google-Sender-Auth: W46gLqEp2KvqAahpHYJSWBYPgU0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164356>

On Thu, Dec 30, 2010 at 23:22, Andreas Ericsson <ae@op5.se> wrote:
> On 12/30/2010 12:33 PM, Zenaan Harkness wrote:
>> Problem:
>> Separate text file diary entries, committed in separate repos,
>> cause merge clash when pushed to central repo,
>> since git thinks the two entries are a single conflicting entry
>> (since they begin at the same location in the same file).
>>
>> What we need is two diary entries automatically detected and inserted
>> into the one file, one above the other (ordering is not so important).
...
> If you really, really want to use git for this, you could create your
> own custom merge driver. How to do so is reasonably well documented in
> examples and man-pages. You'll want to sneak a peak at the attributes
> page.

"custom merge driver .. attributes page"

Thank you very much for these pointers,
Zen
