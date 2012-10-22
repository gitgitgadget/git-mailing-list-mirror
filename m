From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Sun, 21 Oct 2012 21:59:36 -0700
Message-ID: <CAPc5daUJ9zZXci=N+v819FsMKvEaY7ar6xwG9TRt0CP=HBzbZQ@mail.gmail.com>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
 <7va9vxq5gp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, spearce@spearce.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:00:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQA7W-0000uJ-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 07:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab2JVE76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 00:59:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49146 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab2JVE75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 00:59:57 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2073402obb.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=g+O2McgsJ+xO37eY/8XrSV65UTc3/gpTMLa4FxeyqCc=;
        b=MGTU23JvYvRy4rstySrT3ATbekD2VZtuUOHb9/kXYaBUTqX//2aHfEsvPNkVvs50Cf
         eOM3Us2t3srZUoN5M4KCJVqcswzhF6FyfWkYZQnJVkEeSldfCGIVERagsmEClTykzuc9
         UoKH4UHPgFqn3qxxpmBFxkBXOSntSW6r0z+PRH8oxo/GCVWWRS+zl6Uh1rC2Ho4PrwzN
         d4JHjH/rYdTja75BeJCBV83QK1M4Xy88gDPcrHO65A+QsMLeWPA3LiL6kasMASIFTdeH
         hM5iFW9jdZiYrczsczho7qFf+vRtSu5L6EaPb/QwhpJrnW8loP/ASdiY8NFhPr2libBi
         cRSA==
Received: by 10.60.171.164 with SMTP id av4mr7096481oec.59.1350881996892; Sun,
 21 Oct 2012 21:59:56 -0700 (PDT)
Received: by 10.60.77.72 with HTTP; Sun, 21 Oct 2012 21:59:36 -0700 (PDT)
In-Reply-To: <7va9vxq5gp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: TZbIWQvQ4V5Y4c_pk5lzd_nrNvU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208175>

On Sun, Oct 7, 2012 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I and Shawn helped privately somebody from Gerrit circle, where the
> initial ref advertisement is a huge problem (primarily because they
> add tons of refs to one commit that eventually goes to their
> integration branch), to coming up with a problem description and
> proposal document to kick-start a discussion some time ago, but not
> much has happened since.  Unless I hear from them soonish, I'll send
> a cleaned-up version of the draft before I leave for my vacation.

Which I forgot and never happened. Here is a link (not cleaned-up)

http://tinyurl.com/WhoSpeaksFirstInGit
