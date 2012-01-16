From: Jacob Helwig <jacob@technosorcery.net>
Subject: Re: Signed tags in octopus merge..
Date: Mon, 16 Jan 2012 14:58:33 -0800
Message-ID: <CAJ8aY1Hi47uyYSjAmtXfDEqgyc8T21WqXdEA0kGS7SQKxQ5b5g@mail.gmail.com>
References: <CA+55aFzRN2F5PZDZPRmbj9occZwA6E6Pi+S+M_Qq2EfS6sctyA@mail.gmail.com>
 <7vobu3uusw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:59:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmvW2-0000rF-H8
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 23:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141Ab2APW64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 17:58:56 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:50819 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757126Ab2APW6z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 17:58:55 -0500
Received: by obcva7 with SMTP id va7so5146692obc.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 14:58:54 -0800 (PST)
Received: by 10.50.197.169 with SMTP id iv9mr12048313igc.7.1326754734214; Mon,
 16 Jan 2012 14:58:54 -0800 (PST)
Received: by 10.50.11.138 with HTTP; Mon, 16 Jan 2012 14:58:33 -0800 (PST)
In-Reply-To: <7vobu3uusw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188665>

On Mon, Jan 16, 2012 at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Just a heads-up and congrats: octopus merges of signed tags work well,
>> and did exactly the RightThing(tm), both at merge time and with
>> "--show-signature".
>>
>> I knew it was supposed to work, but I have to admit that I was a bit
>> apprehensive about it when I tried.
>>
>> Current top-of-head (commit 81d48f0aee54) in the kernel, in case you care.
>
> I looked at it again, and it makes me wonder if we should further reword
> it to say "side branch #1, tagged 'devicetree-for-linus'" instead of the
> current "parent #2, tagged 'devicetree-for-linus'". It looks very weird to
> start counting from #2, when we know we will never show #1 there.
>

My immediate thought regarding the "side branch #1" version is not
wanting to have to do the math (even though it's a simple n+1), if I
decide to convert that text into ^ parent selection notation.

-- 
Jacob Helwig
http://technosorcery.net/about/me
