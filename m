From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv3 GSoC] git-instaweb: Configure it to work with new gitweb 
	structure
Date: Mon, 24 May 2010 20:44:13 +0530
Message-ID: <AANLkTineGWscmBAY-rjIIEQBNHVyzXUKHJ8WGXd53yCw@mail.gmail.com>
References: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
	 <201005241155.30653.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, normalperson@yhbt.net,
	pasky@ucw.cz
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 24 17:22:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGZTd-0004YP-91
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 17:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab0EXPV4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 11:21:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50254 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab0EXPVz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 11:21:55 -0400
Received: by gyg13 with SMTP id 13so1528439gyg.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=meVj5/U0X/NQ52lkEj1+lReGz23UdXtYN2Wx/vY5tvI=;
        b=IOU90Tq2X3C/R5iksx5OzDraL8N5H64iw+8k6fqjMEDG1gmS3TVnuu3GehtN71By5+
         XR8zEzCF44bvRUnRa30wZww9T0jxW19Jf1HYmm3AgDiwQMGQyqU4jOp2iuklp3LFsdxF
         ulBB+jNpT/dAX5eeRFLXm15z1AdN0+DDYDFRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DMI4icy+bq+X6idqThEJjY7oszjdllDDGBCe7LvReEzyDMYfuOJYn8bThisDKJQNgP
         7n5M+8UiSKcJXD+Dre9YHhEhBXWKvBHUYjsn4AHZw6AxzzTMFyGRs5XVaz4TLCq0tkPd
         ucn3W/sXAEGYxrqdhoIKKSq8VFqzay8o8UGoY=
Received: by 10.91.126.13 with SMTP id d13mr2957382agn.99.1274714053458; Mon, 
	24 May 2010 08:14:13 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Mon, 24 May 2010 08:14:13 -0700 (PDT)
In-Reply-To: <201005241155.30653.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147635>

On Mon, May 24, 2010 at 3:25 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Hi Pavan,
>
> On Sunday 23 May 2010 09:32:48 Pavan Kumar Sunkara wrote:
>>
>> This patch is based on 'jn/gitweb-install' in the next branch by Jak=
ub
>> =A0Nareski and my previous 2 patches:
>> * gitweb: Move static files into seperate subdirectory
>> =A0http://article.gmane.org/gmane.comp.version-control.git/147321
>> * gitweb: Set default destination directory for installing gitweb in
>> =A0Makefile http://article.gmane.org/gmane.comp.version-control.git/=
147160
>
> I tried to apply your 2 patches on top of next I got some errors with=
 the
> "Move static files into seperate subdirectory" patch.

It is a small error in Makefile only with this patch. The others are ok=
=2E
I teseted it with alt-git.git repository's next branch.
So, I will be sending only that patch once again.

> Could you resend the 3 patches in a patch series after making sure th=
at they
> apply on top of next?
>
> And I think that it would be better if the web server logs would be i=
n a
> directory with the web server name. For example
> "$fqgitdir/gitweb/$httpd/access.log" instead of "$fqgitdir/gitweb/acc=
ess.log".
> But it would be nice if you make these changes (as well as the apache=
2
> confguration changes) in another patch.
>

Yeah. Sure.

- Pavan
