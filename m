From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/8] wildmatch: remove static variable force_lower_case
Date: Wed, 10 Oct 2012 12:47:54 +0700
Message-ID: <CACsJy8BALFdRJw2sDBPStgxYaqy8d374MGo+S1CAdVnj4FtecA@mail.gmail.com>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
 <1349752147-13314-5-git-send-email-pclouds@gmail.com> <7vtxu3e5jl.fsf@alter.siamese.dyndns.org>
 <CACsJy8BOcH8cXje5osL4oNP1YkJ8HadUOYBek3uhEbySBey9Kw@mail.gmail.com> <7v1uh6evv7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:48:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLp9n-0004qG-V7
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 07:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350Ab2JJFs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 01:48:26 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:60564 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2JJFsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 01:48:25 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so4205526qad.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 22:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AWOMO12XeNR1eEBUY1HSRLSZMjSDqlzFlGYPdkXd9ww=;
        b=kEjZojCTppIIZFRH4CeUBlG3N1ds9EhSmFa9jDDZM+gT9RUsdcss7EWfjfFYxtF46r
         dnAEaBKHdefQgYdHjQd9WJvl/VqFA/Q9ObFDSoSyWzr9ZPRJ6vlVmaOnXFOJLTWap0e4
         zJQkNDVhKkB7ysU1HJmsFK1xsSBNvcwOW/ygV6GJMZcf/GZJTKMjHg5FMwbUFUSDzIbI
         jgVgi5VLae4aQ73vaUZijUSG73QFCseVDvsJlxOQReKz+e7bpX68L88H1kQSIaxOgRvI
         NS0JS12jl9+/xD7ALi04+2/oJy1H+g2R+NTRvfkUkDciwl6A47gduf5d2bvqsAWyyR0Y
         UGlQ==
Received: by 10.49.37.103 with SMTP id x7mr8728153qej.14.1349848104870; Tue,
 09 Oct 2012 22:48:24 -0700 (PDT)
Received: by 10.49.13.194 with HTTP; Tue, 9 Oct 2012 22:47:54 -0700 (PDT)
In-Reply-To: <7v1uh6evv7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207367>

On Wed, Oct 10, 2012 at 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Git's ctype does not seem to be complete for wildmatch's use so
>> ctype.h is required. But that can be easily fixed later on.
>
> Until "later on", I cannot even compile the series.

So that's why you noticed this patch :) It builds fine here. I'll fix
up and send an update later.
-- 
Duy
