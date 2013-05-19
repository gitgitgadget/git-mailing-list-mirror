From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 20:43:27 +0530
Message-ID: <CALkWK0kz-pQ9UJPXerFoui9ftNXDzD-xhpkSHY=JX3rbFXgp-g@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
 <1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com> <CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 17:14:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue5JO-0003Pk-6u
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 17:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab3ESPOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 11:14:09 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:52545 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3ESPOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 11:14:08 -0400
Received: by mail-ia0-f182.google.com with SMTP id z3so6674534iad.41
        for <git@vger.kernel.org>; Sun, 19 May 2013 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/MQGSMvNqi+sbHIf8huWlk0NgPNt/fk0x6PzZ9ieIAs=;
        b=QvckMj14xhuSjyDNuQdyPvyso+Snap44Vqk2opeBpzkDyc/zsc5RwlaCV4svvaLo9f
         daZbjTfKL1oPpNG2aMvzYgiNIgJKq9ckB2ho8fkZMjRV1BHR77sMtX8+MwTLn+BYXC/q
         onVueRKtCapt2HMPZrolgfU+QpMujNulZ1xXfmNukuUzHRofYKQaYQPaA0I3pEFZcO3z
         ADXMx1zXHetJ8/0+iRiSTdsijD4m+hceHW2xrOv7/QSAf7PfH96YO9T4IZdk4Rzm0Hbh
         xHeY+aMJY97fCrNuf1+OjrfVGQspooZZ2ladrzfWC8dSYFzwDbuGEUuRBdDkRRZh2fI/
         w1cw==
X-Received: by 10.50.66.140 with SMTP id f12mr3067881igt.63.1368976447872;
 Sun, 19 May 2013 08:14:07 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 08:13:27 -0700 (PDT)
In-Reply-To: <CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224890>

Felipe Contreras wrote:
> How exactly is it not equivalent to len = len || 1?

Here, I dug up an article for you on the issue:

http://www.rubyinside.com/what-rubys-double-pipe-or-equals-really-does-5488.html

Although it's fine in this case, I wouldn't recommend using ||=
because of the potential confusion.
