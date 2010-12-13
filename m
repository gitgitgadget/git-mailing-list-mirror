From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Corruption in the repository
Date: Mon, 13 Dec 2010 17:34:57 +0100
Message-ID: <AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>
To: Sylvestre Ledru <sylvestre.ledru@scilab.org>
X-From: git-owner@vger.kernel.org Mon Dec 13 17:35:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSBMg-000446-32
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 17:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab0LMQe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 11:34:59 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:52547 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab0LMQe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 11:34:59 -0500
Received: by wwi17 with SMTP id 17so3733875wwi.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=nsbM4uncgalhPsWJAcsk1NgF+pM9sLB9XjXPhqIL99k=;
        b=fNVifi6vxRMz5zsxAjYCKWVD8xlb5iaAT7PagnQGg9Cxt98h6NiqWxwCW390bT71Mb
         8DfI/ei5MTDJ5xmUy+knMvaLmdmf1pj9b0BFBUUKYkgyHyLxbiXElme0QBBy56zcAsse
         SVemDJmiYSxa5fYnmVI6cHQUpwfdZSHDItA6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xkN52ZR0qshQHbzO84ls2ZJTugVmHiZ7ezWh+F7r0XjkC0gNBBkk1simYRxdJYheBT
         XSD/h5QxHkw80FWR42DhPMw/EI7M2KmtUt6slcLdSe41StQOQ73zZRj4fcJ3U0Sdof0i
         GzSJzbLpHOWaQikhj3mbuaEZEH1Q1niy6B9NM=
Received: by 10.216.168.82 with SMTP id j60mr3263387wel.47.1292258097083; Mon,
 13 Dec 2010 08:34:57 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Mon, 13 Dec 2010 08:34:57 -0800 (PST)
In-Reply-To: <1292255990.25237.27642.camel@korcula.inria.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163563>

Hi,

On Mon, Dec 13, 2010 at 4:59 PM, Sylvestre Ledru
<sylvestre.ledru@scilab.org> wrote:
> Hello guys,
>
> I have a small problem with a git repository and I haven't find a way to
> fix my problem.
> I am using git with gerrit [1] as frontend (even if I don't think it is
> related here).
> For an unknown reason, the repository just became corrupted.
>
> When I try to clone the repository straight with the file system, the
> following error is displayed:
> error: refs/changes/98/398/1 does not point to a valid object!
> error: refs/changes/98/398/2 does not point to a valid object!
> fatal: object cff52c24fba28408e7d021a8f35a717bef31521d is corrupted
> fatal: The remote end hung up unexpectedly
>
> git-prune & git-fsck both fail.
>
> Does anyone know how to repair this error ?

Did you try what the FAQ suggests:

https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broken_repository.3F

?

Regards,
Christian.
