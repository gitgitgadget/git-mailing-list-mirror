From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 21:48:08 +0200
Message-ID: <bd6139dc0807281248m51997c58q5a7aaf3ac51ee7a@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728181424.GM32057@genesis.frugalware.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:49:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNYiW-0007qP-TV
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 21:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYG1TsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 15:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbYG1TsL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 15:48:11 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:9483 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYG1TsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 15:48:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1474979ywe.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eicXjewHESmoO5eCS6zU/WUMFBewBr31fuwXqjRYucE=;
        b=RBQ3v3I0mp3UdCO2TXRgbIEk9gZ90fueDyHPpIuDT3t1NaHLCmCLJWUVHzqvT3StzY
         bfIbtusnvNG7aQk/GKx2SZA9KL2sH4BnS3BpfUM2RjUIKfBt15+FuaqNZn4CDMhVgXbr
         oOSK8cHIMvRYJEZqa132phMDG4NBdHTK/TGz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=smts6jbm8SLrDt0eIzida80Xe1npxoJ3yxK3z3ZDrEdXE3C1Qy/JqXmMAKyw4hBUaw
         PPZhARuYBcPxmIhj5gtZoz07NHf26/AtGvRk2PzyfAMj1SCzv5f78SjtuREp3NCKXwe9
         JMm7oBlLDkBP0UFPtEoOkKW+CsPESYsOZMqOU=
Received: by 10.142.246.19 with SMTP id t19mr1742786wfh.55.1217274488637;
        Mon, 28 Jul 2008 12:48:08 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 12:48:08 -0700 (PDT)
In-Reply-To: <20080728181424.GM32057@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90493>

On Mon, Jul 28, 2008 at 20:14, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Mon, Jul 28, 2008 at 04:54:17PM +0200, Sverre Rabbelier <alturin@gmail.com> wrote:
>> So, in short: what does the list think about adding
>> "git-merge-theirs", that does (although possibly less 'hackish'):
>>
>> cat > git-merge-theirs << EOF
>> #!/bin/sh
>> eval git read-tree --reset -u \\\$\$#
>> EOF
>
> Isn't this the stupid one?

No, the stupid one did "take all non-conflicting hunks from our side,
and any for conflicting hunks, take theirs", which was rather silly I
must say, although I have heard one use-cases where it makes sense (no
I don't think we should have a git-merge-theirs-on-conflict).

> It's perfect for my testing needs, but this is not something that people
> should ever use on a real repo.

What about the use-case I described in my first mail?

-- 
Cheers,

Sverre Rabbelier
