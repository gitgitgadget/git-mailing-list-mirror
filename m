From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: diff/apply statistics
Date: Fri, 3 Feb 2012 09:15:11 +0800
Message-ID: <CANYiYbFBDtK5SiYZV41vWxjjQw3GT4+9kcESpV69sNDWgZ26QQ@mail.gmail.com>
References: <1328116977-61458-1-git-send-email-worldhello.net@gmail.com>
	<CACsJy8DrNHwLGJjj4nJHDm-NEsr6c=QW-kgxmTbsRxq057keWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 02:15:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7kG-0007VN-1p
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 02:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511Ab2BCBPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 20:15:13 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64880 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab2BCBPM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 20:15:12 -0500
Received: by ggnh1 with SMTP id h1so1608088ggn.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 17:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZrLuKM5N4MMnYV7fY80sMs8Z8iwoLX96uZJ/+HTpdZg=;
        b=EyBjlAw1ffLRluyPVDai0ln9LHN/IqVvRYGXPTSKC2J2sDIKHw0YhIuRdBmmALePLQ
         BqO4OYFCnDRiobINqJsNvnFw0wWrJ6ShNBW9bDzh1AfR/0j58KbxPTcL5sC0oqowHtdF
         cGiC9k8okeBp/44gleKXlexG6SGNBRcL9lWuI=
Received: by 10.236.182.232 with SMTP id o68mr7953529yhm.58.1328231711659;
 Thu, 02 Feb 2012 17:15:11 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Thu, 2 Feb 2012 17:15:11 -0800 (PST)
In-Reply-To: <CACsJy8DrNHwLGJjj4nJHDm-NEsr6c=QW-kgxmTbsRxq057keWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189728>

2012/2/2 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> On Thu, Feb 2, 2012 at 12:22 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
>> translate oneline statistics of diff/apply.
>
> There's another patch with similar goal:
>
> http://thread.gmane.org/gmane.comp.version-control.git/189453/focus=189509

It's cool, especially the call of interactive_use, so that
translations for the statistics line is only for human, not for scripts/pipe...

--
Jiang Xin
