From: Minty <mintywalker@gmail.com>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Thu, 18 Jun 2009 23:31:22 +0100
Message-ID: <e1868cfe0906181531o2e4aa8fwd45477216ede98c1@mail.gmail.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	 <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	 <7vvdmurfao.fsf@alter.siamese.dyndns.org>
	 <20090617182036.GA4500@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 00:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHQ8s-0002Ho-Sx
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 00:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbZFRWbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 18:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbZFRWbW
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 18:31:22 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:35954 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbZFRWbV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 18:31:21 -0400
Received: by fxm8 with SMTP id 8so1409595fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aFsvuhjSCC0VkuP+wwPcyZ+JbHHkuGHxHPxpwvyrhcs=;
        b=bGE8bjq6aWtS7N05ofi6omcOjDnXyj+xSMNUIb8tgXa99+27/VvuI26fIyT2OlGIlh
         tiX/a7Cyus5lxItKPZBui+IClCOPO+SSu7KbnuZNbqKu0N0vTHbwLCWQLVPhiv+AVMaR
         GgAeEects0rPcbbiEvhqxpemVDuzvcqsW23iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DVNBiLET9C08iXUwGTGTgzQAy5UpqLNdKs/6nzIbniEHmS6qlqV8JteQGT74sFafvi
         PY2D2tgT3cyUpPJ0Nitqu2mHyQWJ2RzgHXePBtf69Md+wfTs23Zu3R7uy3FdgWEi/6eU
         ZfGPCaSHXDx8DShgWP4++3ctUuEhjye5gmhvg=
Received: by 10.204.119.71 with SMTP id y7mr1823426bkq.24.1245364282383; Thu, 
	18 Jun 2009 15:31:22 -0700 (PDT)
In-Reply-To: <20090617182036.GA4500@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121875>

> On Wed, Jun 17, 2009 at 09:33:19AM -0700, Junio C Hamano wrote:
>> So I can see why a variant of "squash" that does not change (nor even ask
>> for a replacement of) the commit log message from the one that is being
>> amended could be useful.
>
> How about deleting the commit message header?
> [snip]
> It requires explicit removal the unwanted commit message, avoiding any
> accidents due to ambiguous keywords.

I'm quite liking this idea, albeit a subtle feature.  Which is just fine.

>From what a quick look suggests, git-rebase--interactive.sh is the
first port of call.  Along with the documentation.

I will see what I can put together, albeit not until next week now.

Thank you all for the input.
