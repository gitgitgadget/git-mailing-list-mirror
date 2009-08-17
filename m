From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: How-to checkin git hook
Date: Mon, 17 Aug 2009 22:26:58 +0200
Message-ID: <40aa078e0908171326g75cba2rc747c0d14a38cd0@mail.gmail.com>
References: <4A89BA5D.1000608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joe D'Abbraccio" <dajoe13@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:27:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8nL-0001vz-EX
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZHQU06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 16:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbZHQU06
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:26:58 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:42562 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZHQU05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 16:26:57 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1078411qwh.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/a8h9L9+esbF+Qhaq7v8Q6X4TL9QK+7hKkWGRWm6arI=;
        b=pEQH5SH865I/ugO1zDM379wkhlDOwRQePCtWD+5ZucOT4CcLMWJV71u/8l+sQHLVeg
         LFxO8H4MZHXqG0tbLMiHqWgQBohdpYINhdeG8bWbnNHAtP6cGjOfeVGzJA7Md3yAakEq
         gj8EL0MgjSP9UoY35fF7BArNbYfLtlXL5FNjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PKvTm0Yk+PN46PvIw5V2j1u4F7Lwz2qhPlQ2lWzdXT1k2srV72GcHvAAhLdio8h6mG
         TOXfpeVowoY9qFT//za4xvPbNROidM9u9IUp1DZCFmv2a8fxCBl/teM0vHqjhuWNtCT/
         O2FGOSrtUmpEiIoa+La5wDEUSZ1gv95HeLd74=
Received: by 10.224.121.129 with SMTP id h1mr4734918qar.55.1250540818030; Mon, 
	17 Aug 2009 13:26:58 -0700 (PDT)
In-Reply-To: <4A89BA5D.1000608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126272>

On Mon, Aug 17, 2009 at 10:15 PM, Joe D'Abbraccio<dajoe13@gmail.com> wrote:
> I am trying to add a post-checkout hook. I also noticed that the
> post-checkout sample does not exist when I init a new archive. Is this a
> bug?

No, it's security. Hooks are executable files and shouldn't blindly be
copied around for security reasons.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
