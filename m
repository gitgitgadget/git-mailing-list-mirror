From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: turn off "LF will be replaced by CRLF" thingy
Date: Mon, 29 Dec 2008 18:58:50 +0300
Message-ID: <37fcd2780812290758q3ef989c0w5156da3098d06068@mail.gmail.com>
References: <gjaqta$tg7$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Mon Dec 29 17:00:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHKXP-000743-NH
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 17:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYL2P6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 10:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYL2P6y
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 10:58:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:32842 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYL2P6x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 10:58:53 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1744980fgg.17
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UofOL0/Z5dWNY0Annfu/gOYQo6IQjdM1irqtblZhZRE=;
        b=mXrZQ7Mu8mPNKu0WEnMQsp3rfVzXdHetvV20mVrBin7Uh6gGaYvfA0bc2WfbiZEeF9
         ha7S8ZeJG132rUKYUHYBrU8pBIA83omrW4YFJYTG4PGFdHKlRsO5RIgujsCuUHhALaJL
         ug1asDaRubYAcKSCVeCa420dqO1jmFF4K4RRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SJW1PCZl5+YKO2lvWZxGWjdK4gaxLAXGI9YxzoCaxeY1JxruFhCVKJK6j/hSGznRDw
         rtXsUog5f0c1LYTJfc0GfhCep+4mkamaLGFo6M8qKDnIYk3yAsWx/f82/2q8Dr7lkW2j
         5r5JRglz+ofZ2O3IcUhmDb6/ZxgDUkDFVG5BA=
Received: by 10.86.62.3 with SMTP id k3mr2173951fga.47.1230566331097;
        Mon, 29 Dec 2008 07:58:51 -0800 (PST)
Received: by 10.86.51.14 with HTTP; Mon, 29 Dec 2008 07:58:50 -0800 (PST)
In-Reply-To: <gjaqta$tg7$4@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104106>

> I'd rather not let git change any files, many of which are PHP that run on
> Apache
> I think I remember reading that this is a config option that gets swithced
> on by default on windows (which we are running git on)
>
> how do I switch it off ?

git config core.autocrlf false

or if you want to ensure that all your text files have only LF then

git config core.autocrlf input

or if you want to disable conversion for some specific files then you can
use 'crlf' attribute. See 'gitattributes' for more information.
http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html

Dmitry
