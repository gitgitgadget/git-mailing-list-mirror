From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tool and worktree
Date: Mon, 9 Feb 2009 02:17:50 +0100
Message-ID: <2c6b72b30902081717q35fd4ba0k6ff5b1be8cd5ef2c@mail.gmail.com>
References: <20090208034406.GB7230@b2j>
	 <2c6b72b30902080147u61412b04w24baa0e5fdc29584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWKnx-0004ZH-AX
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 02:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbZBIBRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 20:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbZBIBRx
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 20:17:53 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:30472 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZBIBRx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 20:17:53 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1315698fkf.5
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 17:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=eaSLdaAbZaq2tCmE3z47iYhsBOWb3ajy5Bg7bMFWpUY=;
        b=riz8yK8Sn78nPQB3F3ZR9Zs2HSkN9mIoKN/nXD/zBKh0t0pq0P9dRO5Z2zy3KR8Dsb
         Y7AcE29s5HDTu9mIn0Z1e/m07bMlX53ifnid5FTc4LNiPBmxmKywsM1OvPmkGN2oASdy
         gyq8zvcw/1KZG3kpTSvpOF8EBPH0o4qk78l7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=PndOOsVfMglRleq56KYhI/pCLupxuhOvTmRiOKYutdkzCKAGexTNmp3IcyTQGQ7liW
         OGITnMel7LlagoXN0N/pmwe3NDOstsR+ucYrwZYY+bcGYYjMSYimyVlVpoM6J7fWzzFl
         5QV/qn3VogcAzYR4iLZ05PNN460KHiSDVueGA=
Received: by 10.180.233.15 with SMTP id f15mr536567bkh.188.1234142270834; Sun, 
	08 Feb 2009 17:17:50 -0800 (PST)
In-Reply-To: <2c6b72b30902080147u61412b04w24baa0e5fdc29584@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109030>

On Sun, Feb 8, 2009 at 10:47, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> It might be as
> simple as setting the GIT_DIR environment to getcwd() + output of
> git-rev-parse --git-dir and then chdir() to core.worktree.

I have pushed a lightly tested patch that does something like this ...

-- 
Jonas Fonseca
