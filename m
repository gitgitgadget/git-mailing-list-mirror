From: Tong Sun <suntong@cpan.org>
Subject: Re: Mirror plain directory under git
Date: Fri, 24 Sep 2010 11:24:55 -0400
Message-ID: <AANLkTimYSBPvfAJH7HG+zuo6G4OEQ359t=XL3EncMhy9@mail.gmail.com>
References: <AANLkTi=9nqfzR-Zo85LieBuhv97oudCVZCex8ZL3mM0t@mail.gmail.com>
	<20100921075621.GA27575@nibiru.local>
	<201009241036.45388.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Enrico Weigelt <weigelt@metux.de>
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 17:25:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzA92-0007Ae-6O
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 17:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793Ab0IXPY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 11:24:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33052 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab0IXPY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 11:24:57 -0400
Received: by wyb28 with SMTP id 28so2011644wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=RnjnJ9y2WYXutXnUKyHboNAu1zrCWfP38971mrTxj6o=;
        b=wB10J+7LHKKG3NSaVXKP7nV73dIHA/TKZXzyn7t0YZNOWXNlSQikiHka0rnqKzeLau
         7sUClVnwc10nYAsaMqHX7BGbCSlAs0Z+l/DQvD1q83nuccx4FYlmmFEs2h7W45bRv/3x
         oeE3S8tk+ajrjIQkVEGXepW4pwhwe2/CmEp+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=Tq/f/IwxeU8yqVLtxsbKy0BpTbj617dvsaDvh7VLX67qBNWH6odZPIRVxpWuUZ8+Sr
         fXueJDDeXW/wPBK6ajGgwckc5O1OUzyxjnJFif43gsTltcf0Kr5fxwX/UQz4MNBCNJZw
         XY3ooU3xQ0X/Wzd8NQVY42VwbB6XPnkLQSV0M=
Received: by 10.216.22.70 with SMTP id s48mr2232894wes.27.1285341895517; Fri,
 24 Sep 2010 08:24:55 -0700 (PDT)
Received: by 10.216.180.81 with HTTP; Fri, 24 Sep 2010 08:24:55 -0700 (PDT)
In-Reply-To: <201009241036.45388.ComputerDruid@gmail.com>
X-Google-Sender-Auth: WJkesS9oQjjP1j7JJlsbsjxWtJU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156997>

First of all, thanks a lot Enrico for your answer. I was just about to
gave up, and start coding for rcs. Your answer is extremely helpful.

On Fri, Sep 24, 2010 at 10:36 AM, Daniel Johnson
<computerdruid@gmail.com> wrote:
> I know nothing about the subject matter of your email, but the date appears to
> be wrong on this email message, hiding it back further in the history than it
> should be. Just a warning, as the last few emails you sent all seem to be like
> this.

Ok, I took the liberty to look into the issue, and it seems that,
Enrico, it's your mailgate.caprica.metux.de mail gateway that is
causing the delay -- taking 3 days for your email to come out of it:

Received: by x1.dev; 24 Sep 2010 12:07:27 -0000
Received: by 16.mx.develooper.com (qpsmtpd/0.80); Fri, 24 Sep 2010
05:07:22 -0700
Received: by mailgate.caprica.metux.de (8.14.4/8.14.4); Fri, 24 Sep
2010 14:08:05 +0200
Received: (from uucp@localhost) by mailgate.caprica.metux.de
(8.14.4/8.14.4/Submit); Thu, 23 Sep 2010 22:42:59 +0200
Received: (from weigelt@localhost) by nibiru.metux.de
(8.12.10/8.12.10) id o8L7uL3d031552; Tue, 21 Sep 2010 09:56:21 +0200
Date: Tue, 21 Sep 2010 09:56:21 +0200

HTH

Tong
