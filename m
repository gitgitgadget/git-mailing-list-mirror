From: PJ Weisberg <pjweisberg@gmail.com>
Subject: Re: Objects deleted before first commit
Date: Tue, 14 Jun 2011 07:57:09 -0700
Message-ID: <BANLkTinRkfpvk4H3F3w1xMjDuGTpkeEV3Q@mail.gmail.com>
References: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>
	<BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>
	<8269100C7056D24A91B672AF7E5E48492D95BB@exchange.GottexBrokers.local>
	<BANLkTik1jTq6otRvHwbo342oH7Dwy+vs_w@mail.gmail.com>
	<BANLkTin9_jfvtYdCsJLiWAoOvO2e1f=9SA@mail.gmail.com>
	<8269100C7056D24A91B672AF7E5E48492D963B@exchange.GottexBrokers.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Barr <davidbarr@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Edmondo Porcu <Edmondo.Porcu@gottexbrokers.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 16:57:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWV3T-0004vm-5O
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 16:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab1FNO5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 10:57:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36981 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1FNO5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 10:57:11 -0400
Received: by fxm17 with SMTP id 17so3746874fxm.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WGyvo9ud2QEUALCKSUwg6CVgE0b0YcySbkBGOqcNxZc=;
        b=GgjXFiV5anVbcrKzyRo8IlmgqwPJOjvInuN1YUQw6EZaMdORA1fpXjVYqBI9Iw4GwT
         FL8F0Lh168lgo6mJEQnagH0baY9RsiskRVB/Pu59LW0ChWcwADc4QjOapJR1w7dHdctA
         4mF9BwE6MIrrqaXjHvuft6cxWxBMAmnTfQgZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iXc+pCg6NDrfHLMZs/ZTbqwIvgggDsDg1aWiPXDN3w281797Ui1CmbtRDn0t183+RL
         qjqmftaxMHMUyjnzm93eI1fg2sii0oHrRDXi5OZ3YN7980vtGyzav/rlXF5Wc+rdLvLg
         zoP8CMe+0djJS/Y4gC0CONTg4A5H6EZg700U0=
Received: by 10.223.127.210 with SMTP id h18mr235996fas.67.1308063429660; Tue,
 14 Jun 2011 07:57:09 -0700 (PDT)
Received: by 10.223.73.201 with HTTP; Tue, 14 Jun 2011 07:57:09 -0700 (PDT)
In-Reply-To: <8269100C7056D24A91B672AF7E5E48492D963B@exchange.GottexBrokers.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175777>

On Tuesday, June 14, 2011, Edmondo Porcu
<Edmondo.Porcu@gottexbrokers.com> wrote:
> D:\vce\GottwareNet>git cat-file -p 00\1cd91a8a3a3c99ca7aea73c96b3d2174430947
> fatal: Not a valid object name 00\1cd91a8a3a3c99ca7aea73c96b3d2174430947

Get rid of the \ after the first two digits of the hash.

-- 

-PJ
