From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] When a remote is added but not fetched, tell the user.
Date: Sat, 12 Apr 2008 00:35:39 +0200
Message-ID: <bd6139dc0804111535y8073d22w79845341394c2067@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <1207869946-17013-1-git-send-email-g2p.code@gmail.com>
	 <alpine.DEB.1.00.0804111621080.31025@eeepc-johanness>
	 <20080411203501.7095b866@localhost> <20080411190816.GA17277@mithlond>
	 <7v4pa8rs00.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>, Gabriel <g2p.code@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 00:36:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkRr5-00052t-Ut
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 00:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757142AbYDKWfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 18:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757143AbYDKWfk
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 18:35:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:40939 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757141AbYDKWfj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 18:35:39 -0400
Received: by wf-out-1314.google.com with SMTP id 28so677236wff.4
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 15:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=U5VSI0fffPbOvatUu9RFcILEZla+zueSYaTLvXUOAjg=;
        b=AGko9bRgREZrNRPGqdo8SL0IAj2kYv3YxYL29s4tKgT1t1zOXcm6mLff2W2YbpUMiGeW5eZ05IpnUA8tR8Ro9I25SmgS/X5j7VOz4gC4a20VgCMUaAvo9mMD+DZUnFmFi/oe7umz7SGrEwjDtHsXx89mvPza8nCwfwUSNYWAB94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S/vV2YIWKOdIv9reubMX9W33hdnzwXUpOqB8kCsj8u/ZpPtDS5VKZ6lut7FoJBuINNC3kGXDwPODCrWuKUGANRNINd1Jrh6RxPjSZl1GVuYFv/vQuSnW8Ue80JMVwlv8Ibbj/sNgFXjfFlCC75gfn7qnP+eTaNOkY4Iey9+4WvA=
Received: by 10.143.17.13 with SMTP id u13mr967686wfi.69.1207953339199;
        Fri, 11 Apr 2008 15:35:39 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Fri, 11 Apr 2008 15:35:39 -0700 (PDT)
In-Reply-To: <7v4pa8rs00.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79304>

On Fri, Apr 11, 2008 at 11:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  If the user tells you not to fetch, the command should not bother the user
>  with excess messages, unless the user explicitly asks to, either.

I fully agree here, but is there a way for the user to do so?
Especially the beginning user? Perhaps in the form of a -v(erbose)
switch, but for that to be useful it would have to be present across
most/all commands and have the same (type of) result. That is, it
should provide the user with additional information on what they did
wrong/what they likely want to do from here.
In this case though I agree that, as Teemu pointed out, 'git remote
add' is a config tool. 'man git remote add' points this out more than
clearly enough for regular use. Maybe keep it in mind for the to-be
"git mind reading" functionality.

Cheers,

Sverre Rabbelier
