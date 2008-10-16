From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: git and filesystem problems (ext3 and vfat)
Date: Thu, 16 Oct 2008 17:33:42 +0100
Message-ID: <e1dab3980810160933q30577344uf9b26c9ef0789576@mail.gmail.com>
References: <d0383f90810160903p6f8ffe77o86fdad5387f82481@mail.gmail.com>
	 <48F76936.3010801@drmicha.warpmail.net>
	 <d0383f90810160923m60ec95d8v8550a611f91176b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Ian Brown" <ianbrn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 18:35:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqVoP-00006N-Ai
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 18:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbYJPQdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 12:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYJPQdo
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 12:33:44 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:50711 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYJPQdo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 12:33:44 -0400
Received: by qw-out-2122.google.com with SMTP id 3so29496qwe.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FXzuLRfUo0YIVZc+8wjZSOgR7tO7pERhMoJ3ab2hkaY=;
        b=BqFbUmmoGWRxmLkN9V+4nGlVV7PICsTQ3a5TyQCaPK4JyltpWjozYcj7cTfrARmIvF
         pXnhSGfretB0DzwsadXIobV58a18ChO9rej70DjwTjH4vytiHEpBP+7PmK1eXdP88Ijr
         y7OX6Bf2Js1Em0dWqb94fixUouw2iHQS43Tvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KtM1iqkwAuFjcQjVQeZq/pQbxGqZP8vmKj9tZs1FQoLdDUq5HcClEfSG53AzGdW1ae
         HdG1IODHiwUHbTB23OojFAkJRUcT+jYM+DdXW7hhAabMjRzTWPpnwuv3bopcDOcJLqRK
         vv8kOsX8qTJtmJW4ef65pqqaQK5LbiLDpXceI=
Received: by 10.215.40.2 with SMTP id s2mr3205853qaj.37.1224174822850;
        Thu, 16 Oct 2008 09:33:42 -0700 (PDT)
Received: by 10.214.81.8 with HTTP; Thu, 16 Oct 2008 09:33:42 -0700 (PDT)
In-Reply-To: <d0383f90810160923m60ec95d8v8550a611f91176b6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98399>

On Thu, Oct 16, 2008 at 5:23 PM, Ian Brown <ianbrn@gmail.com> wrote:
> Hello,
> Thanks for you quick answer.
>
> ls shows the files.

I'm assuming this is on both the vfat and ext3 disks? All the
filenames' cases are correct?

> git status shows:
> fatal: Not a git repository
> Regards,
> IB

The error message unfortunately really means "git couldn't find
_everything_ needed to be a repository" without saying what precisely
it had problems finding. Educated guess: Have a look in the .git
directory on each disk. Is there a file called 'HEAD' or has its case
been changed?

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
