From: PJ Weisberg <pjweisberg@gmail.com>
Subject: Re: Objects deleted before first commit
Date: Tue, 14 Jun 2011 07:44:13 -0700
Message-ID: <BANLkTin9_jfvtYdCsJLiWAoOvO2e1f=9SA@mail.gmail.com>
References: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>
	<BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>
	<8269100C7056D24A91B672AF7E5E48492D95BB@exchange.GottexBrokers.local>
	<BANLkTik1jTq6otRvHwbo342oH7Dwy+vs_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Edmondo Porcu <Edmondo.Porcu@gottexbrokers.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 16:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWUqp-0006AH-Tp
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 16:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab1FNOoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 10:44:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52419 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1FNOoO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 10:44:14 -0400
Received: by fxm17 with SMTP id 17so3736030fxm.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SsT7wUYFGRIMLFaLhbEA4ZTlbpI3wpHVIQvGOamAlgc=;
        b=Psrq21egerlHjpe7trMUpofcTujFR+x2Is5ph4NLltBCcPq79Gmkp0QmStO6uaFquc
         qK/iOzgqfcGL5j/danOOf5E4/st0osG6SC0KgIeruK4CSiF36IOld1/absHHG80dRUpL
         TY3D8QE2ayfiaBrcldGUx00mdbaCcVzr9mQ2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=K85eo/9uEBKLYN1E0AbGF6uG0isqI2K16XPXa7k6VWEIFbyv1CtD3M0TpzOBTpA24E
         KcBr5G6rak8C9d+3FN05AP0UiOLZEl8SPw81k/oiiwlTkxeNhxxzzNvKj0CcDnzS4kCp
         irrODD4Hgw5odmFdUlnaLWwtQw51W5qdA9dVI=
Received: by 10.223.161.194 with SMTP id s2mr23887fax.143.1308062653434; Tue,
 14 Jun 2011 07:44:13 -0700 (PDT)
Received: by 10.223.73.201 with HTTP; Tue, 14 Jun 2011 07:44:13 -0700 (PDT)
In-Reply-To: <BANLkTik1jTq6otRvHwbo342oH7Dwy+vs_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175774>

On Tuesday, June 14, 2011, David Barr <davidbarr@google.com> wrote:
> On Tue, Jun 14, 2011 at 11:00 PM, Edmondo Porcu
> <Edmondo.Porcu@gottexbrokers.com> wrote:
>> dangling blob 43cb00bb9f23b73afc874c4105b136f8c426e4a5
>> dangling blob 48ef642adb1549ee1d4040ec9337d3a47c19d422
> [...]
>
> Was it 'rm -rf' or 'git rm -rf'?
> If just the non-git command, maybe 'git checkout -- <missing paths>'?

Not if it was never checked in, unfortunately.

'git cat-file -p <hash>' prints the contents of the file.  It's up to
you to figure out which is the version you want and what the filenames
were.

-- 

-PJ
