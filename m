From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree: directory mismatch
Date: Wed, 25 Nov 2009 13:28:52 -0500
Message-ID: <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com> 
	<32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com> 
	<20091125080812.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Fournier <marc.fournier@camptocamp.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 19:29:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDMcD-0005qJ-P5
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 19:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193AbZKYS3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 13:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbZKYS3I
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 13:29:08 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:49932 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759080AbZKYS3H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 13:29:07 -0500
Received: by ywh12 with SMTP id 12so7828424ywh.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/5AXgo5QiRzNEDZmKafeBqvAd+MIsMRXgUyB0tHzxgE=;
        b=O0DaLxUuS/yX1wxZP9TfHN2aIVABfDqw2tpH2shbtJTSzFJhAP0C4YQBuI8du0faKn
         NHrL+JQFnDb5G3Edo+OCKZ4HtXlCPAyBfyLH1SvRkQY6DxtDd4+OnXV97Y6gWjymkSUD
         QNfY/r3xoka0nTw6SPVwahXp72TpdWWeWOUxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LcbtK+UMC2pB8nF25Dc9K5FpTCZJ93M+Z/Gt4P2awbRMWwRDPdiGFedUZ81O4sQLjv
         52dOD7ipkqIt56+AzGneydtSPYHuKzzE0aCKz6sVXyw0nmHl0zyRhoizo2bbD0ZD4qQ0
         Mhw4MZIU2y+NrgC5ZNKUPHxISCtySAsj+wzYM=
Received: by 10.150.240.21 with SMTP id n21mr14167271ybh.165.1259173752156; 
	Wed, 25 Nov 2009 10:29:12 -0800 (PST)
In-Reply-To: <20091125080812.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133658>

On Tue, Nov 24, 2009 at 6:08 PM, Nanako Shiraishi <nanako3@lavabit.com>=
 wrote:
> Quoting Avery Pennarun <apenwarr@gmail.com>
>
>> Yup. =A0This is basically a bug in "git merge -s subtree": it guesse=
s
>> which subtree to merge into, rather than actually taking a prefix
>> parameter. =A0I've been meaning to either submit a patch for this, o=
r
>> find a way to work around it.
>
> Probably you can save time by using what was already done
>
> http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=3D=
89021

Hi Nanako,

I've read through the thread (I do remember skimming it awhile ago)
but can't find patches for the syntax actually under discussion.  I
found a patch that introduces "-s theirs", which was summarily shot
down in favour of adding -X support, but I can't find any actual patch
for this.  Moreover, git-merge seems to have been ported to C since
then, so I guess it wouldn't apply anyway.  And I can't find any
implementation at all for the discussed "-Xsubtree=3D" option, which I'=
m
guessing didn't actually ever get done.

Am I missing something?  It looks fairly easy to throw in anyway, but
it's even easier if someone has already done it :)

Thanks,

Avery
