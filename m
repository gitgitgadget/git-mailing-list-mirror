From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git, C89, and older compilers
Date: Tue, 31 Mar 2009 17:32:07 -0400
Message-ID: <76718490903311432l7fba411fw4a0afff10fdf3da4@mail.gmail.com>
References: <9D199AAA-5EC6-4E7C-AC26-0CDA68341D00@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LolaY-0007qT-MZ
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 23:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088AbZCaVcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 17:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756520AbZCaVcK
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 17:32:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:15857 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbZCaVcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 17:32:09 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2627864ywb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aucloAlEMfuQxyktI5lvdg/b97mfM8S1PBsWr+tzZK4=;
        b=vgX2gpdtdOafd7yGA4F2juwM15iYbkBDz9sUA0LhzjRi8n+Gn5YV6OWgT8oDriXKas
         MPtBhJxUN1jPvT3rug9U4PMtcFh4uq7BQMS9GjbbVhwsWYAqDHhc6iljKpQrEq1pCVWu
         axMNCngzFd5XGqvzsO/AcQ5bnqiNz66GpRQRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jcmXAJdP5lpCmEouRAKBlhni03MYJAxpGBxAdlqoXAuwkf0PBm778NdzS+HBFgA3Mf
         PNilic9L/eQ49nTf6BdkpQLx8srWOiYK3FcLaaVPN1NnUasKCTqNhXqjCuxDuCASPUu+
         0joRyQQyXfBeDlIXwObJVtyUrUSN8dJlhxCMw=
Received: by 10.151.47.7 with SMTP id z7mr13074800ybj.64.1238535127416; Tue, 
	31 Mar 2009 14:32:07 -0700 (PDT)
In-Reply-To: <9D199AAA-5EC6-4E7C-AC26-0CDA68341D00@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115318>

On Tue, Mar 31, 2009 at 3:26 PM, Joshua Juran <jjuran@gmail.com> wrote:
> Hello,
>
> I'm porting Git to Lamp (Lamp ain't Mac POSIX), a Unix-like environment
> which runs in classic Mac OS, much like Cygwin.

Call it morbid curiosity, but, why? (If I had to guess, I'd assume a
George Mallory answer.)

j.
