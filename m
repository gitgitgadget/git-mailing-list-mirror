From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Merge commit before branch tip
Date: Mon, 26 Jul 2010 12:08:44 -0400
Message-ID: <AANLkTi=dOpWKAg9vH6sR2Xdi1XitD6vOx6Pd8Nt3A2bJ@mail.gmail.com>
References: <AANLkTikp5dHz97qp3pf+DE-wABNVYTGAQ+h30D9Fa04c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 18:08:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdQEV-0003Yd-69
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 18:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab0GZQIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 12:08:46 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39071 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab0GZQIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 12:08:45 -0400
Received: by qyk8 with SMTP id 8so2017577qyk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8/UMf1zorDUQQ9NWkgEhpViYivBAvaruYUMvbRmMi3s=;
        b=YLF7OYoj6u1I5cQrjm4rC/Tf09mNW/3FRVaLcr6PcFf5RLsq1cOYbzgzwQzU2BNKUX
         XjkizYzKbR8xh1bgckGidqo5GWSLu9SSDXpnQ/UcF67kASBEFrpaaZeoyqv+SKvY+UUq
         D30fG0VGtDpSbmSKiI4Jhmwj3yayIIclDmYZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CDL54QuXB7UotqEr35mn5uo1rFgHZFjcGlrQDYkRufOUsTdkeiiFY/OdS9Ki5xqZ1O
         OzuYXrniNbFm2DxRKI4m+s4ZFGPnKQpgrQuREx4XOTQR9EAhqB+WCCZABfBPGiLs6PUm
         ck3Rox41jm053OQuI+7uRMWIz2lYRARLXZoqM=
Received: by 10.224.36.209 with SMTP id u17mr6323107qad.225.1280160525048; 
	Mon, 26 Jul 2010 09:08:45 -0700 (PDT)
Received: by 10.229.226.195 with HTTP; Mon, 26 Jul 2010 09:08:44 -0700 (PDT)
In-Reply-To: <AANLkTikp5dHz97qp3pf+DE-wABNVYTGAQ+h30D9Fa04c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151852>

On Mon, Jul 26, 2010 at 11:38 AM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> I realize this is not a best practice but is it possible to merge a
> branch but at a point before the branch tip?
>
> This came up recently for us. There are 9 new commits in our stable
> branch that need to be merged back into "master". However, there is 1
> commit (the branch tip) that we're not all that happy with and don't
> want to merge into the "master".
>
> Ideally, I'd like them to show up as a merge rather than a cherry-pick
> basically as if I'd done the merge before that latest commit was made.

Isn't the following giving you what you need?

$ git co master
$ git merge stable~1

?

Thanks,
Eugene
