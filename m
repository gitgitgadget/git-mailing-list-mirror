From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sun, 16 Nov 2008 16:28:08 +0100
Message-ID: <cb7bb73a0811160728t1a99aedbm400b41d402115ade@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811161312.50090.jnareb@gmail.com>
	 <cb7bb73a0811160426g1e56faa7ia9b1f398fea039a8@mail.gmail.com>
	 <200811161521.53993.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 16:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1jZ1-0000bA-26
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 16:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbYKPP2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 10:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbYKPP2L
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 10:28:11 -0500
Received: from qb-out-0506.google.com ([72.14.204.228]:54519 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYKPP2K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 10:28:10 -0500
Received: by qb-out-0506.google.com with SMTP id f11so2064069qba.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aFx4duv5z1eDs2vWISrqNQYpAjBB5t2d1slPCjcXqzM=;
        b=vWlryfI5kSrqgwleruGwN3djdlBsb1QQGLXDtvstCcCVlRK/OwbRhGLEVobFo/OcW6
         jw4JXs/KW0Bvn6oBbyybfImQKvMvM0msncdYXfj6XwTrMQxYKmGxRrJwFB7mFBEe7PZm
         d8qyhWy0LokwsFXeW8av3V4/UnxaYOL12Xq0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=osW9XIpAm2fBp+iBOHIzPV39mfiO/4IkVhfyEwn/TGUKoSmOHFt1Yqq0y9j8zd5o1R
         loG+43V+sKD+SmQGP9VkcfYNnlqTBsCWvHvZ97xlOkv/uMAwmkeHBY9ve3u9Vi2SXtaF
         sgMl9hDejxUDl672jI2+3N6eGitAagKXu7IWI=
Received: by 10.210.134.5 with SMTP id h5mr3066245ebd.85.1226849288502;
        Sun, 16 Nov 2008 07:28:08 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sun, 16 Nov 2008 07:28:08 -0800 (PST)
In-Reply-To: <200811161521.53993.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101136>

On Sun, Nov 16, 2008 at 3:21 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>> On Sun, Nov 16, 2008 at 1:12 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
>>> The problems with nesting is those pesky remotes with only single
>>> tracked branch to them; they are I think quote common... well, unless
>>> you do one-shot pull, directly into local branch.
>>
>> My idea with this would be to only create a group if it has at least
>> N > 1 (probably N=2) entries.
>
> A bit of complication is that you would have then series of
> 'uncategorized' (not in any subsection) entries / remote-tracking
> branches.

We'll put them in their own group 8-)

>> Yes, I will resend the 'remote_heads' feature as a new (reduced)
>> patchset, then add (separate patchset) grouping for ref lists, and
>> then add (yet another patchset) detached head.
>
> That is I think a good idea.
>
> P.S. I think that sending this patch series for review, even if it was
> not perfect was a very good idea... well, perhaps some patches could
> be marked as RFC.

That's what they were when I first sent them last year 8-)

> It is hard work to prepare good patches, then wait for review, then
> wait a bit that there is no further review, working on the patches,
> resend and wait for review, or for Ack and merge-in... Keep up good
> work.

Thanks.

-- 
Giuseppe "Oblomov" Bilotta
