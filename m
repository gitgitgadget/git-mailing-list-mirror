From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] run test suite without dashed git-commands in
 PATH
Date: Tue, 01 Dec 2009 22:25:13 -0800
Message-ID: <7v4oo9opti.fsf@alter.siamese.dyndns.org>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-6-git-send-email-mmogilvi_git@miniinfo.net>
 <m3fx7un7vb.fsf@localhost.localdomain> <20091202054956.GA2089@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 07:25:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFieb-0005jR-PV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 07:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbZLBGZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 01:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbZLBGZU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 01:25:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbZLBGZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 01:25:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 173FBA3F55;
	Wed,  2 Dec 2009 01:25:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cn6kaJLmkPvX0ics3mgctokOj+U=; b=EYufTH
	za5xxZYg5IRTBaAuExIxbrLR1U7slwn7kzNzEOI7YGqBGLRdQI5ee+8RrgpdkwG1
	UHGxykyD0saQB1K1q3mREtTj/dujsNpUn9p3ty0qaO8IrSQSYpU0K9Dhr1mx9+JY
	704NOJWVqTAr3O7Vkis77GAZ1z6yzpI936iNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t2Icy8c3ud+OVRbIcViMPBLnxJ61SYqi
	6nAI1gt/P9z6/pyWVYMy3rbmfcRHPFFMHEI660GVZsL5zKAU5t8C9JYiNK/6IK0O
	7g5LuZ1IePY5Tn1LvKlOHCVfp4dmPh7UgN5wtuOrYVTxXyH0xGf2r+50Z0f3JHB5
	lUKvom/Htc0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD521A3F54;
	Wed,  2 Dec 2009 01:25:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9B4C0A3F4F; Wed,  2 Dec 2009
 01:25:15 -0500 (EST)
In-Reply-To: <20091202054956.GA2089@comcast.net> (Matthew Ogilvie's message
 of "Tue\, 1 Dec 2009 22\:49\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76CF5C74-DF0B-11DE-8D9B-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134304>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> Junio, do you want me to re-roll the 3 bin-wrappers patches to
> include both this and the "@@ vs __" patch, or do you want
> to just add or squash them in from the emails?

I expect that very soon I will be paying much less attention to topics
that will not be in 1.6.6 (in fact, I maybe am already as of tonight), to
save my mental bandwidth to concentrate more on bugfixes and regressions.

Please re-roll and feed me complete patches for anything that are not in
'next', telling me which ones to drop from 'pu' if I have older versions.

Just FYI, earlier you said to me something like "I see you already queued
this to 'pu', ...", but please be aware that being in 'pu' does not mean
that much---not much more than being in the mailing list archive.  They
are fair game for rewriting, replacing and dropping.  I merely keep them
on 'pu' so that it would be easier for me and others to look at them than
having to hunt for them in the mailing list archive.

Thanks.
