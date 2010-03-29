From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Mon, 29 Mar 2010 09:15:43 +0530
Message-ID: <f3271551003282045q1aea17dbm336ce2db8a11453f@mail.gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com> 
	<be6fef0d1003282025p4a472b79hb02959fea7481065@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 05:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw5w8-0007Xg-Lp
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 05:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab0C2Dqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 23:46:43 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:38148 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765Ab0C2Dqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 23:46:43 -0400
Received: by gxk9 with SMTP id 9so1310489gxk.8
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=7K/iEzyJWeMV30dfTD+zesZDp/tWCgLLbDDqZ7LDXkM=;
        b=RgK+t7hu1+DlqRjVW3fYSlWQ/wisON/v0lblG68YdLRHjkfJuDIqde5ly7eDNgdl7Z
         vbiUeh5ewg8i5NbK02OsNgxmldTjYNpUUOWSGQuCulBLkU16G2i0YZ0XdXaB6RPTcsgu
         9qTPaIIvt4Y+p97yNDmPOfRzHRfje4LbefEXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VpWj5jdf4/YRi+jec1AG6pCK+LdERrvZrNMUaoAeNX0zfigM264UPOAlQqKYKRDyuO
         GKjMDi4PP+KHmRnQZ2PVl5482hzEoHNepv7lph4YUqZdySRpfbqF34CmXaAMygp8DUMQ
         kfeyc4AGugq+EhOUGWrUDwIfrTMz0m2CpbSYc=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 20:45:43 -0700 (PDT)
In-Reply-To: <be6fef0d1003282025p4a472b79hb02959fea7481065@mail.gmail.com>
Received: by 10.91.10.26 with SMTP id n26mr3028994agi.0.1269834367047; Sun, 28 
	Mar 2010 20:46:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143431>

Hi,

> I think "family" is confusing. They're all symlinks of
> git-remote-curl, if I remember correctly.

Actually, there's no Makefile target called git-remote-curl. See
Makefile:1122 to Makefile:1126. They're copies in my build.

	REMOTE_CURL_PRIMARY = git-remote-http$X
	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
	PROGRAM_OBJS += http-fetch.o
	PROGRAMS += $(REMOTE_CURL_NAMES)

> But then, I suspect you'll be rewriting this portion, since Ilari's
> notes has a thing or two why helper names have the protocol in them.

Right. Thanks for pointing this out.

-- Ram
