From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: `git submodule sync`'s purpose?
Date: Mon, 19 Apr 2010 19:35:54 -0700
Message-ID: <g2g8c9a061004191935s86a9d7a7i8dd1a361d5a0da3@mail.gmail.com>
References: <t2sc115fd3c1004191856za23ef32m421697b98159bcfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 04:36:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O43K1-0006VJ-EM
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 04:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab0DTCgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 22:36:16 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:40734 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab0DTCgP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 22:36:15 -0400
Received: by qyk9 with SMTP id 9so6621155qyk.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 19:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Qu0X/ZlIANvk6wJbUlaiPoRNNWj7Bz1z42Xv+oy11uI=;
        b=sLzbiZSf1PelT8UZgyg2eSgigirUt9/sShUHYQinyTBjPI8vFoe94ngwQEIfckmXhA
         4wA8nq/+BvSGbR4h+EnPTR3CSmc+1Suoa6diC1xgSaI4m7rBqoESO1F04rx2iJrrrWXQ
         8IQ2W7EkqJlhyXfUZB3d9J0q/bf9YPb080rL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TxqTeQrKnN+V2qvX7wB+XCsn80IExrQnDfDJYpmR1TnuG3iwNycIctO3IOnG87Ynde
         x3v2PR9WVq0i9hO+3HQqgEOCht8Z4e1tINyYmisLl/srOVBrv2Zb/8+imBOmdxO6wWZJ
         xxd1t/wzjNBeWzSn3CeTBAmR7w3drVbbWlcco=
Received: by 10.229.50.72 with HTTP; Mon, 19 Apr 2010 19:35:54 -0700 (PDT)
In-Reply-To: <t2sc115fd3c1004191856za23ef32m421697b98159bcfe@mail.gmail.com>
Received: by 10.229.227.83 with SMTP id iz19mr2565047qcb.44.1271730974196; 
	Mon, 19 Apr 2010 19:36:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145348>

On Mon, Apr 19, 2010 at 18:56, Tim Visher <tim.visher@gmail.com> wrote:
> Hi everyone,
>
> trying to understand if I'm just failing to parse the docs for `git
> submodule sync`. =C2=A0I'm basically under the impression that I can =
edit
> the .gitmodules file by hand and then use that command to sync up my
> submodules witin .git/config to that value. =C2=A0Am I totally missin=
g
> something?
>
> An example session can be found on [pastebin][].
>
> [pastebin]: http://pastebin.com/chEdc2u5
>
> Thanks in advance!
>

I think the point is more that you can edit .git/config to point a
submodule at a different location (say you have a copy of the
submodule repo somewhere with some changes you want to try out), and
then can use "git submodule sync" to get the entry in .git/config
"back in sync" with the canonical location for the submodule.

-Jacob
