From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Wed, 24 Nov 2010 20:48:52 +0000
Message-ID: <AANLkTin4Y35M+tD8sQmd6C_VikBdx_W2GQjrNANAeW3O@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>
	<AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
	<AANLkTim-1uKTVacr1N=9bhZ+=ngggrJS=GD-YNjkSuBR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wilbert van Dolleweerd <wilbert@arentheym.com>,
	Git ML <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 21:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLMGx-0005G2-8W
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473Ab0KXUsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 15:48:54 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38460 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab0KXUsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 15:48:53 -0500
Received: by qyk11 with SMTP id 11so4826497qyk.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 12:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=RWBZF39+AbGxkym5kTe332GSxoJRk/ae1BeTVTXFuMQ=;
        b=HaGr3+oo6YLh3MwfvCWxwquyzQ9ob/299/TgVI6ZMuEaNoxKxbzLxFCt1wVc7g9qBB
         OUfyF5nhejNcnQCm7PRIo838JVo2w0rJCRJYAB6r7utkrDOFArPI6DaSLrwnuLvqIoGV
         zftWe7OYFqlALolZJMhCiDwxpc0AbIB+I5f3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LY3/rnTuCW69hBQ1u9yCoueoTPQQUy3QuChn2upRk1bxJOyBeqYGa92iWID+RfCNKg
         AXmFZ9oa2nfyftgxooGXjnFW9T89fkEossvIodOXXHHEbir/DkCFUSHlZEWl2xl/WgY4
         QpWd9gNb5Q5R2wy52QaIhiytzCFgXIOpBFK7w=
Received: by 10.229.184.204 with SMTP id cl12mr6847275qcb.228.1290631732658;
 Wed, 24 Nov 2010 12:48:52 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Wed, 24 Nov 2010 12:48:52 -0800 (PST)
In-Reply-To: <AANLkTim-1uKTVacr1N=9bhZ+=ngggrJS=GD-YNjkSuBR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162083>

On Wed, Nov 24, 2010 at 2:16 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> What does the structure of your working tree look like? I think the
> depth might be affecting performance.

I don't think there's anything special about it; it's a big tree, so
naturally we have some deep (15-level) directory branches. Any
particular reason you suspect the depth?

.D
