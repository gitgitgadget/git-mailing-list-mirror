From: David Aguilar <davvid@gmail.com>
Subject: Re: feature needed imap-send pass as cli switch
Date: Wed, 28 Jan 2009 00:22:27 -0800
Message-ID: <402731c90901280022y7a2520bbx5454e523b852a5e8@mail.gmail.com>
References: <81bfc67a0901272318i707b66a0ja20f97df6fe95c73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 09:24:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5iF-0002aV-5G
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbZA1IWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbZA1IW3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:22:29 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:26466 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbZA1IW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 03:22:28 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7963692wfd.4
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 00:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xCWvpmj3yFhD0WXP2Wv/EjFuIsbm9eVdlh1FlZ8+DWc=;
        b=kCUjPv6RmvwAKzC8e2bbt+dNbcsU6/E9cHyRXJ99ND58r9GGWZVrdmQZtg6OYyGjqx
         il6u5yCaYpI325ocQA0BCwikUygFT2MCXerHOVuLn5rVAxC5Ywoaam1rn//JbnP5zl6W
         4yStF7rf9bjQNVNr0rxtGQ+6Yu9KXLARL+aGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XHekUDDCAdvbRQmaEcoeWbtp2CATO/eZaRBlN6Wh7Z5RkkHicbb0cdLhZ+2HOAG5KX
         FEdQ8QLLyRbaT8rZE5TT88UQ7xj/lTp4s3EkMG8i9NGSXUFknObcXBH1aNqaA+bnIEnb
         sntCSk291gbKTONxxw2n1wSAPn5bWg28LvPj4=
Received: by 10.142.132.2 with SMTP id f2mr812916wfd.108.1233130947782; Wed, 
	28 Jan 2009 00:22:27 -0800 (PST)
In-Reply-To: <81bfc67a0901272318i707b66a0ja20f97df6fe95c73@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107507>

On Tue, Jan 27, 2009 at 11:18 PM, Caleb Cushing <xenoterracide@gmail.com> wrote:
> I tend to have my .gitconfig shared on github with a bunch of other
> config files and this has been ok, until submitting a patch here I
> needed to use imap-send, and the only way I see in the documentation

Are you sending patches through gmail?  If so, check out:

http://git.or.cz/gitwiki/GitTips#head-a015948617d9becbdc9836776f96ad244ba87cb8

You can add .msmtprc to your .gitignore and keep it chmod 600.

Sure, it's cheating -- instead of keeping the data in .gitconfig we're
now keeping it in .mstmprc, but maybe it's a suitable workaround?



> is to put my email password in .gitconfig, obviously I can't push this
> up to my remote as I usually do. I'd like to see an option to pass the
> password on the cli, either as an input prompt or as just an argument
> to an option, or both. I think storing it in the config file is a
> security risk, storing passwords in plaintext is just bad practice.
>
> if it's already possible could someone share how with me? and perhaps
> patch the documentation to include how.
> --
> Caleb Cushing
>
> http://xenoterracide.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
    David
