From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Wed, 23 Nov 2011 18:31:34 +0700
Message-ID: <CACsJy8AM-NyCcoCO2ssdPEGKXT3ODcc4ObZTrjn8K+Tz61woTw@mail.gmail.com>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org> <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <7vsjlhhq33.fsf@alter.siamese.dyndns.org> <CACsJy8AgDKYhyJ2CD0Y7trGrT63bUuYAS0DadD9khyqEYpguew@mail.gmail.com>
 <7vfwhhgzcb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 12:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTB3u-0008Pr-GY
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 12:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab1KWLcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 06:32:09 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60359 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1KWLcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 06:32:07 -0500
Received: by bke11 with SMTP id 11so1469678bke.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 03:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gOt5saGJP5ZK35298hPx4HBwWiwnHQY3hg2/PtsLXXQ=;
        b=eV9NjU69xRaKb4oJ7iS2IT+tf50b1h4eoJifMxH9b3v+irHyetZn8TDKCXCD6AsT2l
         xqPxk+X16sTpJZq0IOT+WsrUrYqPZnPQoVjUxKUb8ueJvN6Q2jfTZb9a+EhSw+PLjBkn
         R9NBKhu8G3NUtqHebhINCYCba+wGqk0rsMTJ8=
Received: by 10.204.154.77 with SMTP id n13mr24083667bkw.83.1322047926111;
 Wed, 23 Nov 2011 03:32:06 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 23 Nov 2011 03:31:34 -0800 (PST)
In-Reply-To: <7vfwhhgzcb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185839>

On Tue, Nov 22, 2011 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> It dated back to f8a9d42 (read-tree: further loosen "working file will
>> be lost" check. - 2006-12-04) when you introduced --exclude-per-directory
>> to read-tree, but not --exclude-from to explicitly add .git/info/exclude.
>
> That one together with 1127148 (Loosen "working file will be lost" check
> in Porcelain-ish, 2006-12-04) complets the picture. Thanks for digging
> this out.
>
>> I guess it's time to add "read-tree --exclude-from".
>
> Perhaps, also --exclude-standard to match?

Yep, will do.
-- 
Duy
