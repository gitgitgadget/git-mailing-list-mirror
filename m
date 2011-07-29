From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Unusual behavior from git describe
Date: Fri, 29 Jul 2011 23:55:07 +0200
Message-ID: <CAGdFq_hYiBoqNmNtBKBqNN4XLLKwxDMHJfAUwdHB_iCcya=DOQ@mail.gmail.com>
References: <CA+jCPNcOe_dd6fsHDvWtoXEQE+xyd=aaSbfjpjQ8UfyFnvXTfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 23:55:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmv28-0006q0-MO
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 23:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab1G2Vzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 17:55:48 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61489 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab1G2Vzr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 17:55:47 -0400
Received: by pzk37 with SMTP id 37so7005579pzk.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DHZK/XxBqj4NrQ/+qxjhLhTlJtwONJ/OKRALVBdJTXo=;
        b=uAa2NaPGBblLNqBLjoTdaqwsBhnHKBMW+ZcXQLUVNuYk1VNlZTfDvDV6zs8o9KCP1X
         f+kKwMuEjS5j8GGWdX3XCpS2FEwovGgOuR9tw4fjoxxuUJpl9JrSWsiBUqetoMj2O950
         Ck7ydNZ4HSD42cnJUCtXxfI1wemfbfJrsKPsI=
Received: by 10.68.23.33 with SMTP id j1mr3044434pbf.243.1311976547096; Fri,
 29 Jul 2011 14:55:47 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Fri, 29 Jul 2011 14:55:07 -0700 (PDT)
In-Reply-To: <CA+jCPNcOe_dd6fsHDvWtoXEQE+xyd=aaSbfjpjQ8UfyFnvXTfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178170>

Heya,

On Fri, Jul 29, 2011 at 23:46, Allan Caffee <allan.caffee@gmail.com> wrote:
> % git describe --tags --dirty
> v0.0.3-dirty
>
> % git status
> # On branch master
> nothing to commit (working directory clean)
>
> % git describe --tags --dirty
> v0.0.3

Perhaps git describe does not update the index (properly?), which 'git
status' then does, correcting it?

-- 
Cheers,

Sverre Rabbelier
