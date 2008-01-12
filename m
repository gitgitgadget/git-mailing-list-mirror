From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/5] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 12 Jan 2008 20:24:09 +0800
Message-ID: <46dff0320801120424v1b780a97x8a4ecfcfe8e52f7@mail.gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	 <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	 <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	 <7vejcnv3zk.fsf@gitster.siamese.dyndns.org>
	 <46dff0320801120148r1a760bcdq4b9dcdf31354d9e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 13:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDfPq-0007ih-Uo
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 13:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117AbYALMYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 07:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbYALMYM
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 07:24:12 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:12528 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYALMYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 07:24:11 -0500
Received: by py-out-1112.google.com with SMTP id u52so2105293pyb.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=P+NGnYAJGTuEgWPyHafjPm/0g09ok4QKFoW146wKamE=;
        b=hEtfZ89SPUPvq4Jc7aDBF6uHcbjxAfbtBHRoZtygjX0BAPiLmL+o/oWGdeUWil2QPZUFjxP8R1GuVA78FlZKgjLfPB/vT1EWKuIsL4uRP4UEyI7IxcgPtsMtvVn6uzcZJSxLb98/hVPBtH9ZIX9hyd2mUbKbZnDZ+7VIaiiKnIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JLLTpMcuywgf+6vWoN36c81CvfZ2CDJHzm90+YFxP1XMF8zyOiuxkoKlvN8lUNowm/vQe7CxA0uxke3mgSk6MTyG8XvZenUkkrID9KbGifSAuqwmF8TbYvDtdF/8+qq1Xi5ETmmfom0tcrogA/TOBIHA+3MOe1tX5USWYtBeWUY=
Received: by 10.65.119.14 with SMTP id w14mr9554236qbm.23.1200140649965;
        Sat, 12 Jan 2008 04:24:09 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 12 Jan 2008 04:24:09 -0800 (PST)
In-Reply-To: <46dff0320801120148r1a760bcdq4b9dcdf31354d9e0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70311>

> >
> > I think you would want to read full 40-char sha1_src and
> > sha1_dst with "while read", and keep that full 40-char in these
> > variables, and use them when calling rev-parse here.
>
> Hmm, precision is really a problem. However, "git diff --raw" will not
> always give full 40-char sha1, instead it will give sha1 with enough
> length. So maybe i can use the sha1 from "git diff --raw" ?
>
Oh, I'm wrong. It seems 'git diff --raw' will always give full 40-char
sha1 for submodule entry and abbreviated sha1 for blob entry.

-- 
Ping Yin
