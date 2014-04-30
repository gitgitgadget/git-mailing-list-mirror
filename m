From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] zsh completion: 5.0.3 compat, use emulate
Date: Wed, 30 Apr 2014 01:03:53 -0500
Message-ID: <53609249b388d_597a125b3084d@nysa.notmuch>
References: <EMXW5CZ-001FUQ-3S@ilmenite.field.spodhuis.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: Phil Pennock <pdp@spodhuis.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 08:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfNmt-00074m-Fa
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 08:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbaD3GOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 02:14:31 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:49188 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaD3GOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 02:14:31 -0400
Received: by mail-yh0-f44.google.com with SMTP id z6so1218308yhz.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=JuMRUfQ8KAXyJVd45N5hX1rwaD45hyDN+pvmR5VRS6w=;
        b=Dg9fVDQKAa5XT2hbFyIqV3MX3b/JW+CpTeCeu6ZZKI9FZFNSHSHW7DXftr7F/y7WIl
         xW4hTlISQQV1JTBHGQGWGvNHJtQBRfjiLDzC+1l/wEojInVB/v5hGTo6IzB/iSOmQZiA
         osfgQtIllB0ms0LiWFxPF46MPx/O1sKT7qhLbn/3+P9LpabXy2CLpGR5AYJcrZj6ryLu
         17HvH4RI0k7UvyDhEg7IdmquLQ6hP1wFRldKG60jSX3r4jAv95Kg/6D+FeWHqqSeTZXg
         152RllhpHixnHOCK87OSIC9moq0aVbP+rkccCBTxaEWYGrwy/wlNjxl0Qup9+R67JCEW
         DXTQ==
X-Received: by 10.236.132.134 with SMTP id o6mr2751413yhi.147.1398838470587;
        Tue, 29 Apr 2014 23:14:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id g65sm41168983yhm.28.2014.04.29.23.14.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 23:14:28 -0700 (PDT)
In-Reply-To: <EMXW5CZ-001FUQ-3S@ilmenite.field.spodhuis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247678>

Phil Pennock wrote:
> The bash completion pulled into zsh was being pulled in _as_ zsh, but
> used patterns which relied on falling through as unhandled.  In zsh
> 5.0.3 this no longer works, resulting in:
> 
>     __git_complete_remote_or_refspec:33: bad pattern: +*
> 
> Fix by telling zsh to emulate sh while sourcing the bash config file,
> which stickily preserves compatibility options in the function context.
> This usage of "emulate" came in with zsh 4.3.10, released 2009-06-01.

I'm using 5.9.5 and I don't see any issue. Howe exactly have you
configured this script?

> Signed-off-by: Phil Pennock <pdp@spodhuis.org>
> ---
> nb: I am not on the git mailing-list, please keep me CC'd.

No need to say that. This is a sane mailing list with doesn't do
reply-to munging[1], so you are Cc'ed by default, in essentially al
MUA's out there.

[1] http://felipec.wordpress.com/2010/08/03/avoid-reply-to-munging-mail-as-mail-was-meant-to-be/

-- 
Felipe Contreras
