From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: is there a 'git find'?
Date: Tue, 4 Aug 2009 21:37:39 -0700
Message-ID: <fabb9a1e0908042137x68beaeccv69a6974b41584ef4@mail.gmail.com>
References: <3a69fa7c0908042114v7097e87esbe18f49eef9267f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 06:38:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYGS-0000hp-7t
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 06:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbZHEEiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 00:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbZHEEiA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 00:38:00 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:57302 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbZHEEh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 00:37:59 -0400
Received: by ewy10 with SMTP id 10so849263ewy.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 21:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NcAKONypamc8fgR4pfS7+85mJX58oJse90AZmCfd7e0=;
        b=NQYb4/bIKxgzcLeGVS/sBb/7FhL/Z5tqlO6c0s9TCO9UbI6eYExXcbfCkZbvNqpPGy
         aprIZWQGL/r7x0WmB4sGDtRoXS1Cm3MTue9m/VLFA0Umh3HegQniyyvYGU25gXhuitnL
         k6KMjGDJapQHS2r7xo28ZRDqr9lw7JMFMQl8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GJWmRBDAfoyb0H+kzW28Y7NvMlhK2YvDA+SglSFJrx3FJ6DAg3eGlG/QoeelaqrtFE
         /tIwi7ia46B81HcYtMmYzp+BmMZZem66avaDhkeY6DEJ8w00Cln/HBqzJIQ/ePRc6+Ss
         2m9GurJUZY4NVuu/+CQVPwJZ+hiGW9Q1pgtAo=
Received: by 10.216.89.141 with SMTP id c13mr1594728wef.66.1249447079115; Tue, 
	04 Aug 2009 21:37:59 -0700 (PDT)
In-Reply-To: <3a69fa7c0908042114v7097e87esbe18f49eef9267f5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124849>

Heya,

On Tue, Aug 4, 2009 at 21:14, E R<pc88mxer@gmail.com> wrote:
> Within a specific commit I'd like to find all the files whose path
> names match a regular expression.

Try 'git ls-files' [0].

[0] https://www.cs.drexel.edu/cgi-bin/manServer.pl/usr/share/man/man1/git-ls-files.1

-- 
Cheers,

Sverre Rabbelier
