From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: get upstream branch
Date: Tue, 9 Dec 2008 07:46:25 +0100
Message-ID: <bd6139dc0812082246u59164cf6tb20f8c98ede7b666@mail.gmail.com>
References: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com>
	 <7vljup6hdf.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 07:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9wNk-0000mX-8u
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 07:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbYLIGq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 01:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYLIGq1
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 01:46:27 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:60018 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbYLIGq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 01:46:26 -0500
Received: by yx-out-2324.google.com with SMTP id 8so627036yxm.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 22:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lm5iqnU4HmsZb8Wmnk0AiKODbl9Ae42sBLNcR/K53LQ=;
        b=OSgMeUIEfoTEc+R/uJlf3AYQkHfNtD3xGNxrI2YAJ+r9B7Sjvf2wCGUWdFuWpDJzX0
         XASngULCO5Qv2FxlT5r2s6a5GwJPEf2Ekgv6agiKENQIcmGD7F7syK47faef9RMhSzs1
         Z+j4MwEbZgdxpTmEIYtLbR92sFVrMqclXwOkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=jCaEzkY2Z9p+KUazvf6MmgYLodYsYp1nI7m8XzVhFmlIU6BUZcs+s7bdmgDWp5XOc9
         yutLO/3j5IygUoM7CYbbn1hAKsg9fK5C+Af8nbz24v+DeGEFEL3HzhuRtvBiaeGtQBZE
         l4UIdgZgpYHrFj43Ogpvdsi4T93Q2lCZZm8bU=
Received: by 10.150.230.15 with SMTP id c15mr4882009ybh.164.1228805185540;
        Mon, 08 Dec 2008 22:46:25 -0800 (PST)
Received: by 10.151.108.18 with HTTP; Mon, 8 Dec 2008 22:46:25 -0800 (PST)
In-Reply-To: <7vljup6hdf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102603>

On Tue, Dec 9, 2008 at 06:35, Junio C Hamano <gitster@pobox.com> wrote:
> This should give "git branch -v -v it" to show the remote tracking
> branch that is merged when "git pull" without any other parameters is
> issued while on branch "it".

But won't that leave Jeff Whiteside in the same position he was
already? As he is writing a GUI having the functionality in 'git
branch' is not useful, what with it being porcelain and all.

-- 
Cheers,

Sverre Rabbelier
