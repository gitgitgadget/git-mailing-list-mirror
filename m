From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/7] Refactor git_remote_cvs to a more generic 
	git_remote_helpers
Date: Thu, 29 Oct 2009 08:48:35 -0700
Message-ID: <fabb9a1e0910290848h3fe03a63r15f461d70ec6d6f3@mail.gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com> 
	<1256798426-21816-2-git-send-email-srabbelier@gmail.com> <200910291305.26523.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3XFH-000483-9r
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbZJ2Psw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 11:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755432AbZJ2Psw
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:48:52 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:20656 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbZJ2Psv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 11:48:51 -0400
Received: by gv-out-0910.google.com with SMTP id r4so300682gve.37
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=N3tmTBRh1EJhlYetXTgFN+EBMR09l34L8/z1RkqHggU=;
        b=MslODKRaRe1cJFjkD0fJNLz6BWuwDKSKTqxGL5KsJ77ab7perJ8Vk6DSU+WDCBpEZz
         JNJKjz7eq6qyqF6V41CsUohRKCHaTl+QsqljZTcVNoJ42VMqKqsTUPr7lO5JH3miwvLL
         VVKes4ZCOz5IbfQe+MfnEzEZOOZwcKTKdxCds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fCBmGAQwlghoJaGq+trQHiUhSEgAmEFwCCXHZTWksHOWHscaDlGzW+wKtKnxqPGZZo
         2rK7rlnzElBIru80XL0JRNHpGXSML5A7Fz/riTg19vSmKwouyblloMp+8TROFHQscod9
         MsfkrWHEf4fcGP85WWE4+cpGyDBbqVJgrThDA=
Received: by 10.216.88.8 with SMTP id z8mr80288wee.109.1256831335580; Thu, 29 
	Oct 2009 08:48:55 -0700 (PDT)
In-Reply-To: <200910291305.26523.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131603>

Heya,

On Thu, Oct 29, 2009 at 05:05, Johan Herland <johan@herland.net> wrote:
> Fortunately, you can easily solve both problems by rerolling the patch with
> the -M flag to git-format-patch.

Whow, I feel really silly now, thanks for pointing that out, proper patch sent!

-- 
Cheers,

Sverre Rabbelier
