From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/2] Ensure git ls-tree exits with a non-zero exit
 code if read_tree_recursive fails.
Date: Mon, 25 Jul 2011 18:46:29 +0200
Message-ID: <4E2D9DE5.1050502@web.de>
References: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com> <1311519554-16587-3-git-send-email-jon.seymour@gmail.com> <CACsJy8Aa_=BvZOt58sM4dknVzvihH9OtHAS1aRxqPwNLxh0fkg@mail.gmail.com> <CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 18:46:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlOIm-0003Nb-CL
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 18:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab1GYQqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 12:46:35 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:55121 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab1GYQqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 12:46:33 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4288F1961A13A;
	Mon, 25 Jul 2011 18:46:32 +0200 (CEST)
Received: from [93.240.120.154] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QlOIa-000819-00; Mon, 25 Jul 2011 18:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19mPBFs9SK2BmvrC7JQMqme0V+uEiWUURySrfQu
	z2MEc/Hg5r/rxjYenblTrkHFMooYBnndU5G7iAFH/ISRKDIRO9
	I24t+ma6XyJoQDCC1DUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177801>

Am 25.07.2011 10:45, schrieb Jon Seymour:
> Fair point.
> 
> Everyone ok with this revision? If so, I will re-roll v4.
> 
> Jens: I added the variable back because the return statement with a
> ternary operator needed a line break. Let me know
> if there is a better way to format it.

Now the extra variable makes sense to me, so I'm good too.
