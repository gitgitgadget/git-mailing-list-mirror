From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [PATCH][RESEND] Escape some tilde characters causing spurious subscripts in documentation
Date: Sun, 24 Jun 2007 16:33:22 -0700
Message-ID: <31e9dd080706241633v38c090f7m6302e32145fe8db7@mail.gmail.com>
References: <11826426733115-git-send-email-jasonsewall@gmail.com>
	 <Pine.LNX.4.64.0706240109540.4059@racer.site>
	 <31e9dd080706231722v760b5a0cnc31e24b83deafb90@mail.gmail.com>
	 <7vbqf5wtrb.fsf@assigned-by-dhcp.cox.net>
	 <31e9dd080706241031m64c6be37sb4437036fda543c9@mail.gmail.com>
	 <31e9dd080706241440s21025c26p68fda1595d531f1e@mail.gmail.com>
	 <7v8xa9q9mb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 01:33:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ba9-0004DT-9Y
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 01:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbXFXXdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 19:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXFXXdY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 19:33:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:55053 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbXFXXdX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 19:33:23 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1303066wxc
        for <git@vger.kernel.org>; Sun, 24 Jun 2007 16:33:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CT9+DGjgyHudELa5NDYg83AJsPXFk01JnsmC2D6blcDi+g1gZ4aYeSZctsZ6ugmCcnzyuwvtJadhruTvfwD7GdrqiMJyxWniIVe//rB7T7y9w+T3N1cu1zUTNAp3as/5BhLZJIAahcbRZCpS1hIY9T36o9S0dxOgMhCgqpaUvHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hop3eBD3yuC4xkgGQaGdLEMNndjLLDgFTIfO2xz5ry9O/curhf6/jlNcbSNX/JpFlh64S/Owdo25M1j2vaDTS8yzRUpLQ8nxkAnLAp2IgXQKaz9dIfkb5Mg4YijXvM2jqZLm6oHRjECQFxtd7Hi2YI3A3/xnuLF550+y2FWxbHE=
Received: by 10.90.118.8 with SMTP id q8mr3715185agc.1182728002604;
        Sun, 24 Jun 2007 16:33:22 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Sun, 24 Jun 2007 16:33:22 -0700 (PDT)
In-Reply-To: <7v8xa9q9mb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50845>

On 6/24/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jason Sewall" <jasonsewall@gmail.com> writes:
>
> > I'd suggest that we put all inline revspecs inside $$...$$; this
> > "inline passthrough" quote  obeys outside quoting,...
>
> Does that work with AsciiDoc 7?

I just downloaded AsciiDoc-7.2.1 and it seems to work fine (there are
some warnings missing tag definitions, but that's something else, I'm
pretty sure).

> > Is there a documentation 'style' file or something like that for git?
>
> Well, there isn't one as nobody really knows AsciiDoc well
> enough, and actually my message was to con you into writing one ;-).
>
I was afraid you were going to say that :)

I've wanted to contribute to this project for a while now, but I just
haven't had the time to familiarize myself with the codebase enough to
help out; I don't have to tell you that there's a lot of code in git,
and a fair amount of it is production-grade
'make-it-fast-screw-legibility' stuff that I'm not so good at reading
yet :p

So sure, I'll try to help out with this documentation stuff. I think
developing a style file and making the git docs conform to it would be
a good start.

To begin with:
1. What versions of Asciidoc are we interested in targeting? 7.0.2 and
up, or something else?
2. I think we should put all of the path, revspec stuff, and command
examples in monospace (grave quotes or plus delimiters) rather than
emphasis (single quotes) or what have you. This will make them
consistent with the way they are formatted in blocks. What's the
consensus?

The almost-markup-free nature of asciidoc does us more harm than good
in this particular case, since a little abstraction like
<revspec>HEAD^^</revspec> or whatever would let us just convert
everything and fight about presentation later.

Jason
