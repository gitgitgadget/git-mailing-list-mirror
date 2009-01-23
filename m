From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 09:08:44 +0100
Message-ID: <46d6db660901230008q418f3d3bsc68ca4e9d675cb36@mail.gmail.com>
References: <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
	 <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 09:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQH7E-0001f3-Jp
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbZAWIIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 03:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZAWIIs
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:08:48 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:64954 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbZAWIIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:08:47 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1106053fkf.5
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r0lc6bZrGUcX7lmQ/jxkW0FAUm2oJkIIqVP/ibfdcZQ=;
        b=H1Fa5+tvLsMkaUNIJRAAQxFOX4yyur0Cjh7Y7S+u/OJYjyqLFUWSXySbORKpTwDv8k
         /LA+thpyaAJR63iOgbzDNn0tmvh5upiSwDynQM9crRlnQpSgJNuXUJuybZEBzw7ZJL4s
         MpnLBAm4VaayCXsHprdHRCY7zT5pEPsPrsOgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DuUN0ho+e7FDb1pVcAQveiiDm1Kc64K32kn1xbw7LXmmf8jeC6xYIUxnqleaDiGa14
         YHZUoOsfxEAMTt++Zrem3EpjVnnerexkm/5k/e8+t9h/0z8MN6h58Q7siaqVtglVrWUm
         Jklo1n0/FxiuCZfM9cSpqelDfAjAFGbn+WndE=
Received: by 10.103.193.12 with SMTP id v12mr828533mup.23.1232698124969; Fri, 
	23 Jan 2009 00:08:44 -0800 (PST)
In-Reply-To: <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106853>

On Fri, Jan 23, 2009 at 1:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian MICHON <christian.michon@gmail.com> writes:
>
>> I'd like to force the commit date to match the info/date from the time
>> I received the email (and therefore always get back the right
>> sha1sums).
>>
>> is this possible ?
>
> "am" being a tool to accept patches written in some past to faithfully
> record both author timestamp and committer timestamp, what you seem to
> want is outside of the current scope of the tool.
>
> A patch to butcher "git-am" to copy GIT_COMMITTER_DATE from
> GIT_AUTHOR_DATE and export it should be trivial to implement, though.
>
> Perhaps something like this totally untested patch.
>

I love this idea. I'll try to test it asap. Thanks!

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
