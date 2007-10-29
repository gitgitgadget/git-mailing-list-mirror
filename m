From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [BUG?] git-pull and git-merge don't support option --ff as the document says
Date: Mon, 29 Oct 2007 21:05:56 +0800
Message-ID: <46dff0320710290605r187ac5dq930b72ffade9e406@mail.gmail.com>
References: <46dff0320710280936g4b1022fcpab02e72b99afa0f@mail.gmail.com>
	 <8c5c35580710290014o5750214te5b20eaf6127de9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 14:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImUJp-0005dP-Tr
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 14:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbXJ2NGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 09:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755736AbXJ2NF7
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 09:05:59 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:5480 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbXJ2NF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 09:05:58 -0400
Received: by an-out-0708.google.com with SMTP id b36so201296ana
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=e4O+l/zyEgfr8ZGzTrmbod4oBDX2FVXsujRNtCuO5aU=;
        b=OT4BdgiS4UikZmBItmIXAf3FDob0wqv0MQzpMIlO5h/LQwSkmJh0ePApxS4RERhaRSvdx0fCfiehnbukon9vkAnp9PHwT4quyL+0bMzeArqzj4dB8BqTuov0TxZ5wX3WR2hC39DTjUOzRU/7ToS8B79gyS1zGKLSnMEIIJMtRvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T596Yzjp/t8pNJeNQKiteZYrvr4bHVjo8E2SjTkju1sDdtuOhykE6qD3rV1xSdNwpoe5wGOKVGLFRVk18EhID/t1N2BfJ9XSxxjtZQk1jaGEpErXOQyiJGH9x8FYuusZ+B3VHzC6b21Sj0GDzTl7CVYfGV+iWXtB69/x2ktRvZM=
Received: by 10.142.48.14 with SMTP id v14mr1224150wfv.1193663156174;
        Mon, 29 Oct 2007 06:05:56 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Mon, 29 Oct 2007 06:05:56 -0700 (PDT)
In-Reply-To: <8c5c35580710290014o5750214te5b20eaf6127de9c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62615>

On 10/29/07, Lars Hjemli <hjemli@gmail.com> wrote:
> On 10/28/07, Yin Ping <pkufranky@gmail.com> wrote:
> > Released git version 1.5.3.4
>
> --ff/--no-ff is not part of any released git version; you'll need to
> build the 'master' branch of git.git. And they're currently only
> supported by git-merge, not git-pull (the same goes for --no-squash).

see, 3x


-- 
franky
