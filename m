From: Jason Karns <karns.17@gmail.com>
Subject: Re: bug in bash completion for git-branch --set-upstream-to on OSX
Date: Mon, 23 Mar 2015 10:42:20 -0400
Message-ID: <CAKNmmv3wpaECBbj8atA1s6hPzBvSMvfc=kkDTgbim4ufKVQuLg@mail.gmail.com>
References: <20150322120612.Horde.LAxCkP-VMKE3Ur7ZXII3Hg1@webmail.informatik.kit.edu>
	<CAKNmmv2ap+svVJQHBjNzdcNuc42Urbt6uuBVRjfUMveb98sRHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jason Karns <karns.17@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:42:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya3Yj-00010r-PY
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 15:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbbCWOmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 10:42:24 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36278 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbbCWOmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 10:42:22 -0400
Received: by wibg7 with SMTP id g7so49295248wib.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s++6UiaTRrxsxBHisYjVdcn+gqShzdJKe0ggRInJ0bo=;
        b=VGc6YLOytfMKmj0oE11hwsMDWAb/6tER7lzPCp/95bAQr+4QmJDa1VJEhx08Cc+YB0
         Q+73qnR16Q8bjraOZE4X5M5wv5+gkjgcnLVoPa7jVRepe7NZSNMlN4FIptaozTER2D4a
         yYD+j4g2C/dd9qBUIgtILTT3qakAwOuEtImyYjwR6SRzosivshUtpDGmqEusmBgBP//B
         /wQQrnWEKaIm+3N+b8BntBNcLQBIjVZVlR0Y9CWQOqxW2yLPrLqThiVm1u08od7uTcGN
         QsHfCK2w98F0enE2HiwEFKGhO+/0o+3bqtWJzTeZQIZi1j4E6+5SnnDj4jxR/f3qgs/P
         V+6A==
X-Received: by 10.194.190.10 with SMTP id gm10mr186846200wjc.91.1427121740735;
 Mon, 23 Mar 2015 07:42:20 -0700 (PDT)
Received: by 10.27.215.79 with HTTP; Mon, 23 Mar 2015 07:42:20 -0700 (PDT)
In-Reply-To: <CAKNmmv2ap+svVJQHBjNzdcNuc42Urbt6uuBVRjfUMveb98sRHQ@mail.gmail.com>
X-Google-Sender-Auth: bhcMt903pi1-bgXpZz3nf8-xnbU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266142>

For those curious, the source of the broken behavior is npm's
completion script. It is modifying COMP_WORDBREAKS. There are two open
issues against npm for this bug.

https://github.com/npm/npm/issues/4530
https://github.com/npm/npm/issues/5820

Jason
