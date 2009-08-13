From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Thu, 13 Aug 2009 02:58:03 -0700 (PDT)
Message-ID: <m3skfwnihn.fsf@localhost.localdomain>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	<1250005446-12047-2-git-send-email-pclouds@gmail.com>
	<1250005446-12047-3-git-send-email-pclouds@gmail.com>
	<1250005446-12047-4-git-send-email-pclouds@gmail.com>
	<1250005446-12047-5-git-send-email-pclouds@gmail.com>
	<1250005446-12047-6-git-send-email-pclouds@gmail.com>
	<1250005446-12047-7-git-send-email-pclouds@gmail.com>
	<1250005446-12047-8-git-send-email-pclouds@gmail.com>
	<1250005446-12047-9-git-send-email-pclouds@gmail.com>
	<7v3a7xa6e5.fsf@alter.siamese.dyndns.org>
	<fcaeb9bf0908130020meaed129j5d6a4f04a6878bd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 11:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbX4q-0006TR-Rl
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 11:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbZHMJ6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 05:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbZHMJ6F
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 05:58:05 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:59280 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbZHMJ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 05:58:04 -0400
Received: by ywh31 with SMTP id 31so847750ywh.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lRF4FzVBAlekrazu8Xn262po7JygaibiTi2E/FYmDPo=;
        b=Ai5NqW93Tb68DToVMBB0z4MQXRolJ1FericwrZsJCrIpGaoFXN7D7EQXhZrO3v+kDB
         tdjmpGJ7Ln4BDx35xseYDPP0G3MtGAnTwsONCCiLpA+MU8WiSWdBBKeat4D5ynrOjDSN
         ouO3IokkkQzohj6+ok3HudeNb+TMLqyt9fQS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ciQCO75yQLXuOp5hstlogZ5OHyNovQdFQ/HVkt9czEU1RgSWhp5+WneLgJ1SOEzmrm
         dzo8C3JUHHMjezNMEN6sJoF20rqT57OOUHzxyUdtz/TR62MUzxdPEB7iwVpber/yyJG4
         ntPTY69UFkXUy2zsupghscwTWi+7IrNP5IBJc=
Received: by 10.100.78.16 with SMTP id a16mr781233anb.180.1250157484497;
        Thu, 13 Aug 2009 02:58:04 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.7])
        by mx.google.com with ESMTPS id d29sm367844and.18.2009.08.13.02.58.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 02:58:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7D9vxtg028255;
	Thu, 13 Aug 2009 11:57:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7D9vvtg028249;
	Thu, 13 Aug 2009 11:57:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fcaeb9bf0908130020meaed129j5d6a4f04a6878bd0@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125792>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 2009/8/12 Junio C Hamano <gitster@pobox.com>:

> > It could also require core.sparseworktree configuration set to true if we
> > are really paranoid, but without the actual sparse specification file
> > flipping that configuration to true would not be useful anyway, so in
> > practice, giving --sparse-work-tree option to these Porcelain commands
> > would be no-op, but --no-sparse-work-tree option would be useful to
> > ignore $GIT_DIR/info/sparse and populate the work tree fully.
> 
> Only part "ignore $GIT_DIR/info/sparse" is correct.
> "--no-sparse-work-tree" would not clear CE_VALID from all entries in
> index (which is good, if you are using CE_VALID for another purpose).
> 
> To quit sparse checkout, you must create an empty
> $GIT_DIR/info/sparse, then do "git checkout" or "git read-tree -m -u
> HEAD" so that the tree is full populated, then you can remove
> $GIT_DIR/info/sparse. Quite unintuitive..

Hmmm... this looks like either argument for introducing --full option
to git-checkout (ignore CE_VALID bit, checkout everything, and clean
CE_VALID (?))...

...or for going with _separate_ bit for partial checkout, like in the
very first version of this series, which otherwise functions like
CE_VALID, or is just used to mark that CE_VALID was set using sparse.

Food for thought.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
