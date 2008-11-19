From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How to make public repository GIT_DIR=my-git.git git-init Command not found.
Date: Wed, 19 Nov 2008 14:38:12 +0100
Message-ID: <81b0412b0811190538t4c16b9dagc14ff84bf6689616@mail.gmail.com>
References: <138223.4849.qm@web37905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Wed Nov 19 14:39:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2nHF-0000Uk-4g
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYKSNiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYKSNiO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:38:14 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:59800 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYKSNiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:38:13 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3407863rvb.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 05:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Jr9rAIybr/gVPnyxlyud1eVtw42rDaliSVuDYNf7qR0=;
        b=cUL4JZUNiaVjWQXPGpcYKelmO7rLzf/1gKQSxC1F88gIuPdEX2kkRxsK2BkMGHG6nI
         a2OF1lD2ZoI1574zoXMesCX85VB1pQ6bHZ2YAIaavNC8h4No969b41ZVHkE99R1ijR65
         NRaINwxEHqXOg5YgF7XJFfAy/jUEfgQpGFCPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=luKluQpqbWqnANJUtpWAK9TnuDiDQyUw+djSM9qZ+pd5C5mb/AhWo85XYOj1TD2UzP
         jnH40J5gjVc696gr9+Q8+POtHeqTWPFVclF1aYZJSu/Eg2d63GTZAePGNfhw/355E/vf
         YLEPZR+H7XSnpe+x7K4iGQvGutBjlojd8Jv3I=
Received: by 10.114.36.4 with SMTP id j4mr663760waj.119.1227101893293;
        Wed, 19 Nov 2008 05:38:13 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 19 Nov 2008 05:38:12 -0800 (PST)
In-Reply-To: <138223.4849.qm@web37905.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101344>

2008/11/19 Gary Yang <garyyang6@yahoo.com>:
> Hi,
>
> I want to make a public repository. I followed the instructions in gitcore-tutorial.
> I typed "GIT_DIR=my-git.git git init" per instruction. But, I got command not found.
> I do not think this is the correct command. How should I do? I use C-Shell.

git --bare init
