From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH TAKE 2] Avoid a useless prefix lookup in strbuf_expand()
Date: Sun, 10 Feb 2008 07:59:45 +0100
Message-ID: <e5bfff550802092259u4139312cufc4756e9d81f4154@mail.gmail.com>
References: <1202568019-20200-1-git-send-email-mcostalba@gmail.com>
	 <7vr6fl5yhz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 08:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO6B0-00074o-CZ
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 08:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbYBJG7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 01:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbYBJG7r
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 01:59:47 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:16707 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYBJG7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 01:59:46 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3008339rvb.1
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 22:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=R47bsx6iTmRLAXcBDZuIvc6/YV9ktI+fMTAiso04yXQ=;
        b=TFIWWPWm0LiaFIkU7hwwF64jpgK4nRAgXGf+cA9VMTJiwZcZFruSPZ0kHbQNNAEO2lS0O8/dpUDfJp49G/vJZvNdNFHEhWMKZEw1eVk4MSmLta10lCNy9AqzkhDitnC6BBOssDjfrOtfuu+/Zuf4DaLgYxjq4UmTL2Be6dYMsZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JKciMvElZGlltQy7xGtRlWgYrnYKInvo68Lt2P7WGZHKy6ZwgOgUMZ21lpWqM4NcVu3cMRulJ6FsqL5VCrs5t+3oqJs7ZoTkngKs5I0Dg0nQCdkwg+r9QZHV/GTXY6G7gKjIZYqvWbtGjYcBwbxcvPgJaO0mQb6Hae8wKq3W7cE=
Received: by 10.141.116.16 with SMTP id t16mr9752786rvm.60.1202626785784;
        Sat, 09 Feb 2008 22:59:45 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 9 Feb 2008 22:59:45 -0800 (PST)
In-Reply-To: <7vr6fl5yhz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73320>

On Feb 10, 2008 3:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Marco Costalba <mcostalba@gmail.com> writes:
>
> > Currently the --prett=format prefix is looked up in a
>
> s/prett/&y/;
>
> > New patch with Junio suggestions included.
>
> Hmph, this is a blast from the past.
>
> I do recall pointing out that a rather common "format:%an <%ae>"
> ends up parsing the same line twice, and mentioned we may want
> to memoise the first call's result in the format_commit_context
> structure, but what else did I suggest???
>

Please read thread: "[PATCH RESEND] Avoid a useless prefix lookup in
strbuf_expand()"

you will find your suggestions and following answers.

> Anyway, I'll take a look later.  Thanks.
>

Thanks
Marco
