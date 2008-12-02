From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: [PATCH] Modified the default git help message to be grouped by topic
Date: Mon, 1 Dec 2008 22:10:25 -0800
Message-ID: <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com>
References: <20081201173037.GA41967@agadorsparticus>
	 <20081201183258.GB24443@coredump.intra.peff.net>
	 <7v7i6jqriv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 07:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7OUA-0004xN-2t
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 07:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbYLBGK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 01:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbYLBGK1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 01:10:27 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:25645 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYLBGK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 01:10:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2819437rvb.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 22:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vTQhxWiD2dGyPdNrDeLvyI5bTFH+ukOECwWqzg/q96w=;
        b=aW0LVmyHl4rKixfQtPvsznnmWrmaZVTg9Rl6QuhmUqHQXnG15QcmCsZGHIzYmTW83F
         ff0KeCm6OwZdJxSFoLHWg5ihSZGk5CtnX74EC+s/mCOMOr40YLa2emtfQjmrPfTj9bJj
         UrXEsZY03S7f4ZGZ+thIl987djb9MEKO1IBJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ag91nY29LkO+z6hsz4ilX7RxsPaoKXqBd/0r/dRG7UsxDoYd7zHnIf8HuGTRog+l6W
         XLCvTfn4M4Q4FggArFFHbSph1lwZIhP27fbwoSttkEdjETW4kL7qLWp8tJ16W08fOTpf
         lnvCEb745CZUHuz9D3FOe8He69GZergXe/86k=
Received: by 10.114.94.12 with SMTP id r12mr7051622wab.156.1228198225582;
        Mon, 01 Dec 2008 22:10:25 -0800 (PST)
Received: by 10.115.22.20 with HTTP; Mon, 1 Dec 2008 22:10:25 -0800 (PST)
In-Reply-To: <7v7i6jqriv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102122>

Hi,

On Mon, Dec 1, 2008 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Dec 01, 2008 at 09:30:37AM -0800, Scott Chacon wrote:
>>
>>> It's difficult to process 21 commands (which is what is output
>>> by default for git when no command is given).  I've re-grouped
>>> them into 4 groups of 5 or 6 commands each, which I think is
>>> clearer and easier for new users to process.
>>
>> I like it (and I think the categorizations look reasonable, which is
>> something that I recall caused some discussion at the GitTogether).
>>
>> The only downside I see is that we're now >24 lines.
>
> If this list is meant to show "the most commonly used" basics, then you
> can trim the list somewhat.  For example, "rm" and "mv" can be safely
> discarded, "status" can be replaced with "diff", and "diff" can be removed
> from "History Commands".
>

I sent a new patch that removes 'rm' and 'mv' and removes the
common-cmd.h build process. I did keep the 'status' command, since in
my personal experience people tend to like having that command.

Scott
