From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] A simple python script to parse the results from the testcases
Date: Mon, 12 May 2008 03:14:42 -0700 (PDT)
Message-ID: <m3hcd34ynv.fsf@localhost.localdomain>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
	<1210584832-16402-3-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, dsymonds@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 12:15:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvV4C-00005m-VF
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 12:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757653AbYELKOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 06:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758275AbYELKOq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 06:14:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:61485 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757642AbYELKOp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 06:14:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1046011nfc.21
        for <git@vger.kernel.org>; Mon, 12 May 2008 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=aUp1JnRoVVaophaQv5N/2MkSEii5cqREKp8FD9MKCmo=;
        b=sub0g4XyckjUNFnH+/8OlAKFuytAYVjDA0ChTyi85Qsufr5DG57/2DF06bINZOBWsctN+fJtJNhncYW9wWpz87S1WjyJeZQDYV9bNs8pgDtIkTb+ogg+rpCjLujv4Z8dho+hk0a/xR04tJf7Y39T1tA030vKcmHd9jriMUxHXto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=d5DknJhvTAKL0VBN0z7WZBmXaWZy3nzDG8VJ9hTnIe8ifXCQWBV7Dq+dWQWpauK2vxdx3uC9DejjI7iLs8u2+rkZEhi0R9MkDFkqmtxLjEvJoJBQTSc9G1/ZhnStaauTM8hZWKbFXIeqTElHqnUrjQtI80FcrQzdOVVaVy736is=
Received: by 10.210.89.4 with SMTP id m4mr6978338ebb.68.1210587283513;
        Mon, 12 May 2008 03:14:43 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.115])
        by mx.google.com with ESMTPS id y34sm4142360iky.10.2008.05.12.03.14.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 03:14:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4CAEcoM011100;
	Mon, 12 May 2008 12:14:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4CAESfu011097;
	Mon, 12 May 2008 12:14:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81848>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> This is a simple script that aggregates key:value pairs in a file.
> I am sure this can be done better with a 'grep | sed | awk' combination,
> my skills with awk / your program of choice is not as profound.

Or Perl, as Perl was created for that.  I'd rather don't reintroduce
Python dependency...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
