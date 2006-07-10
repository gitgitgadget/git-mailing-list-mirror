From: "Peter Gervai" <grin@grin.hu>
Subject: Re: newbie'ish FAQ/question about merging different trees
Date: Mon, 10 Jul 2006 15:10:13 +0200
Message-ID: <d55656c10607100610q1f3b63fcjb706f122d1a502de@mail.gmail.com>
References: <d55656c10607100456o761bb342p3db229b499579dd9@mail.gmail.com>
	 <81b0412b0607100531k6fc6921do1990850aef259dba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 15:10:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzvWp-0001G3-C8
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 15:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWGJNKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 09:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWGJNKR
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 09:10:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:46703 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161116AbWGJNKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 09:10:15 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3868707ugf
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 06:10:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rOukA15cxFISVhcR2BSPLIm/AepeEXpSoEF/RWK1DcuhA6mvlUrL+0ogJFeyHOhxaWDp3H9I+ESRqev9TMAl/McSVqyfdzsOodZbcNGYwNDk/ap0ihttTwc6rD/3e1GOc2TFJL/jSF6HejTODAKJ+E8kNwqAti/gdbB7OpeS8eo=
Received: by 10.78.178.5 with SMTP id a5mr1641289huf;
        Mon, 10 Jul 2006 06:10:13 -0700 (PDT)
Received: by 10.78.53.1 with HTTP; Mon, 10 Jul 2006 06:10:13 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0607100531k6fc6921do1990850aef259dba@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 9215d035cfaa704b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23618>

On 7/10/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 7/10/06, Peter Gervai <grin@grin.hu> wrote:
> > There are two trees on kernel.org's git:
> >
> > linux/kernel/git/jejb/aic94xx-sas-2.6.git  (it seems to be at 2.6.16-rc5)
> > linux/kernel/git/torvalds/linux-2.6.git (it probably does have a tag
> > at v2.6.17.4)
>
> It doesn't. The stable tags are in stable per-release repo
> (linux-2.6.17.y.git currently)

Well, even that would do.

> > Is there a way to merge these to produce 2.6.17.4 (latest released), patched?
>
> Why, doesn't "git pull aic94xx-sas-2.6.git master" work anymore?

s/Why,/The answer /;
s/ anymore/s for you, right?/;

:)

Thanks, it merged. It does not compile, but that's what I get using
git trees. :)
