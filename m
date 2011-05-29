From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sun, 29 May 2011 13:58:21 -0500
Message-ID: <20110529185821.GA13751@elie>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20110528230844.GA31498@elie>
 <alpine.DEB.2.00.1105290916470.28815@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 20:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQlC7-0004K9-J5
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 20:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661Ab1E2S6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 14:58:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47654 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab1E2S63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 14:58:29 -0400
Received: by ywe9 with SMTP id 9so1253782ywe.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7mm+6QoSqzb5hUtKVMWcGi/FuoPMkZJqXS9ylW9Q2LM=;
        b=V0oyg7Ht7pto+bfoemG3XUDzPk1a3Msu4+OvCZOmsDcoTKar+zuNK30KeuRN0lbPtl
         e69pHI7/u8UsVThfJnhCxusisxI5x91iKJn3JtFUxf/8lhiP5yQIVDuPufHSP5bYm//V
         dzfj6MooHc3RRCx3czBE5lWAJJH/8u8bZCY+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E7DGI/2KtSe/oBkd2Tm17FYJKQ64gnpR8jInJ4Nr0sSwF88Hrfh7G9GLbQndxQrHpo
         vUdJOb5fKnuPgOxpdSyu3WtmSl/7VWZ1DBLMoFkUuDSUHXigK9ydgXsC3w5aOVq1dd7Z
         pfhNk3ZIO8kUYURYrMY0cyEz80QDJ51VshpZs=
Received: by 10.236.78.99 with SMTP id f63mr4545281yhe.518.1306695509186;
        Sun, 29 May 2011 11:58:29 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id e48sm1959979yhk.42.2011.05.29.11.58.26
        (version=SSLv3 cipher=OTHER);
        Sun, 29 May 2011 11:58:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105290916470.28815@debian>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174699>

Martin von Zweigbergk wrote:

> I intended --discard to be used _instead_ of --abort. Do you think it
> makes more sense to have it as an option to --abort or was it just
> that the word "subcommand" confused you? I meant it as "subcommand of
> git rebase".

I agree that --abort-keeping-head is nicer than --abort --keep-head.
The latter was just a little easier to document.

Sorry, I'm terrible at names.  --forget, --discard, and --done have
the same problem of making the reader wonder what is going to be
forgotten and what remembered.
