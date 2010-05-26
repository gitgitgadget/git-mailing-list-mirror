From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: bug with 'cl' as alias for 'clone'
Date: Wed, 26 May 2010 15:07:18 +0200
Message-ID: <AANLkTinSKgn5IgO3F-gqy-7RTs36Xe_9NB1dvRQrq4SK@mail.gmail.com>
References: <E4D176D9-E1D2-4C8F-8F18-11060E49ED80@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: James Tucker <jftucker@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 15:07:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHGKp-0001tE-3N
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 15:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab0EZNHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 09:07:42 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:46741 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab0EZNHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 09:07:39 -0400
Received: by qyk13 with SMTP id 13so9042654qyk.1
        for <git@vger.kernel.org>; Wed, 26 May 2010 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=rdcvtmclTmR7wlsmk7W8S6Ee7v3te/8jcN+fo4uB9hA=;
        b=ur6D3bI+MbMM/Gam7qav9wEycBi6rax8GhZVyeuwh05pH2qKD4RqWnRmQUOOSmFnbE
         NNySZ3iaUJZOkzTKWYWV0YaQZwsWAe5jT59DPJ+Rs8By8HJY5j5woLRk12GD1gEbxrHU
         TVMGpYHA+lNJRWpoksPN0+25rncKgAjUIWL4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lTymSBhIlXZYq8S2Q89bAsFmLWoLffjpzknmkLoIbTavsx7w18qg7bIP6a4lfu9QXH
         InjTO72qvBIHrgn+NwZdvkuYxfLtIjdKXKonSwqcu7oJE03IHp1y+c5ttKk8LZx7zR4v
         WXiZDCzPZn0FMMMyPtDx9VaJjSWeYj84KEzdg=
Received: by 10.224.124.9 with SMTP id s9mr4844026qar.4.1274879258166; Wed, 26 
	May 2010 06:07:38 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Wed, 26 May 2010 06:07:18 -0700 (PDT)
In-Reply-To: <E4D176D9-E1D2-4C8F-8F18-11060E49ED80@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147794>

Hi,

On Wed, May 26, 2010 at 2:48 PM, James Tucker <jftucker@gmail.com> wrote:
> % g cl http://github.com/erikh/rdbi.git
> fatal: cannot set work tree after initialization

I'm not able to reproduce this with Git 1.7. Which version are you using?

-- Ram
