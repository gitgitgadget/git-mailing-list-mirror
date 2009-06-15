From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 1/3] git-sh-setup: introduce say() for quiet options
Date: Sun, 14 Jun 2009 23:33:46 -0700
Message-ID: <780e0a6b0906142333q72d2cdefh9db60ffdb0babc25@mail.gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com> 
	<1245021374-8430-1-git-send-email-bebarino@gmail.com> <1245021374-8430-2-git-send-email-bebarino@gmail.com> 
	<4A35E970.8080406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 08:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG5ln-0006Fs-Vy
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 08:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbZFOGeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 02:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbZFOGeF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 02:34:05 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:9043 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZFOGeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 02:34:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so8353071and.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tThuNoTFC1vIxWZOKTMgjUARVgPWbF40fn8XaEEf1PY=;
        b=RYz3ABvYKcYeeMx+pymuuklR3uUIZVwUopIuUa7CEs5oSD7EXdZDLQwFJz/U9WzEiG
         3cGKoXwgExl2wkKzy0sYkV1RTpPC0aN74CnHCt7KcqxP8XzqjbFfj4x4nxeJoGnjW4JO
         uqg9g6fPBn6zDNOm9wsxyf1VYr6EpbJPN82yE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eosVtN4GUa8A8Vm/T8Ncc6zD06Jl3Mv5yr9DO63KbBmVbkOUgSAZ49huzTxS8PqzgT
         ZVa35CLzt4+TMYOPSb7tpcuz7f5r6LrtdWHFnqicFPMl5vqwiro6LL6T0uGYZoJZY7UL
         yjh2r5eOt2oXfr6HCkyjBLdkpwGKhHH8a63rc=
Received: by 10.100.153.12 with SMTP id a12mr8275845ane.191.1245047646127; 
	Sun, 14 Jun 2009 23:34:06 -0700 (PDT)
In-Reply-To: <4A35E970.8080406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121587>

On Sun, Jun 14, 2009 at 11:25 PM, Johannes Sixt<j.sixt@viscovery.net> wrote:
>
> Is it intended that this obeys any GIT_QUIET that appears in the
> environment?

I wasn't sure, therefore I left it up to interpretation. It's probably
better to just override the environment though.

Thanks.
