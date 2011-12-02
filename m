From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Fri, 02 Dec 2011 08:49:25 +0000
Message-ID: <4ED89115.6040309@diamand.org>
References: <1322643817-13051-1-git-send-email-luke@diamand.org> <loom.20111130T155409-599@post.gmane.org> <4ED6809A.9020703@diamand.org> <20111130225813.GA11544@arf.padd.com> <CAOpHH-U3PF0v7EPqnO0FNxNKh+uF1GH=cnA_MA09SaQTxo0cDA@mail.gmail.com> <20111201040259.GA22189@arf.padd.com> <CAOpHH-UMdLpCPx1+D2dtQJs+=t1+0U2srKfTwBi-TEF4F7EDyw@mail.gmail.com> <CAOpHH-XL5OGpnihEgqnXqUUFsMxXn2wSdLadegnC1epg44vs8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 09:49:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWOoD-0006Ri-Jq
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 09:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab1LBItN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 03:49:13 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64241 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273Ab1LBItN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2011 03:49:13 -0500
Received: by lagp5 with SMTP id p5so40939lag.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 00:49:11 -0800 (PST)
Received: by 10.152.104.206 with SMTP id gg14mr7092049lab.41.1322815751193;
        Fri, 02 Dec 2011 00:49:11 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id ne3sm7715449lab.7.2011.12.02.00.49.07
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Dec 2011 00:49:08 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CAOpHH-XL5OGpnihEgqnXqUUFsMxXn2wSdLadegnC1epg44vs8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186213>

On 01/12/11 21:59, Vitor Antunes wrote:
> On Dec 1, 2011 4:03 AM, "Pete Wyckoff"<pw@padd.com>  wrote:
>> I see your point.  P4 labels are the only way that they support
>> tagging, apparently.  I'm okay with leaving label support in
>> git-p4.  And it will be nice if Luke makes it behave a bit
>> better.  But doing heroics to emulate cross-commit tags feels
>> like a lot of work, and the wrong direction.
>
> Agreed. Lets keep it simple.
>

I think I'm going to have to go away and do a bit more work on this. The 
existing label code is still quite buggy (or my understanding is 
broken). Either way I'd rather get it to the point where it actually 
works and passes all its tests.

The two issues I'm seeing are:

- two p4 labels covering the same set of files; only one of them gets 
imported.

- if you have a p4 label on a subset of files then it gets dropped 
(which is fine) but so do most of the other labels (as far as I can tell).

I think if this could be made to work it would actually be really useful 
though.

(Pete - I've found your previous email; not sure why I didn't see it 
before. I'll roll that change in with what I'm doing).


Regards!
Luke
