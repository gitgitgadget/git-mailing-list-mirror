From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] StGit: export: fix base commit reporting in series file
Date: Wed, 24 Nov 2010 16:57:48 +0000
Message-ID: <AANLkTi=8-Y80CrrTYr0i1gcPP_SPxbwHiqB7LhgZF9GA@mail.gmail.com>
References: <20101121155706.16544.20984.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 17:58:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLIfV-0006l0-94
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 17:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab0KXQ5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 11:57:51 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64840 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718Ab0KXQ5u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 11:57:50 -0500
Received: by gwj20 with SMTP id 20so910394gwj.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 08:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=GWVXyLSV2t1n7MdGlqfy5tNEMBnyh4VBKpq7rQSa8HE=;
        b=ojff2B11EPPUxLNKDz3a3PyoSgCoo6+i0Uw6h4FL3XzkcxpjwQ/SQVwjSiuphz55Sk
         LWtom2fiarHfcaJnOoW6PsZqSIh3J32DoG9ueod2RlnF4MvTt6vZwYCtPxppuZ+DFGQ2
         VqvqocMrmlja5a+oU7XuvF3Pf2/i+0i5kKiDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uurxm6iLyG7dsnAHS3LMNvwSo8ICIpPH2wi3YE5APDFfCHzcXQYtZc2d5DnLq1msx4
         Srwyz5aFF+vBxr7SE8Qw+K2W4wodkThg3/4I6I7qJbno4Kyj8nCKSJ2rICSotAVrNFyD
         armMcREVu1YzyvAxRl/dqAN5JJiE/hZCu9AH0=
Received: by 10.150.138.18 with SMTP id l18mr1360199ybd.106.1290617868530;
 Wed, 24 Nov 2010 08:57:48 -0800 (PST)
Received: by 10.231.148.72 with HTTP; Wed, 24 Nov 2010 08:57:48 -0800 (PST)
In-Reply-To: <20101121155706.16544.20984.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162067>

On 21 November 2010 15:57, Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:
> This bug was introduced in 3f19450c426970b78b19c522a82df1a962da5761
> It should report the commit stg stack is based on, but not the
> last patch in stack.
>
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Thanks, applied.

-- 
Catalin
