From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial 
	branch
Date: Wed, 11 Mar 2009 09:52:28 +0100
Message-ID: <4d8e3fd30903110152m1b52de30ge630d6b9f6a4c7fe@mail.gmail.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
	 <1236040414-19089-1-git-send-email-torarnv@gmail.com>
	 <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
	 <loom.20090309T143413-334@post.gmane.org>
	 <94a0d4530903090901o6e8c2a40k676387f90ee461b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torarnv@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 09:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhKCS-0000q5-E3
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 09:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbZCKIwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 04:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZCKIwc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 04:52:32 -0400
Received: from mail-bw0-f178.google.com ([209.85.218.178]:41641 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbZCKIwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 04:52:31 -0400
Received: by bwz26 with SMTP id 26so1835763bwz.37
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d1uBAeG4FdQvFs9JNzn8Ha9zvnJPmLMADI3FndFZG3Q=;
        b=TvnIKV126464JJI6bDNVr1ZUPXXuBnZzyKtzARXL25NBqZNICmBNewAyJo/87NwhX4
         jNMdRbO0IZUsm6vnxpU/1u/7enysBKUXMTU0iGkOCZTeO9lqH9AqPKn9YK/5Wp+5zsKN
         WsiudJmvFrSkfGPgbxLCjgwURaRsR5/xuuxec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xPTaPFO3tWTQMVQ2Oq9sweiVKkqirfzSz9pdpyBdTNDu4hjxg6L53LFEC474r+qHKF
         iq0/oJR1wPtteZPkyw+QYHH17dBqbMDzsBciO2/USIRQA9KyZwVHRYi9ryrHOXDX3opc
         Jo+yPPmGo2l+eDQbYjsNKZ1AcpR320myopvUk=
Received: by 10.86.95.8 with SMTP id s8mr5777270fgb.79.1236761548150; Wed, 11 
	Mar 2009 01:52:28 -0700 (PDT)
In-Reply-To: <94a0d4530903090901o6e8c2a40k676387f90ee461b3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112892>

[restored the CC list]

On Mon, Mar 9, 2009 at 5:01 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Mar 9, 2009 at 4:39 PM, Paolo Ciarrocchi
> <paolo.ciarrocchi@gmail.com> wrote:
[...]
>> I wrote a comment about the --branch approach a couple of days ago, dunno why
>> but this thread never reached my inbox (replying via gmame web interface).
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/112527
>>
>> As I wrote in my post a friend of mine, new to git, was looking for the
>> possibility of cloning a repo and automatically checkout a specific branch.
>
> Yeah, I also would like this option... one-liner for people that don't
> know git at all.
>
> me: you want my code? just run this command.

Yes, that is what my friend was lookin for.

I told him to use the following procedure:
$ git clone -n URL
$ git checkout -b foo origin/bar

He is now an almost happy git user :-).

That being said, I see the following command as an improvement over
the actual GIT UI:

 $ git clone git://URI -b bar


Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
