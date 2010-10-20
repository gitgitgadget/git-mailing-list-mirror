From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] diff: handle lines containing only whitespace better
Date: Tue, 19 Oct 2010 23:38:41 -0700
Message-ID: <780B144B-03E0-4ED5-8E92-D4EB3CBBBF71@sb.org>
References: <1287549978-54280-1-git-send-email-kevin@sb.org> <7vzku9wfrp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 08:38:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8SK2-0003dW-Fh
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 08:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133Ab0JTGip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 02:38:45 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46559 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114Ab0JTGip convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 02:38:45 -0400
Received: by gxk21 with SMTP id 21so1362161gxk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 23:38:45 -0700 (PDT)
Received: by 10.150.197.19 with SMTP id u19mr625174ybf.131.1287556724884;
        Tue, 19 Oct 2010 23:38:44 -0700 (PDT)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id p30sm959698ybk.8.2010.10.19.23.38.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 23:38:44 -0700 (PDT)
In-Reply-To: <7vzku9wfrp.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159397>

On Oct 19, 2010, at 11:16 PM, Junio C Hamano wrote:

> Hmm, tests?

I checked, there seem to be no existing tests for the whitespace highlighting output. All the tests just use `git diff --check` to see if it was caught. And given that the problem only occurs when it's emitting the colored highlighting, I wasn't sure how to go about adding tests for this as I'd need to create an expect file that contains all the same ansi color codes, and I thought that might be a bit fragile or hard to do correctly.

Incidentally, I just realized the description of the patch is slightly wrong. The problem only occurs when the line contains at least one tab. Should I resend the patch with an updated description? I can also attempt to write tests if you can give me some guidance on how to deal with the need for ansi color codes.

-Kevin Ballard
