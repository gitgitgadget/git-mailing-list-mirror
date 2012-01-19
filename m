From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Making pathspec limited log play nicer with --first-parent
Date: Thu, 19 Jan 2012 12:48:46 -0800
Message-ID: <CA+55aFyR02DyzwxrTdr360U+Pa6S3a40yBXegc_TuOsq_Z84qA@mail.gmail.com>
References: <7v1uqvjwga.fsf@alter.siamese.dyndns.org> <CA+55aFxucaeX7it_Kj7WV3ZbwCukN+wvbuxqJzh3V5Rxz4ib1g@mail.gmail.com>
 <7vwr8niftt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 21:49:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnyvB-0006y3-Hz
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 21:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933044Ab2ASUtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 15:49:11 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41662 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990Ab2ASUtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 15:49:08 -0500
Received: by wics10 with SMTP id s10so302005wic.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 12:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=zfbSIL8bDD44XxAY0pIPW+0SfszxH//2RT4G1Kj/LPU=;
        b=ZDs7vZpjMtq9vKkcvaKoeCIAXskNg9kwiClNWCowGia87Yzq+mD8DCyx4wchd7DioP
         4ZTf/Jox/LfaoV1G+AYx5Jhz7VqG6SLFWnolBE36m0TE5HDyNJwnhUVsQ6DzDpMJyRdp
         TQblULGxCKVvkZe3L/8KV7QkecugQaH/Dyc9E=
Received: by 10.180.100.234 with SMTP id fb10mr42164661wib.5.1327006147196;
 Thu, 19 Jan 2012 12:49:07 -0800 (PST)
Received: by 10.216.63.135 with HTTP; Thu, 19 Jan 2012 12:48:46 -0800 (PST)
In-Reply-To: <7vwr8niftt.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: HRNB0iujy3e2aezpRGgC9b5Nwt4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188835>

On Thu, Jan 19, 2012 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> But I personally find your loop is even more disgusting

Yeah, I can't really argue with that.

The thing I was playing with was to move the entire loop content into
a helper function (which would return the new pp), and then the
"first-parent only" case just wouldn't do a loop at all.

But I couldn't be bothered. Your patch certainly does have the
advantage of being minimally intrusive.

                  Linus
