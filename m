From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [JGIT PATCH 03/15] Add IntList as a more efficient representation of List<Integer>
Date: Fri, 12 Dec 2008 16:33:16 +0100
Message-ID: <bd6139dc0812120733o7c828532qbcd78c46a321fe6b@mail.gmail.com>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
	 <1229049981-14152-2-git-send-email-spearce@spearce.org>
	 <1229049981-14152-3-git-send-email-spearce@spearce.org>
	 <1229049981-14152-4-git-send-email-spearce@spearce.org>
	 <bd6139dc0812120243y2b1a3dddu4975162114280e17@mail.gmail.com>
	 <20081212151533.GM32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 16:38:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBA5f-0005xq-TM
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 16:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026AbYLLPgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 10:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbYLLPgo
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 10:36:44 -0500
Received: from mail-bw0-f13.google.com ([209.85.218.13]:48328 "EHLO
	mail-bw0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbYLLPgn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 10:36:43 -0500
Received: by bwz6 with SMTP id 6so3581403bwz.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=A9VT3/tTDh/FR8R6Zii5FwCV2ehm7Z3Zdo2N7Tfl/ZY=;
        b=tV9byHLi/r1OP2SqQgdRJ+XmhaWGHL1yT47lElxS3tx5kKAEFezuagERBDLTr4jbmB
         IyL7SqCexVszkzD+3eCBZnjfyudar9VDRhAUW2logPKbBHP4YGa6reYU83kY1Aeee70L
         l1zEAoMh/7touzPIlgm8pBry+AUWJ3NhP4YbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=GDYw/tGF5X5mMIualnBVzxi+L4lrNKx74hk7C6VrrDoxL9IvDXjWoOgGXRHVIqHB19
         eMhGUzWEgc7JQPWCc3aklBxsaMBgOG7IHVauVsJV2GgMfMTZ65uK04r6AVSUOIF3CpIq
         PsiDeMZ2nUNxsVU6gpp/NXX6VigNvpPL4DeEM=
Received: by 10.223.124.137 with SMTP id u9mr186177far.96.1229095996365;
        Fri, 12 Dec 2008 07:33:16 -0800 (PST)
Received: by 10.223.103.142 with HTTP; Fri, 12 Dec 2008 07:33:16 -0800 (PST)
In-Reply-To: <20081212151533.GM32487@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 8d3475271a6a9911
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102904>

On Fri, Dec 12, 2008 at 16:15, Shawn O. Pearce <spearce@spearce.org> wrote:
> Hmm, yea, good point.  But I don't care too much about the toString()
> in this case, its meant as a debugging aid and not something one
> would rely upon.  Hence I didn't think it was worth testing for the
> empty list, writing the first entry, then doing a loop for [1,count).

Fair enough :).

-- 
Cheers,

Sverre Rabbelier
