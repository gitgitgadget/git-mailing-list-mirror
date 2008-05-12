From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problems getting git-send-email to work
Date: Mon, 12 May 2008 02:44:28 -0700 (PDT)
Message-ID: <m3lk2f5029.fsf@localhost.localdomain>
References: <402c10cd0805111901q2e934e44w45938ca4a85f240b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 11:45:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvUay-0008Sw-IH
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 11:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbYELJof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 05:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756148AbYELJoe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 05:44:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:39572 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbYELJod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 05:44:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1043756nfc.21
        for <git@vger.kernel.org>; Mon, 12 May 2008 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=QQqgkuZiq/IaasxEvNM/ZhMuctKkCwqlA+RqLh24YbM=;
        b=T9gkg4bL7Uz7Rflf7DMkPFGup68KjRa6vOqd0c9Dx3QHxOl8Udl0CJJCu1+BrkAKhmBFpyopUd9nct+ru5EtNO9j1VwLGicq3tG7vIP8mHa0NiB/+TYcfcYHOyrOqoh1B0t7Ap06EljECBn3AaZvOe+EXOaCgsjSQyYaGyU4VXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Hx+b+kDrEW+VoOWQSQi9NU3Y7IWDAhda+zTPZbP2ylr9w+Wu+US7/hdYLpGO/vkWj32EARhLEh0Ir1R0xcLv4z4s/+5ZBhnCJBTd68d+8hK8cWGuRZnqsbpMTBMjJeXStsIdQ9nW2OobuU55ILTFNnIX3P5UNKMAxsde7KeGq6A=
Received: by 10.210.38.17 with SMTP id l17mr6945479ebl.50.1210585469557;
        Mon, 12 May 2008 02:44:29 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.115])
        by mx.google.com with ESMTPS id c24sm1237939ika.4.2008.05.12.02.44.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 02:44:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4C9iPlt010899;
	Mon, 12 May 2008 11:44:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4C9iEUA010896;
	Mon, 12 May 2008 11:44:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0805111901q2e934e44w45938ca4a85f240b@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81843>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> I am having trouble getting git send-email to work:
> 
> [sj@black patches]$ git send-email --smtp-server=smtp.gmail.com
> --smtp-user=hvammen@gmail.com --smtp-ssl --to=hvammen@gmail.com
> 0001-Documentation-for-joining-more-than-two-histories.patch
> 0001-Documentation-for-joining-more-than-two-histories.patch
[...]
> Can't locate Net/SMTP/SSL.pm in @INC
[...]

> I am using Fedora 7, and have installed git from source (git version
> 1.5.5.54.gc6550, a few private patches that should not be related to
> this problem).  Can anyone help me locate the RPM that include
> Net/SMTP/SSL.pm?

Probably perl-Net-SMTP-SSL, or perl-Net-SMTP

> Without --smtp-ssl I am getting this after I have typed in my password:
> 
> Command unknown: 'AUTH' at /usr/local/bin/git-send-email line 744,
> <STDIN> line 1.

Alternate solution would be (if it is your private box) to configure
your MTA, be it sendmail, qmail, postfix or mSMTP / sSMTP.  If it is
not your provate box, chancce is that somebody configured MTA, and can
simply use git-send-mail without providing --smtp-* options.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
