From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Compatibility between git.git and jgit
Date: Fri, 01 May 2009 21:14:06 -0400
Message-ID: <49FB9E5E.30504@gmail.com>
References: <20090415182754.GF23644@curie-int> <alpine.LFD.2.00.0904151443030.6741@xanadu.home> <7vy6tj109a.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0905011616130.6741@xanadu.home> <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org> <20090502000123.GF23604@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 02 03:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M03o1-0005TH-CP
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 03:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbZEBBOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 21:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbZEBBOK
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 21:14:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:55939 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZEBBOI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 21:14:08 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1554786ywb.1
        for <git@vger.kernel.org>; Fri, 01 May 2009 18:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=vSx0KjB6Gjy/QC5RnMwoQffRh3kJyeZ0UTsVg/74QvY=;
        b=pqWpalByGDGpHNAYRmZNm+qsh2Z4hKKIiQ6VR7zqcHUcUHz3pNiyYeAa46GYdRefJm
         8oZXRfa3QQBk/1liApMq3rRsuLKtR/6iGnvJ+A3fQWnhfpR+9a/Y0/LgN5L8/d/fy0SK
         FrPO/ee9yBiLH7ViwlzTqYFyj97L1gqSbc16E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=GsL8vfrjb5lYaqgskQciiLD9+TD+mHlMW8p22p0ZA84NwnEmXtBfEigTEmT5grvvYv
         tyAQkLzwb9wwoo26Cvn5InHlwQlU4M5Udh4a8PvrVtomaVbFY4tWkLQa8M3cQKIkIBw6
         pBRo/xSy6X6i3F9qRTakWmBGlmP943473iRn4=
Received: by 10.100.110.9 with SMTP id i9mr7092012anc.130.1241226848144;
        Fri, 01 May 2009 18:14:08 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id d35sm4883549and.35.2009.05.01.18.14.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 18:14:07 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20090502000123.GF23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118114>

Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> The code looks correct, I am reasonably sure updated server-client
>> combination would work fine, and use of the capability mechanism means
>> other combinations like old pusher and new receiver, and/or new pusher and
>> old receiver, should be also Ok.
>>
>> I see Shawn did the same to jgit.
> 
> On an unrelated note, someone asked me recently, how do we ensure
> compatibility in implementations between git.git and jgit?
> 
> There isn't exactly a great notion of "a Git implementation can do
> X, Y, Z, and never does Q".  So its not like we have a compability
> test suite to run between the two systems.
> 
> JGit is really starting to gain some traction in the open source
> world.
> 
> A lot of folks at Eclipse are really excited about being able to
> ship a BSD licensed VCS.  Some of the Maven folks are really excited
> about being able to link JGit up to Apache MINA SSHD and have a 100%
> pure Java server solution for Git, that doesn't require native OS
> authentication systems.  Gerrit Code Review relies entirely on it,
> and some folks within Google are now using Gerrit Code Review and
> its embedded MINA SSHD/JGit server as their only Git daemon.
> 
> Thus far, our compatibility story with git.git has been, "it should
> work, uh, we think, because Shawn understands git reasonably well,
> and wrote some of JGit, so uh, yea....".  :-)
> 
> But I think in another 12 months we'll be seeing people running
> only JGit in many contexts, making compatibility between the two
> implementations somewhat more important than it has been in the past.
> 

[A non-answer to this implied question]

Usually one of the implementations is declared "the reference 
implementation".

[And another question]

Hasn't this issue come up before in the mailing list?
