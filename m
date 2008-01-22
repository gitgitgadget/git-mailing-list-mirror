From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 22 Jan 2008 03:27:42 -0700
Message-ID: <f9d2a5e10801220227i6dfb6185g555911f0d999fa60@mail.gmail.com>
References: <478D79BD.7060006@talkingspider.com>
	 <86hcheig3n.fsf@blue.stonehenge.com>
	 <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org>
	 <478E3D8E.1090300@talkingspider.com>
	 <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org>
	 <478EEAC4.2010006@talkingspider.com>
	 <20080117151725.GC2816@coredump.intra.peff.net>
	 <478FA8B0.2000205@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 11:28:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHGMY-0007qm-Sh
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 11:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172AbYAVK1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 05:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756927AbYAVK1p
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 05:27:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:47665 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbYAVK1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 05:27:44 -0500
Received: by nf-out-0910.google.com with SMTP id g13so394948nfb.21
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 02:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mZwQtmT8FKlIfi5rnI4nVhqsPeQ61TnZ7QbRshSYigU=;
        b=iKQ5jmF2GQd9GvTkl+nYSzQ13ZIF6rQyf8s5RkSaA7izzAESZBcrEo5Wbth1c+dVMeFsZtwhE++RX93R53Tiq7YVlcNuBFNHp53R4X3QjMKC/VKiIF1c3D0/wl99qW1ycJA2y2NRGsMqh5Kc0TCe6b4vXIP1ui1N6TrVHd02p4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xqx6B7t4Eat9qAWxKEXaTz7qoms/R+yLHOSR+FTzby7SGrlQPONi7CPU6qoRzZ+L4OWTaDCx21ifJEGywgUefmmKEZDaZ4XRlnuklWR1VLZtC1/2KW7PCY+PZSZ4xV0BJMsbnU9mUP3/9BXwzDQcnOWz1RtRTK0FqHPFUTwBMiM=
Received: by 10.78.176.20 with SMTP id y20mr10751403hue.36.1200997662423;
        Tue, 22 Jan 2008 02:27:42 -0800 (PST)
Received: by 10.78.41.16 with HTTP; Tue, 22 Jan 2008 02:27:42 -0800 (PST)
In-Reply-To: <478FA8B0.2000205@talkingspider.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71441>

> Linus posted a response about deployment and development being
> separated, so I had to point out why that doesn't work for web apps in
> interpreted languages.
>

If your primary concern is preventing information leakage, then a
publish model is absolutely what you want. You definetely don't want
some random intermediary file out on the server, or some file that was
never checked into source control.

By publish, I don't just mean to the public server, I also mean to
whatever development roots you have.

With a good publishing model and a good SCM, you also get
reproducibility and testability as well. Its easy to ensure that what
is checked into source control is what you are testing, and its easy
to rollback production servers to a different version.
