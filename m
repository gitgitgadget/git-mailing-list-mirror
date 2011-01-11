From: Stephen Kelly <steveire@gmail.com>
Subject: Re: [PATCH v2] Introduce new configuation option to override
 committer information
Date: Tue, 11 Jan 2011 14:41:09 +0100
Message-ID: <AANLkTi=t98=4p=R2DXeCJ0OVPey8EtTLxHQ=3KfqrQpE@mail.gmail.com>
References: <igadki$4tb$2@dough.gmane.org>
	<1294568989-5848-1-git-send-email-artagnon@gmail.com>
	<20110109172431.GA7718@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 14:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PceTR-00081S-2f
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 14:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144Ab1AKNlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 08:41:15 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39177 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab1AKNlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 08:41:14 -0500
Received: by qwa26 with SMTP id 26so20957198qwa.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 05:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K9ITIGWhIXI2HJp354nJkHCkMyjGa6hJl4tn61ZsQn0=;
        b=SttBwboxUToyvBRbE3w1GohGg7nBNHY9sJX5fZJkMFlYBnRmkDApiBlqOaq9kgnZtt
         rv0BKES6Dqax5LSdevbcvN/M5St19tA9tWyVdouphtl2mz1GAroH+qxUtssMZwQAaixe
         D0vlQejIx3NELBcxSoPR/RxxASmad7PwWrokA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZcHPX3stXY2j2YFjVtdBihyJ0K5BbbrZ+0rqXkCMnvh3u4oIg7+cFGuTHZJMhQHBge
         +faz+eZHWG4tInc5HpSgj3F2T9I+s85jXtD0FgrById1mChrQAAUGj/kGn3PnqROnoEV
         Y2RunV5TKjNWyakTA0LqWAzfGLqE9iE9Bvos4=
Received: by 10.229.211.206 with SMTP id gp14mr6548438qcb.289.1294753269199;
 Tue, 11 Jan 2011 05:41:09 -0800 (PST)
Received: by 10.229.214.74 with HTTP; Tue, 11 Jan 2011 05:41:09 -0800 (PST)
In-Reply-To: <20110109172431.GA7718@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164942>

On Sun, Jan 9, 2011 at 6:24 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Ramkumar Ramachandra wrote:
>
>> The 'user.name' and 'user.email' configuration
>> options set both author and committer information. To solve this,
>> introduce 'user.committername' and 'user.committeremail' configurati=
on
>> options to override committer name and email respectively.
>
> Predictably, I don't like this idea at all. =A0How would we explain t=
his
> to a new user that is reading over gitconfig(5) for the first time?
> It makes the semantics of the committer and author name (that are mos=
tly
> meant for giving credit and a contact address) much more murky.

It's like the difference between who are you, and what is your log-in
identity on remote service X.

>
> Stephen Kelly:
>
>> In KDE the committer email address is used to be able to use keyword=
s in
>> commit messages to automatically close bugs.
>
> Is it impossible to fix this on the KDE side? =A0I would think a
> many-to-one mapping from committer identities to bugzilla account
> names could be a useful thing to have in any case.

I asked that before coming here, and apparently that is not possible.

Thanks,

Steve.

>
> Hopeful,
> Jonathan
>
