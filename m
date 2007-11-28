From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 12:57:42 +1100
Message-ID: <ee77f5c20711271757h724d5fcep38f3c2354c54f20b@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 12:49:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKxZ-00050F-Mf
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:20:05 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxCGg-00088I-79
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 03:03:14 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxCFa-0004pq-CZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 03:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759584AbXK1B5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 20:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754935AbXK1B5o
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 20:57:44 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:35142 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbXK1B5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 20:57:43 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1072169rvb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 17:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Z2nIFLBEXHbxTc9JkLlWK0Ivxq7kAAHqVmbTskop3AQ=;
        b=JswIgRO6P3QVNW4TvjQ9IsDM8iPgr4QtyviFPSKrhPXrEZSqhr21IYnOjSv2ahaFg2pCnNWvYw8JK9EwY8FHVVAr+7Ypahs5gWZLSXpzkgW9EThBOWDASxYmN/CE1Qdm95N6fKv0xBqknG/0KLYVBdyQM6XyqUp3sagHUJDFxVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ybx+XBRFdVaWrLOcwnW/lNMcRGjnTqbuezMU9b3RHeSURsbtb+WTkQBMDSQTg/acMJCMzZoFsWPlcG4GTrmrHLMcS6OKdcBPQ8TkWTfR+yXtv7cRvLqIQN+4DTTCtmKUIk1Sq1gbs9IyJoxFJv+D8U2P2jCRCTJRsisjT+aMqGw=
Received: by 10.141.167.5 with SMTP id u5mr2319396rvo.1196215062176;
        Tue, 27 Nov 2007 17:57:42 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Tue, 27 Nov 2007 17:57:42 -0800 (PST)
In-Reply-To: <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.5, required=5.0, autolearn=disabled, AWL=1.500,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: EA7F24B5D1FCA0225B8EBB6DDF17D414C16459DE
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -54 maxlevel 200 minaction 2 bait 0 mail/h: 3 total 723625 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66290>

On Nov 28, 2007 12:49 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Rollback is too strong of name for this. Checkpoints would be better.
> The idea is to record the total system state at convenient moments and
> then allow moving back to the checkpointed state. The object store
> supports this, but the rest of the state in .git/* isn't being
> recorded.

rsync -a .git /somewhere/safe

I fear that what you ask becomes a chicken-and-egg scenario: where/how
is this checkpointing information going to be stored? If it's tightly
integrated with Git, what happens when you want to roll-back a
checkpoint-restore?


Dave.
