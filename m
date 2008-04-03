From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [REGRESSION] git-gui
Date: Thu, 3 Apr 2008 15:00:47 +0100
Message-ID: <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre_rosa@lge.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 16:01:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhQ0T-0004Qk-Qs
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 16:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbYDCOAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 10:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbYDCOAt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 10:00:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:29703 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbYDCOAs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 10:00:48 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2317128wra.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=BcPrm6tzHr8CLuptHFgqEzkyo8Ihhd6E+rgsjnKHgN4=;
        b=KRzSKcIW/5laILgQD9p5xRBfKM9OL2sTPf8D4XntKM26NJ6zV3jjO25e5N3kEmFt7ELa8FHhG2cCXRQoDFzcBIfyftKPgZHRd8uN3JjkFCzruEUJPZAmeTl29nhy6zfXk51SPvJL1V1rIEVt3VCsVjLqDJDUGZtmC6pvXm4TGp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dcOUCgbqX54SUPjFklc2ZP3DHZk+rXVe2edYpoMBqmsziqTAWfU5OJOM1zH7ERaRIpRYax5R9VsI+qJcRcGkw+5otRVbIqzNQIwMoxoEcmDafXk8AvKqD0Hr7DQu0AApWz1yQVX7vrlIH4hes6+pPnZvxJOcRchmMGnArqqvgvY=
Received: by 10.141.162.16 with SMTP id p16mr5647797rvo.243.1207231247434;
        Thu, 03 Apr 2008 07:00:47 -0700 (PDT)
Received: by 10.141.86.15 with HTTP; Thu, 3 Apr 2008 07:00:47 -0700 (PDT)
In-Reply-To: <007901c89590$a827f7c0$93a7c10a@LGE.NET>
Content-Disposition: inline
X-Google-Sender-Auth: f4216428cfa78a6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78754>

On Thu, Apr 3, 2008 at 2:43 PM, Andr=E9 Goddard Rosa <andre_rosa@lge.co=
m> wrote:
> Hi, all!
>
>     After updating to git version 1.5.5.rc3 I always get the error be=
low
>  when starting "git gui".
>     Linux distributions used are opensuse 10 and opensuse Factory.
>
>  # git gui
>  Error in startup script: bad event type or keysym "["
>     while executing
>  "bind $ui_comm <$M1B-Key-\[> {show_less_context;break}"
>     file "/usr/bin/git-gui" linux 2718)
>
>     I think it's related to git-gui 0.10 recently added into the tree=
=2E

Doh, I broke git :(

The problem is in c91ee2bd61 (Add shortcut keys for Show More/Less Cont=
ext).
Works fine on my OS X 10.5 installation with tcl 8.4.7 - can anyone
suggest an alternative way of binding the left/right brackets?  I'm
not familiar with Tcl, and didn't manage to find a list of key names.
