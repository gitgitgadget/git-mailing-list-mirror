From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-cvsserver: handle CVS 'noop' command.
Date: Fri, 30 Jan 2009 14:32:14 +1300
Message-ID: <46a038f90901291732o56c19387w9debbdc5b2027904@mail.gmail.com>
References: <1232144521-21947-1-git-send-email-stefan.karpinski@gmail.com>
	 <1233264914-7798-1-git-send-email-stefan.karpinski@gmail.com>
	 <7v7i4denpg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stefan Karpinski <stefan.karpinski@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 02:33:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSiGM-0001Yq-0l
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 02:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877AbZA3BcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 20:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755429AbZA3BcQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 20:32:16 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:28859 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbZA3BcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 20:32:16 -0500
Received: by yw-out-2324.google.com with SMTP id 9so104496ywe.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 17:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fdkCKIw0rmxeuv5wPJgEF2ZS7aDYW0Wyb3bwjO+8MlY=;
        b=bQAqFDDysY/FRdo4tNswCrxJAWQECC+Ym/uT7a15kEBIGw/om7+6AacFGL9pBsjw36
         SwrDEtQ1gh8gq3egOH3qsRSUrc+l5H5got64gd64nI1Enagr8FQfNO68x1q9p3NCWs8u
         WuLwD9Pz+IuM/ZTYWxa+jkjjh8Sbhq8h20mZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dt6AryqzjV4QF0gqKXlkyBF5HaSncCtNO3/blfijxr0NFmeODq++Ej7f1DH9DIohZQ
         mV2IuOvoWqrkZzV02osQ6ZznjQrg7SNRM/4JRi+8Olb8DivjURd3fF3UZUPJ7Ta3br9x
         6AVpIqdLDM4sD0Dx8VaefdNYswBb0vQn8cb/8=
Received: by 10.100.57.13 with SMTP id f13mr697911ana.143.1233279134737; Thu, 
	29 Jan 2009 17:32:14 -0800 (PST)
In-Reply-To: <7v7i4denpg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107762>

On Fri, Jan 30, 2009 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Not a no-brainer at all, sorry.

+1 on Junio's notes and patch.

Can someone with a real TortoiseCVS and a real cvs server sniff the
connection and catch the noop? (Can TortoiseCVS write debug logs of
the conversation with the server?)

Hysterical note: the original implementation of cvsserver was done
reading the output of `cvs -t $opts $cmd`, and ocassionally sniffing
the traffic on the wire or ssh connection.

Probably not a major issue for 'noop' though :-)

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
