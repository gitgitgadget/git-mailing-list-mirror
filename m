From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 1 Jul 2008 22:21:11 -0400
Message-ID: <76718490807011921o3ad1c0efmbfd819eae012865@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
	 <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
	 <20080701095117.GC5853@sigill.intra.peff.net>
	 <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
	 <76718490807011910p37ac9bcbjf9fa9748a2eb2e@mail.gmail.com>
	 <c376da900807011916j5a3032een4587619535061b72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Adam Brewster" <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 04:22:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDrzJ-0006Sz-6l
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 04:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730AbYGBCVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 22:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179AbYGBCVN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 22:21:13 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:8190 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbYGBCVM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 22:21:12 -0400
Received: by py-out-1112.google.com with SMTP id p76so97861pyb.10
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 19:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eHyB593pM4kuiMuHbKyU4cKKNeru7zK6bhMpbGFRdXo=;
        b=gAcgPBcXk7vXMdKmFJoTrisSJR1vt+qXmSi3s0mTLUnBCrTbjxxOT2zAwfYwpmRDT3
         F8Esa0XqRUGAhqpWAoNTx9Dtd6mFhubXQatmpovYF5N2vlYPIGnVAwMXBoZWgQPuBpnd
         M8tdivCaTlOb8pUo1bf7UGV6Jnd0KA5JsxbYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eRTljjVaMff00rztWbAfUBlQHGNNoULlS+hWEv3MBu30XUfhUquyYuRKkSnSLJGb1o
         glRS/ULdpNijbZh8C2J73Zu+O68f2I8FSolUowXKJ9IyojLBuZYL6t3HIlkG4snRiouw
         ImI9RqKiqV3uJ5ojvWVYwEIPDy7EOqBI2WjLk=
Received: by 10.115.14.1 with SMTP id r1mr6501424wai.139.1214965271160;
        Tue, 01 Jul 2008 19:21:11 -0700 (PDT)
Received: by 10.114.14.19 with HTTP; Tue, 1 Jul 2008 19:21:11 -0700 (PDT)
In-Reply-To: <c376da900807011916j5a3032een4587619535061b72@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87080>

On Tue, Jul 1, 2008 at 10:16 PM, Adam Brewster <adambrewster@gmail.com> wrote:
> But of course one function returns two very different things depending
> on what's on the left side of the equals sign.  That makes perfect
> sense.

Context should be the very first thing taught in any Perl tutorial,
lest ye end up in jail:

http://yro.slashdot.org/article.pl?sid=01/03/13/208259

:-)

j.
