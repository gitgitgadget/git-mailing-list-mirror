From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH] diff: bugfix: binary file permission regression
Date: Fri, 11 Jun 2010 17:45:30 +0800
Message-ID: <AANLkTikTyEjheFwI0x3svV8SWMkhksE6q2aspI2rww-l@mail.gmail.com>
References: <1276194685-28098-1-git-send-email-ayiehere@gmail.com>
	<AANLkTimwmkMnaqMY44SeHz1L8hE2Lp324PXPY4eqvTGb@mail.gmail.com>
	<AANLkTikWNaEY5aErPF7OkBMleN_hiFRholfdFXLF1cJO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 11:45:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON0nx-0006hl-Sg
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 11:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab0FKJpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 05:45:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63450 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab0FKJpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 05:45:32 -0400
Received: by gwj15 with SMTP id 15so545589gwj.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Uf3K/cjRJQi70/zwwFTKClgW8TgKwh8oPcTaIK6D7Pc=;
        b=ChV8ZSf/l26zBet10DSDcCN6Yft3ShITfc0hK6rFjTbAzRT1iMT3PZADnA859+6HGm
         iD0EscHAXbW1liKVfufewmuPSNvgSujejfQ9JTSPq+vUMvgwBPyrKt0gB1EeDQx5YjtT
         oxn48jpVJiHd9gJ4JuS7xjduyY/rCcS5N4V2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MewDqSB4052nPQPVP1EOiWzKCg976pUl53RxQzyUZYA4DIXwZejHAaUxoMr3dMmXkj
         H9tLx02PYGgIv2Hu6CguG6FmYBHffvNdFWRMpjB1oKbiUWQtidEVZjy/ihgPi1/S0+XB
         XFSeyNvofO3YoawothQOLLJpevGyT5Q0VUMHQ=
Received: by 10.90.204.19 with SMTP id b19mr2128008agg.139.1276249530906; Fri, 
	11 Jun 2010 02:45:30 -0700 (PDT)
Received: by 10.90.114.16 with HTTP; Fri, 11 Jun 2010 02:45:30 -0700 (PDT)
In-Reply-To: <AANLkTikWNaEY5aErPF7OkBMleN_hiFRholfdFXLF1cJO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148933>

On Fri, Jun 11, 2010 at 3:24 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Please have a look at this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/147732/
>
> The patch resulting from the thread is currently in next and pu.

Thank you for the heads-up.

nazri.

Note to self: google <bad commit sha1> before bugging list.
