From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 4/4] msvc: Add a definition of NORETURN compatible with 
	msvc compiler
Date: Wed, 20 Jan 2010 22:45:29 +0100
Message-ID: <40aa078e1001201345p1cf9dfbbm651f1ba7244a340f@mail.gmail.com>
References: <4B575D48.9070508@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:45:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXiMo-0004UV-Q3
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0ATVpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439Ab0ATVpb
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:45:31 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42081 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0ATVpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:45:31 -0500
Received: by ewy1 with SMTP id 1so3536792ewy.28
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 13:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=i+7b4I7keDCBfMNjVSD/kSAEpRHCpG+ijdS4ls4Gj8o=;
        b=pea18PjOsI+pN/hSSahXbAIL4cD2UFDglZTvC2LLKEP5zgZQDUL+LSx1PoUk5qVQBM
         FGM9KcF59gsivtniLcWeCvW3JRJWjXFWH3lA1jkWHXwBqqU3X+qiEuTPuxTt2vj0WK/g
         uc18TbCSgB8ko64oNRuXVDh77WbWCcRrU5u1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=OP2OtpV1mPds71vCIVcEEHOmA3L422D95rSaTTZlieYTxp9UnzQUSBjMWDOjCw57MA
         MVw3QGh5qIuY21Scjc86kjBJArJ7MHWEuNppKw+dTn81oOW24QdWLVifuGn8JlvbJbvO
         oA5ifEUNme7WURjRGFavCwMWvwtxtFwF+V76I=
Received: by 10.216.89.202 with SMTP id c52mr210782wef.215.1264023929471; Wed, 
	20 Jan 2010 13:45:29 -0800 (PST)
In-Reply-To: <4B575D48.9070508@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137588>

On Wed, Jan 20, 2010 at 8:45 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> I thought that Erik had already submitted this patch along with
> those that resulted in commits a4f3131c and 18660bc9. However, I
> don't seem to be able to find it anywhere! (maybe I only imagined
> it).
>
> If you find Erik's patch, please apply that instead...
>

I don't think I ever sent one - I haven't bothered to set up msvc for
git compilation, so I only did the preparation (and I think I sent a
comment about how it could be done).

So, thanks for following it up! :)

-- 
Erik "kusma" Faye-Lund
