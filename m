From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Tue, 6 May 2008 08:40:15 +0800
Message-ID: <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
	 <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
	 <alpine.DEB.1.00.0805041040560.30431@racer>
	 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
	 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 02:41:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtBEz-0002hG-1R
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 02:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbYEFAkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 20:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755475AbYEFAkT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 20:40:19 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:63437 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474AbYEFAkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 20:40:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so597661and.103
        for <git@vger.kernel.org>; Mon, 05 May 2008 17:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YOdXZzfj79Opi/qgWJr4zCjQMkKw5lu+9k5cL3NJ1R8=;
        b=DygF03NLRg+cEsnHGP9yfw4o+CpKz/2P/vOtA/tmGJi98CyFJZXX38/tZM5Y0HVp7+SCAnxeypbwLv+fXRrks5dkGCvNHZK8RvlO1d34+To2qFo7UNVtcPLQ0tXcwoH7+p6lBN4wPy0MpTeXjEsUubxZG7sC2UYpfhurTV2BmLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qtkp9nsa7TXQ2X9Jr97J0+GYsCaNZ2wF2FOoo/G5REh0BtLp96TT4rvT1aX2+Q9TrDUxRzaPf6q2g2D5UtUFdv795cGrq3vmrH2YBg5WuBxsxJxE7OG5i3fok38JT8xb7E+2PTT4GiaF+hxFD5sfWRWYEIs5e1z6fe0akLFiEJQ=
Received: by 10.100.5.16 with SMTP id 16mr112418ane.102.1210034415260;
        Mon, 05 May 2008 17:40:15 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 5 May 2008 17:40:15 -0700 (PDT)
In-Reply-To: <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81317>

On Mon, May 5, 2008 at 8:10 PM, Ping Yin <pkufranky@gmail.com> wrote:

>
>  The one-char-one-token and multi-char-one-token rules may have
>  different implementation issues. I think multi-char-one-token rule may
>  be more representative. So for the current time, i prefer considering
>  both run of word characters and single non-word character as a token.
>

If we agree on this. I will come up with an implementation still using
diff.nonwordchars few days later.



-- 
Ping Yin
