From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] More friendly message when locking the index fails.
Date: Thu, 19 Feb 2009 15:12:47 +0100
Message-ID: <bd6139dc0902190612u7819bda9s50638ed46df5cb64@mail.gmail.com>
References: <7v63jn13qd.fsf@gitster.siamese.dyndns.org>
	 <1235048058-6181-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 19 15:15:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9g4-0002HD-FS
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbZBSOMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 09:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbZBSOMu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:12:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:44951 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbZBSOMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 09:12:49 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1195990fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 06:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=qoit2n2oi4DtE3cyIBiYSAZFBVSD1t0pzJFfOy2Qgjs=;
        b=I1OyAUYvbNB5Pdm23vJGYYbit9q0gcZ80nN1nbLYjjFf25FUqgRz4LZqPEpes9FdhS
         QpcyNckcAlFyEDs5pDF1OluYxZrZM9W+gIw14l4cytzrg2uB6LkgvgYwQoWMHRokg3UT
         xOejioyobaanG6zdZauQrzuQ1GsMuxDgqcBsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WRVEPm9VBMKNB7tdgxyvYnOoxhqIJBRLvwFfCpf8wIVkSh3aH0aWXKMkZSmdzRJII9
         LTuXwA/D+8Oyifgf6CboumRuQLnuevSqn6KQmhRi3v68VHnb/uGM4BgX9DrU0uHYNj0Z
         YYfv9hGTcwLNa3AwrqNoRJFvN/WgOB73calZ0=
Received: by 10.86.72.15 with SMTP id u15mr342377fga.8.1235052767972; Thu, 19 
	Feb 2009 06:12:47 -0800 (PST)
In-Reply-To: <1235048058-6181-1-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: 66100cdc639479f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110704>

Heya,

On Thu, Feb 19, 2009 at 13:54, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Just saying that index.lock exists doesn't tell the user _what_ to do
> to fix the problem. We should give an indication that it's normally
> safe to delete index.lock after making sure git isn't running here.

Surely we need a 'git cleanup' which will attempt to clean up such
mess, fail miserably most of the time and might even corrupt your
repository further! Oh wait, wrong VCS...

-- 
Cheers,

Sverre Rabbelier
