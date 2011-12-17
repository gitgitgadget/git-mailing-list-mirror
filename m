From: Thiago Farina <tfransosi@gmail.com>
Subject: header file at a top
Date: Sat, 17 Dec 2011 19:57:42 -0200
Message-ID: <CACnwZYdSPPhLyu6Oi3k2aNzYqvmD=xDYWvCEd2ofyJSntqKdJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 22:57:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc2GL-0004fN-11
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 22:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab1LQV5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 16:57:44 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45118 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab1LQV5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 16:57:43 -0500
Received: by yhr47 with SMTP id 47so3524077yhr.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 13:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=r6KfxeEM3n8qvmn3ZlCSVJOwQK9NzlkX+8D8QJepGpc=;
        b=RxufWdqaJnKL0bfEoWIwY3rgnqPA8URw3idOKVUoK3e6ZoGcDlFqZmftlBYwBGB/p6
         0lkz8HjMYtaJjLZEKIwPT4V0d8T5aGHTeE3DsY2ee5zB8lIjwzt4BIUAyv9a5aYIacaP
         Aede1CyR4Qwx4kO7lXIpuBIm1h+la8PXZuJMA=
Received: by 10.236.110.110 with SMTP id t74mr20386130yhg.91.1324159062540;
 Sat, 17 Dec 2011 13:57:42 -0800 (PST)
Received: by 10.147.116.6 with HTTP; Sat, 17 Dec 2011 13:57:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187406>

Hi folks,

I don't understand why in git the .h file is not included as the first
substantive line of the .c file.

i.e:

foo.c
--------------------------------------------------------------------
#include "foo.h"

/* in alphabetical order */
#include "bar.h"
#include "tiz.h"

Any particular reason we include the corresponding header file at some
random position in the source file?
