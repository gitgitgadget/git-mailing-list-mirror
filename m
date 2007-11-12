From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Tue, 13 Nov 2007 00:39:34 +0800
Message-ID: <46dff0320711120839q7fc0542frd90a396237c144bf@mail.gmail.com>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
	 <4738784F.7010106@viscovery.net>
	 <Pine.LNX.4.64.0711121612250.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcKM-00066z-4h
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbXKLQjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbXKLQjl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:39:41 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:11192 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbXKLQjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:39:40 -0500
Received: by nz-out-0506.google.com with SMTP id s18so995783nze
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QxWH7Z/leDDcnrh/9nvkYKQS67eW3Y5+pAyJzcDNAIc=;
        b=UZmHvevNjvrPae2qN4IFmIxpId4nkGte4Q8hRzgVAcDePSnjZ/8bBQLSpDPlXh8ipvm8lm2B7mzat26fBpIBglyDJi/SA8M2n2Y6AGFLl0gCd4r/1pCnXNDa4vwjJMR6PuTP/c1ULHzkSsotiAXOfo0GBE6VbUToPt/P+tusYKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y548eT+HhIuDpj4etlbSyKkxv0rpzgGLrmJ9bncuoosVrlT8RFGws+6UNiwyJ9SeMz4EEtH6dGhag+BPOb50culJNzkypr64YKHrlcM4AwdU/2YqYttCws6B7XfFsHUhsAiTLgDSW4UGihb1FGBcUCfUjxOP0QE6ZitDNcXl5aU=
Received: by 10.141.83.15 with SMTP id k15mr2479466rvl.1194885574645;
        Mon, 12 Nov 2007 08:39:34 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 12 Nov 2007 08:39:34 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711121612250.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64657>

On Nov 13, 2007 12:13 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> >
> > There is already 'status.color', I suggest the configuration to become
> > 'status.submoduleSummary'.
>
> You could make this variable even a numeric one.  Saying how many lines
> you want to have maximally (-1 meaning unlimited).
Good idea.
However, there is a problem about limiting the lines of commit
summary: if there are 50 backwards and 50 forwards, and summary lines
are limited to 50 lines. How to display? 25 backwards, 25 forwards or
only 50 backwards?
>
> Ciao,
> Dscho
>
>



-- 
Ping Yin
