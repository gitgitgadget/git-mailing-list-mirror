From: Akira Kitada <akitada@gmail.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Mon, 11 Oct 2010 10:31:31 +0900
Message-ID: <AANLkTi=nCOeD3u0fst11xujFHuhhj0OU1g_dZ8gTOAMT@mail.gmail.com>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
 <AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
 <AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com> <7vfwwetih8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 03:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P57Fb-0003UO-F5
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 03:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab0JKBcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 21:32:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62565 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab0JKBcK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 21:32:10 -0400
Received: by vws2 with SMTP id 2so653779vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=iywGjF+AvvLTw7H3I4i/xD9QpDYbRTNsokEw/J9lMPA=;
        b=pvDAOMjk9q/Se9p/6maW4IzKdKEh0WHVxxhDlWkhbsDPH15E7bpqL9A4GkYst3yte3
         +vlHB/mUAfBiwue/SwmW39JVSfKMI6joWy/P2sRXwB/jCsiz2ZUKUpDJJjJ7aQsjvuBZ
         CJTrzFj3qUSSHMRVqj8xgM5l+BC8xfHhB/MHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=j+4Q934foCvKcmIbCytXX9MqLblhmkZpAbdgATEg9FZyugB5Yu6XVcBs8wSVg07Ld8
         XckWIJtWgi7QOjZ5YfTE+Sj5uZ5pJXC8WKJk98s8QZNAiFN6w6ovXshCtouo0qwh9w8X
         da3ODlkwF9Q13wZi0gToRLmCC4AzzdNY/0nlM=
Received: by 10.220.187.141 with SMTP id cw13mr1739506vcb.38.1286760711579;
 Sun, 10 Oct 2010 18:31:51 -0700 (PDT)
Received: by 10.220.191.73 with HTTP; Sun, 10 Oct 2010 18:31:31 -0700 (PDT)
In-Reply-To: <7vfwwetih8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158730>

On Sun, Oct 10, 2010 at 8:06 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Hmm, that is not much different from what I'm running pre-push test on in
> one of my VMs.
>
> $ type perl
> perl is hashed (/usr/local/bin/perl)
> $ /usr/local/bin/perl -v | grep v5
> This is perl, v5.8.9 built for i386-freebsd-64int
> $ perl -e 'use ExtUtils::MakeMaker; print "$ExtUtils::MakeMaker::VERSION\n";'
> 6.48
>
> One difference is that I never use ./configure, as that is somewhat
> foreign afterthought in our build infrastructure, though.
>

Could you run './configure && gmake' and see if it builds on your environment?
