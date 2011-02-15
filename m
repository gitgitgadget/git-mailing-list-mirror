From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to safely remove a blob
Date: Tue, 15 Feb 2011 09:42:03 +0100
Message-ID: <AANLkTi=N15_2aDbw=x_m6rPWYdgwcBkn0LvmtZVt2W48@mail.gmail.com>
References: <4D5A358F.2050906@ilt.fraunhofer.de>
	<AANLkTinrV3hKEva5qnaLniP+VoO2trrTVsWcc6YoBQ=t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Rolf Wester <rolf.wester@ilt.fraunhofer.de>
X-From: git-owner@vger.kernel.org Tue Feb 15 09:42:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpGU8-0002pa-7w
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 09:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab1BOImH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 03:42:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62306 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab1BOImF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 03:42:05 -0500
Received: by bwz15 with SMTP id 15so214257bwz.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 00:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JrqFE7sCUeWIDStSV82GM369lHyLlP3nBlM2PSDRabQ=;
        b=AMQmFNeym+++J5JO3CwHR6aYcVbE5Q0+tDGIGmxxkkZnvI4ydK9iBMI54Kmv9yYv0i
         eQhQKG75pshNp1sDomhP2ucaMILv3i7BZNZ2iktKNDR+gFQi/SBR6HATEaFHlT3pwRKt
         gNaqIZ+R2ozK9W5IbnfXxvCzk+VeOq/7WercY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sEc3KahSJMjoOG7gt8fnrxK7YmmOI+zljPQ7xyBajSxoYo/TJuO4H7pSd5GCeY0853
         f2EsXnZ/ZcKjw10u3oJXLheE+dCJiaG2kmyzyqyhMO65K6iQTpu1O+Pj/hUB+3kdXz0f
         4ddYQQOf5/QJYukG+kTXuRwqErbTxoNSV+XRA=
Received: by 10.204.70.142 with SMTP id d14mr4327723bkj.13.1297759323850; Tue,
 15 Feb 2011 00:42:03 -0800 (PST)
Received: by 10.204.102.14 with HTTP; Tue, 15 Feb 2011 00:42:03 -0800 (PST)
In-Reply-To: <AANLkTinrV3hKEva5qnaLniP+VoO2trrTVsWcc6YoBQ=t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166826>

On Tue, Feb 15, 2011 at 09:40, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Tue, Feb 15, 2011 at 09:13, Rolf Wester
> <rolf.wester@ilt.fraunhofer.de> wrote:
>> in one of my git repos I found an 102 MB object that probably came in there
>> more or less occasionally.
>> Its a blob and I would like to remove it safely. I tried to figure out how
>> to do it but I was not very successful.
>
> Take a look at "git filter-branch". There is even an example which
> does exactly this (search for "git filter-branch --tree-filter").

... search in the manpage of filter-branch. Sorry.
