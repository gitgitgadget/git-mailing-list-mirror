From: Aubrey <aubreylee@gmail.com>
Subject: Re: Quick question: how to generate a patch?
Date: Tue, 28 Feb 2006 01:18:03 +0800
Message-ID: <6d6a94c50602270918l323fe54al764469232de66503@mail.gmail.com>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
	 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>
	 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com>
	 <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org>
	 <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
	 <44033241.6070001@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 18:19:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDm0k-0000V1-NZ
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 18:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWB0RSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 12:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWB0RSF
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 12:18:05 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:63492 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751507AbWB0RSE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 12:18:04 -0500
Received: by wproxy.gmail.com with SMTP id 70so887990wra
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 09:18:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pc0Vp4I4bVeG0TWM26JMCso08hSJhPSP9ILEsp3U3zRDgwaqH93TxEi6EDKwEqZAmk44HpvC0Fz1jxVbL7f4E1shcdh8tkPvlg1k1EXdRSuiGr4gdHcOL2AYwqv0c6wVCuZIuGvdH96uGuH53tMEFVvmOKe8U5wdigzIfyQvMd8=
Received: by 10.65.158.12 with SMTP id k12mr1359296qbo;
        Mon, 27 Feb 2006 09:18:03 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Mon, 27 Feb 2006 09:18:03 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <44033241.6070001@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16866>

> Did you by any chance do chmod -R, chown -R or start an ntp daemon
> somewhere in between there (don't know if clock skews will be detected
> by git, but...)?

No, I did nothing between "git clone" and "git diff" except changing one file.
>
>
> Decidedly odd. What happens when you do "git update-index --refresh" and
> then re-run the "git diff > my.patch" thing?
>
Yes, "git update-index --refresh" works. After this command, I got what I want.
It's the diff in unified git format.

Regards,
-Aubrey
