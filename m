From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/4] git-imap-send: Allow the program to be run from subdirectories of a git tree.
Date: Tue, 8 Jul 2008 21:28:03 -0400
Message-ID: <76718490807081828k7640d07bp547a69d05a6e07c4@mail.gmail.com>
References: <1215555496-21335-1-git-send-email-robertshearman@gmail.com>
	 <7v3amjq2mj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Robert Shearman" <robertshearman@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGOUo-0003dX-9u
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 03:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbYGIB2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 21:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbYGIB2G
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 21:28:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:10686 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYGIB2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 21:28:04 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1712876waf.23
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5XwqnokMsKqtlVyCn4rNk6iW5wPVhwNE0uOaQhNryCs=;
        b=NegSVK+flMEx2Q8s2IoeLuWst6zGIOjge7mHziNMkD0aCVsWDTT5Yw6EUiZYr5XkTx
         zGRkF6t9+OWBiN5h2T4Jiamu+NQRbPu70yCP0IshK2Nd95JcQ1SXX7DEIZS2LK397BlK
         SpnQVAw1yQyJqOmvOTErZVV7m80C6zUAK1WWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kny1KuqlUg83YcxwyItDiKiO+l6J04FTJOBVPtuXJHvc+CY/a+J9Sykln7OXVoQap5
         1jskn8RBdJJ3QqOgEPfsZ5MnRwouYTtboD8JE2UnvN687VcU1CAh7Ow0stDPBs64G+PO
         BrUKgQYdtqYk/+pODAkurbGtN6mYd26Fgj0Ls=
Received: by 10.114.36.1 with SMTP id j1mr7975639waj.7.1215566883908;
        Tue, 08 Jul 2008 18:28:03 -0700 (PDT)
Received: by 10.114.14.19 with HTTP; Tue, 8 Jul 2008 18:28:03 -0700 (PDT)
In-Reply-To: <7v3amjq2mj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87829>

On Tue, Jul 8, 2008 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I thought Jeff already explained why this NULL was a bad idea, but perhaps
> I was dreaming...

http://article.gmane.org/gmane.comp.version-control.git/87701

j.
