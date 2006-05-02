From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: Features ask for git-send-email
Date: Wed, 3 May 2006 01:51:36 +0200
Message-ID: <4fb292fa0605021651y1e0cbb69w7f34257bacca716f@mail.gmail.com>
References: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
	 <1146573417.14059.21.camel@pmac.infradead.org>
	 <4fb292fa0605021546i45c740c4i42c64125b8c560e@mail.gmail.com>
	 <1146612793.19101.50.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 03 01:51:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4ea-0005dt-Qc
	for gcvg-git@gmane.org; Wed, 03 May 2006 01:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWEBXvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 19:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWEBXvi
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 19:51:38 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:35261 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965041AbWEBXvh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 19:51:37 -0400
Received: by nf-out-0910.google.com with SMTP id x37so30626nfc
        for <git@vger.kernel.org>; Tue, 02 May 2006 16:51:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hsS93mBjJ1xYDk/EfSx4dUwjf1QKUN0rTFq/52mQfBYPbadbxCRw84kzgnumCBl8IhieTtULPLfYBELu/6ziTzxChrbVKhqldOKwGqRGE6ZMvhe2RkltXMEvBwcE4Tx9tkn5iykgIThR7e2OtHb6MhIjLX30SyMY/p7X4GCLZDM=
Received: by 10.49.5.14 with SMTP id h14mr940448nfi;
        Tue, 02 May 2006 16:51:36 -0700 (PDT)
Received: by 10.49.2.19 with HTTP; Tue, 2 May 2006 16:51:36 -0700 (PDT)
To: "David Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <1146612793.19101.50.camel@pmac.infradead.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19445>

On 5/3/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2006-05-03 at 00:46 +0200, Bertrand Jacquin wrote:
> > I tryed it. I used this patch again master git git release
> >
> > And I got the following with git-send-email :
> >
> > Use of uninitialized value in hash element at /usr/bin/git-send-email line 437.
> > Use of uninitialized value in hash element at /usr/bin/git-send-email line 437.
> > <>: missing or malformed local part
>
> Interesting; it worked for me. Does the same happen _without_ the patch
> applied?

It appear without in 1.3.1 and I can't seed mail with too.
Also, 1.2.4 work fine here (without patch).

I don't make any test for other version (too tired for now).

I use exim 4.60 as SMTP server (if it can help).

--
Beber
#e.fr@freenode
