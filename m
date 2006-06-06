From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: [PATCH][gitweb] Make it possible to retrieve HEAD plain blob
Date: Wed, 7 Jun 2006 00:10:09 +0200
Message-ID: <4fb292fa0606061510s73fa6f3ag6e12766370749c77@mail.gmail.com>
References: <20060606205737.GX10488@pasky.or.cz> <e64rhu$i7n$1@sea.gmane.org>
	 <4fb292fa0606061431g2fcc8cdet93685b5a4977c29f@mail.gmail.com>
	 <7vwtbulz32.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 00:10:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnjkd-0000s7-Ky
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 00:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWFFWKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 18:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWFFWKL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 18:10:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:15291 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751203AbWFFWKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 18:10:10 -0400
Received: by nf-out-0910.google.com with SMTP id k27so13621nfc
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 15:10:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QRTqxMD7EMqM1X8A8CVqmw/XhzJzN6rw8XqAD8kw4ibL//E1gsQPSzzDxfL6pnAcwdCiCKFqc0Nx9F/rzCTo3XK9o06Dy78dgox04XZfftXtUKjwgaI8b+AMg4AHi7CBsrRrxD7JskblhKMCTqct5/rmUej2KVKrrLALuQW6bL4=
Received: by 10.49.14.18 with SMTP id r18mr12824nfi;
        Tue, 06 Jun 2006 15:10:09 -0700 (PDT)
Received: by 10.49.5.13 with HTTP; Tue, 6 Jun 2006 15:10:09 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwtbulz32.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21408>

On 6/7/06, Junio C Hamano <junkio@cox.net> wrote:
> "Bertrand Jacquin" <beber.mailing@gmail.com> writes:
>
> > This is also a gitweb fault which always define document as plain-text
> > instead of correct MIME.
>
> But that is somewhat unfair to blame it for -- we do not store
> what the correct mime-type is for each blob, so gitweb has to
> choose between guessing and getting it wrong, or not guessing
> and havign the browser deal with it.  It chose the latter, which
> is understandably sensible.

I'm ok with that. Browser can deal with if serveur do pass to it a
type=text/plain. And it's case for now :('

-- 
# Beber : beber@gna.org
# IM : beber@jabber.fr
# http://guybrush.ath.cx, irc://irc.freenode.net/#{e.fr,gentoofr}
