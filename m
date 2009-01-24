From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: read-only working copies using links
Date: Sat, 24 Jan 2009 19:43:20 +0100
Message-ID: <bd6139dc0901241043h7087316bgcbcb5d9085d603ef@mail.gmail.com>
References: <3EE64C92-CB4C-47BD-9C48-E369AED4B82F@gmail.com>
	 <bd6139dc0901240302q6b3c9a13p56fe39a976882133@mail.gmail.com>
	 <AE9781AD-0B63-4AEE-9B62-20F9720B5DC4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tim 'Mithro' Ansell" <tansell@google.com>, git@vger.kernel.org
To: Chad Dombrova <chadrik@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 19:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQnVB-00041j-JO
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759204AbZAXSnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 13:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757477AbZAXSnY
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:43:24 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:21780 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759119AbZAXSnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 13:43:23 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2358346ywe.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 10:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=C6kul0yd4c2yaDrXJ2j5OGyET84/IBA22QfCtZTMItY=;
        b=tWRE+ZnC/xWiv6KkHMoQTszP8VltlCrUzXrmButtL+a/iBwuIvQEYJZVOXhoczDdh3
         Cc6qa+2AL/wsM4LgxTAgJzi2u3yBDlisH/TQ0zxE6KzBoCnz0/fOn7z9q1qtEBbui8PD
         Wk3yy+CvAowVJuxRaTs1BDmpDUL8WWpwtzjkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ZETaX23bKcVkRz8fuYyFdfJkm6OPIqMn0a1eqq87FEyD+JFdcJLTdObwGLFnk977Nv
         JzwpnxL3EIwV5FdGNkVYTpLupbCpn3FH8k2W48imy2PmrwQuBqscjXZB9hli/Z38lDsh
         +hEvYnllO80O0aKw/4hfCZKsZkk3xD6fllBxU=
Received: by 10.150.122.18 with SMTP id u18mr1775647ybc.164.1232822600859; 
	Sat, 24 Jan 2009 10:43:20 -0800 (PST)
In-Reply-To: <AE9781AD-0B63-4AEE-9B62-20F9720B5DC4@gmail.com>
X-Google-Sender-Auth: 92f3f37f1c95bc45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106987>

On Sat, Jan 24, 2009 at 19:39, Chad Dombrova <chadrik@gmail.com> wrote:
> what's the case against it, other than the obvious, that it will take more
> work?

Good question, I think it was mostly that, someone has to implement it
(possibly as part of packv4). Backwards compatibility is of course
always an concern, but I'm not too familiar with the subject, perhaps
other people on the list (or even those were at the gittogether) can
comment?

-- 
Cheers,

Sverre Rabbelier
