From: Daniel Grace <negativeview@gmail.com>
Subject: Re: [PATCH] Document ls-files -t as obsolete.
Date: Wed, 14 Apr 2010 09:47:49 -0500
Message-ID: <t2r62a3a9cb1004140747s46c5ee50z3a063d8f2acf4e61@mail.gmail.com>
References: <1271252704-21739-1-git-send-email-Matthieu.Moy@imag.fr>
	 <7vaat6qesd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 16:48:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O23sl-0001O9-1c
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 16:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab0DNOrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 10:47:51 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:12931 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab0DNOru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 10:47:50 -0400
Received: by qw-out-2122.google.com with SMTP id 8so59159qwh.37
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=5LTfDLT1izjBZabpiDGZD/wacXWkQ5mpt/8/MOi3LnU=;
        b=efiVfnbLVmzhF6nd4Rgd/W3eDBViBoHbTYue7ou2gMoOCOqj3GQPXWjI72UGh1234S
         h3u/oW/mLpL9FqXqyOm+WAapUivXYOVSsghZTfPWJPxLlToZPThr6DL+kkHUtJS6w4F/
         r+r2VIOjyTDFC+g6xuZEd7bj5RGUFGVmCLsr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=P/gkecxuYuxtNRdoN5EBWKNFIAloYG8jQfyDvdPeobolrluE8LFqZn0sLSJ8sGZV0g
         TYB8UFN131VJRqK4wa5NIHyaSfV4YtS7uyPemgKK8XdpMsltx7E/dwWL1uX8nlxIAzH/
         dOnplIWTNZEunrNCEkLy4eS+I7aoKn2KmUa0s=
Received: by 10.229.86.140 with HTTP; Wed, 14 Apr 2010 07:47:49 -0700 (PDT)
In-Reply-To: <7vaat6qesd.fsf@alter.siamese.dyndns.org>
Received: by 10.229.224.79 with SMTP id in15mr4502041qcb.76.1271256469680; 
	Wed, 14 Apr 2010 07:47:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144878>

On Wed, Apr 14, 2010 at 9:39 AM, Junio C Hamano <gitster@pobox.com> wrote:

> If all your scripted Porcelain wants to see is "what are the paths I might
> want to run 'git add' on?", you do not want to run diff twice (which is
> what "status" does); you would say "ls-files -t -m -o --exclude-standard",
> instead. The alternative is not even superiour in this case.

Why -m? I have a script that attempts to ask just this question and I
don't use -m. Reading the documentation, I'm not sure why I would. In
what cases would I get wrong information without -m? For the record, I
also don't use -t, though using -t in this case does make sense to me,
I just apparently didn't notice that bit of the documentation when
writing that feature.

Daniel
http://www.doomstick.com
