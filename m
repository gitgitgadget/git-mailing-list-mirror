From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 2/4] git-submodule: New subcommand 'summary' (2) - show commit summary
Date: Thu, 6 Mar 2008 13:56:21 +0800
Message-ID: <46dff0320803052156u374d70c1i45f7789233beb32c@mail.gmail.com>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
	 <1204481710-29791-2-git-send-email-pkufranky@gmail.com>
	 <7vk5kgiv0v.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803051816x5b957da0m6396d31cad8b4116@mail.gmail.com>
	 <7v3ar4lcgf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:57:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX96C-000410-V7
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 06:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbYCFF4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 00:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbYCFF4X
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 00:56:23 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:2063 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbYCFF4W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 00:56:22 -0500
Received: by an-out-0708.google.com with SMTP id d31so375333and.103
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 21:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3H1R/Hj8zJ0E+m/LkA1Wv67yt87N0eWpWxicH8WBYcM=;
        b=aldrc9HrrIS4oQjyQrHKkCAr3OFoHVg0Ef2w+Mh07/nsw7uLRSTjfvuBwCXalGBah74qNho1TJF1ohsAkq4JmD0Web/hOAqkb/+jRABDq2aiXM9wzMf2Y1QeAhAZPtITe2StKeawQgyb7UbItxR5ht9zj39KzDc8ZxSqmM0xCP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dEyoM6rlRC/89ILbZPUqabAL+TebXMuUgrbPJvWtQjYDux3UCxyf0dogOvKKSBdtCCsnvumu+jLjsygdxa9J/r2naCmh0+08c8z9B1NunzowlJLDBls2nxj7p6TW7L+YxOl+30ajypAicChF1BYJfxkykEshQU69iWlIBIgXOGA=
Received: by 10.100.229.13 with SMTP id b13mr9168067anh.7.1204782981864;
        Wed, 05 Mar 2008 21:56:21 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Wed, 5 Mar 2008 21:56:21 -0800 (PST)
In-Reply-To: <7v3ar4lcgf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76339>

On Thu, Mar 6, 2008 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>  > ... I think showing 2 (the head and tail one) should make more sense
>
> > since the head one would be "Initial add ..." in many cases which
>  > doesn't make much sense for the user.
>
>  Why would you want to see the bottom one?  I still don't understand.
>
>  And I do not mean this as a rhetorical question.  I am here to learn and
>  I would like to make sure that I do not make a suggestion based on wrong
>  understanding of what the user wants to see.
>
>  I probably am lacking imagination to think of a good use scenario that
>  showing the bottom one would be useful to the user, and you as the author
>  of this patch must thought about what the user want much more than me.
>
Showing the bottom one can give the user an impression where
the submodules goes at first glance if the user is familiar with the
developing progress of the submodule.

However, i don't have very strong point on this and just think it
seems good when
i type 'git log'  (i have make the summary go into the commit message)



-- 
Ping Yin
