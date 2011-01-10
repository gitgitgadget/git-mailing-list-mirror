From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 10:52:51 -0600
Message-ID: <20110110165251.GB7714@burratino>
References: <4d2b3198.674034bb.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Mon Jan 10 17:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcKzi-0006oY-EH
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 17:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab1AJQxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 11:53:04 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40308 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab1AJQxD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jan 2011 11:53:03 -0500
Received: by iwn9 with SMTP id 9so19334095iwn.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 08:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qDzA7NtG3MRNwD7+oKR49EU78eRiOpUKUsa+0V+Ayqc=;
        b=j6RtIEUXJBTQwJJVfRnfk9TBlisJlX4E9UzL4y5EsBCaGGHnWLhsGxRjwr/px2/WTc
         vxtaw1KnNRGHy7JO1+YyB/MbY6yGmQqpjrEACL5KuhLpF3JfpIMvCJMl9v0kFEaNav24
         Cgz8gxam/fy+kEDZ5SexCF9BbV333uZgOfNoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QDdtc9ddEjm+3Zj4+tg2qLTxs1v0puS8C++JvpbQjlhupRQ9gpDhcJc9mNzYi9tQ4R
         isLr4/E1JSJRb7s/6mxVkD6Wa0tp5rBnxskP6btqPlYn45+YRDZGmNsiLpLf9M2d5v6W
         NXYS9eal/2wPJeL4U1dWVJc2BL9ufZzlTOT0E=
Received: by 10.42.171.201 with SMTP id k9mr4498299icz.498.1294678381919;
        Mon, 10 Jan 2011 08:53:01 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id he5sm3779280icb.10.2011.01.10.08.52.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 08:52:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4d2b3198.674034bb.bm000@wupperonline.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164881>

Ingo Br=C3=BCckl wrote:

> The tests after '--set in alternative GIT_CONFIG' failed because
> variable GIT_CONFIG was still set.
[...]
> Is it only me (bash 3.2.48(1)-release) experiencing these failures?

Could you explain the nature of the failures in more detail?  What
version of git are you building?  Is GIT_CONFIG already set in the
environment before you run t1300-repo-config.sh (it shouldn't matter)?
How does output from "sh t1300-repo-config.sh -v -i" end?  If that
doesn't end up being helpful, how about "GIT_TRACE=3D1 sh -x
t1300-repo-config.sh -v -i"?

Regards,
Jonathan
