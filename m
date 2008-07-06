From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: remote does not support deleting refs
Date: Sun, 6 Jul 2008 17:29:33 +0400
Message-ID: <37fcd2780807060629gbbbb2eai5ecfde6afe8c18b0@mail.gmail.com>
References: <486FE602.3060301@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin <html-kurs@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 15:30:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFUK2-0004nF-WB
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 15:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbYGFN3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 09:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbYGFN3h
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 09:29:37 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:3001 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012AbYGFN3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 09:29:36 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1763666wfd.4
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fZoxsJnDO6OnnpT1PQ4utVgGOyVR3xNtfPw9EXJ9tK8=;
        b=fIY3IuztRJljZ6vbPuPJrbaTlapxGexIy+1nIEvc1S3QXofqXXvYrBuyxSXb+0Vbs+
         xirtxSP8EPj7W5AgKJVQn75Z9Xp50czFgeIjNIB+hBbfjBiNRD0W/FZDEDE9t1Dh5s4c
         y7R95jk5ivTvRZmX71J0L/F1Z2VuvYEaLkTvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eTKMRxvNoBYKMLQPAkS47mf0B/I20fZnw/nP70KpZ/VQydrxQ2xX2THG4TMKOxjoCI
         +U+gjzuI3c1qYXbCI/i8a1vj6cl1MWSJosdvCwU4FCiYyKO/nl2/bA212xNTpEHjK2RG
         Z5JK3uPEci4RPL0r5T/B+1Qfqq75noDGExnmA=
Received: by 10.142.200.20 with SMTP id x20mr919652wff.259.1215350973809;
        Sun, 06 Jul 2008 06:29:33 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Sun, 6 Jul 2008 06:29:33 -0700 (PDT)
In-Reply-To: <486FE602.3060301@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87529>

On Sun, Jul 6, 2008 at 1:22 AM, Martin <html-kurs@gmx.de> wrote:
>
> To ssh://myserver.com/my/path/to/repository
>  ! [rejected]        testbranch (remote does not support deleting refs)

What version of Git do you use on the server? I think Git before v1.5 does
not support deleting remote refs. You have to upgrade Git on your server.

Dmitry
