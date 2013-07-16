From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] howto: Use all-space indentation in ASCII art
Date: Tue, 16 Jul 2013 14:42:46 -0400
Message-ID: <51E59426.7020809@gmail.com>
References: <20130715164658.GA8675@bottich> <7v61wba3gu.fsf@alter.siamese.dyndns.org> <20130716082413.GA27283@bottich> <20130716182627.GM14690@google.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dirk Wallenstein <halsmit@t-online.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:42:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzADC-0002yw-Da
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933324Ab3GPSmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:42:54 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:53344 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab3GPSmx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:42:53 -0400
Received: by mail-ve0-f182.google.com with SMTP id ox1so770096veb.41
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=X25jTeGwN1QfM79LpttXnEhEfOijdSBoQZsqrCkpvVs=;
        b=MMSf2Ch3+JvkgIXES2qGXlen9Z2TjFeYpgaTJHKB3ntHdiMVoZajdwRz936RXseGgx
         E3Xc+eJVzeRoSKW2Msj392Rnq5iXGYJ0Zeo9e5q18kImMZBpLQdzC00h637PQR1Zm7KD
         UnD2Kq0dj/0kDG620II2HvcNmI+lAdfb2/nCyDIaSyWz/9PwJnT/crt2JK8C0wzjNVvu
         D4C2FL3bv1gfyL9KO3NsgqIowKWoS6o0snqA4ehgVLIj6Jmw09vxKw+OiCfbjkeXzg7e
         8lCvHe0YGbFO40ebuUB0rHOWd4L2xJzfynQZI69CEwpnJ9EzOkIkRkIk/taSGgMznqRs
         Ystw==
X-Received: by 10.220.109.8 with SMTP id h8mr885860vcp.5.1374000172745;
        Tue, 16 Jul 2013 11:42:52 -0700 (PDT)
Received: from [10.0.1.133] (50-88-155-14.res.bhn.net. [50.88.155.14])
        by mx.google.com with ESMTPSA id lm13sm545180vec.8.2013.07.16.11.42.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:42:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130704 Icedove/17.0.7
In-Reply-To: <20130716182627.GM14690@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230574>

>
>> Those text files are installed as documentation (at least on my distribution).
>
> That's probably a distribution bug (or a git makefile bug, depending
> on how you look at it).  It would be better to ship the HTML
> documentation, converted to text, instead of keeping the version with
> markup including occasional random \ signs, linkgit:, ``, etc.
>
> What distribution do you use?  (As maintainer of packaging for a Linux
> distro, I know at least one that is guilty of this.)
>

 From the AcsiiDoc Home Page:

=begin quote=
You write an AsciiDoc document the same way you would write a normal 
text document, there are no markup tags or weird format notations. 
AsciiDoc files are designed to be viewed, edited and printed directly or 
translated to other presentation formats using the asciidoc(1) command.
=end quote=

So, the asciidoc "source" files should be readable in their unprocessed 
form. And, not using tabs in ASCII art doesn't appear to have any downside.
