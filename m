From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 22:24:10 +0200
Message-ID: <bd6139dc0807281324k38198fffwd3b586394b354ed2@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728185604.GA26322@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807282008470.8986@racer>
	 <7vproxrcvu.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0807281310j16b4ef5alf9738ec0f3270ba0@mail.gmail.com>
	 <7vljzlrca9.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZHS-0004ap-BS
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbYG1UYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbYG1UYM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:24:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:22696 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbYG1UYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:24:11 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5949892wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vQYse7qaJI4oEllHDKJ3qwPo49DwJCb4r9d+ZZoU5Aw=;
        b=TvOOL/BOzoVFnLhJdVXnO08+b2XT9TGuOoRmswIgNp2R9ERw2J06W7MfnphFHEILCj
         0y7DTLT0oJnQTl5I4EfvU+7GrH7/Q0PDI1xtTyYK81nuYlwyaMT++DVfbpn/04zhaMGP
         bUWyFLVnKfumHWfnzeS2VDF/FZ/eEMASLwG2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=C5X8xioJP71U7uwrQphOnV0dPN6tvPlD58IwGkZReh18OYoFYtGhesWQdgFbxnKq4p
         hw80IUe7yjyjpqDFZAoW916AHxGHpAS5D4Ywd7EQ6/QVVfqo1c4Rolg5Jea6VgOK8nMt
         8RtrsfuU+iNcCFsfRLO1hH8XXrjBlJNhTBYnI=
Received: by 10.142.213.10 with SMTP id l10mr1746602wfg.197.1217276650856;
        Mon, 28 Jul 2008 13:24:10 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 13:24:10 -0700 (PDT)
In-Reply-To: <7vljzlrca9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90501>

On Mon, Jul 28, 2008 at 22:20, Junio C Hamano <gitster@pobox.com> wrote:
> "Sverre Rabbelier" <alturin@gmail.com> writes:
>> Mhhh, but the proposed strategy there was in response to the 'insane'
>> git-merge-theirs version, not to the 'exact opposite of
>> git-merge-ours' that I refer to now, yes?
>
> No.

Nanako Shiraishi's patch was not in response to the "git-merge-theirs"
thread, or I am missing something here....?


-- 
Cheers,

Sverre Rabbelier
