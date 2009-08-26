From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git only one file
Date: Wed, 26 Aug 2009 06:30:42 +0200
Message-ID: <cb7bb73a0908252130u792a328bta1e186ff8f5454b8@mail.gmail.com>
References: <synhedionn@gmail.com> <1251235768-24921-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<a7c6f4d60908251605l5fb771a5t79b27cf688fab205@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: syn hedionn <synhedionn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 06:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgAAC-0007PH-R9
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 06:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbZHZEbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 00:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZHZEbD
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 00:31:03 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50350 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbZHZEbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 00:31:01 -0400
Received: by bwz19 with SMTP id 19so2315056bwz.37
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vqrlDfnSpVwfAqYb+VAtXwht7wleX7NhkwkxzYY74/E=;
        b=tApkAg6ecaWGCLdcT6DA5PgZjJS/Pkd3ACLLbSWQNpp+veDervRUJb8hBxsoQwwLJE
         DG4/Jy8giaZ/E1raO4iBixqowkFpmC62abbueCe70U5gLHxleDCvgJvvSAkFzwAwPyE5
         HknHh26I7KCevHBLP0ziGwseAww725r2xvy8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kUJj4+5z/YwsaP02a6vgx6w1T+vjC5Q6CR8vQ4j162hQrNGIQIuymSxTev6uI9L1FY
         oXdnTcaWwFNf1cxj40GXHdl+BQjc6MNhpEDWZsMhU52ITPyV32YE1wdn5dPwx32o1QZa
         x31+4ei8/dwnpkbLbVSv04vcWssrDAaN2J36A=
Received: by 10.204.34.83 with SMTP id k19mr3194145bkd.96.1251261062255; Tue, 
	25 Aug 2009 21:31:02 -0700 (PDT)
In-Reply-To: <a7c6f4d60908251605l5fb771a5t79b27cf688fab205@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127064>

On Wed, Aug 26, 2009 at 1:05 AM, syn hedionn<synhedionn@gmail.com> wrote:
> ok , but if I put,
> git add index.htm
> I have:
> fatal: Not a git repository

You need to initialize the repository before you can add files to it, so:

git init
git add index.htm
git commit -m "Initial commit"

The zit way would be:

zit track index.htm
zit commit -m "Initial commit" index.htm

-- 
Giuseppe "Oblomov" Bilotta
