From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Tue, 22 Jun 2010 07:14:33 +0200
Message-ID: <AANLkTinab6BkUqZnUE3yxmgY_lKyp0TbYUPYbKkoUKMA@mail.gmail.com>
References: <AANLkTikcnv2dzY25dSgvKoTfLJ416gcaeDZA5HGa_tue@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 07:14:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQvon-0007fr-7C
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 07:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab0FVFOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 01:14:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56247 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0FVFOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 01:14:35 -0400
Received: by vws9 with SMTP id 9so469705vws.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 22:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=axUcN2L1nVG9M2lJI59d3Q4JBujVx9IaVuK+MR5upCY=;
        b=uIspGbF5knqkv0OGssz1LtsTUTd8xmX4o+6LUHbj7gb0ErKqi5Zl+id+RGdQqYhiQi
         mV3r+lfqE/jcVe6oL6+CILLWdD4PyzeMZb/0pheL1SpUJ9oDYeTuBTjRdN2nWpj4gQ05
         vADA8zWBHyW1DMtYQqXyf0tMuQ9YDuqwb8LAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LdJ/ZykD5nKuQED6l6JgFFha6ip/tMzUSuocoLcjNh4VOgW5dDQE8DT6+d+sc9hpWQ
         1ESw3WTIGXClfO8BFeiGHaWBbM/Dg3Q55a0uYe9AOpdqvUxJe3nf3HH3BB2DYCgs+ycM
         2JmSsWxQ4koeBeN3JEANIsdgYA2dHXdkqKz/M=
Received: by 10.224.18.36 with SMTP id u36mr3909752qaa.64.1277183673954; Mon, 
	21 Jun 2010 22:14:33 -0700 (PDT)
Received: by 10.229.231.142 with HTTP; Mon, 21 Jun 2010 22:14:33 -0700 (PDT)
In-Reply-To: <AANLkTikcnv2dzY25dSgvKoTfLJ416gcaeDZA5HGa_tue@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149465>

On Mon, Jun 21, 2010 at 23:34, Eugene Sajine <euguess@gmail.com> wrote:
> Could you, please, advise how can i switch on some logging in CGIT so
> it will trace all activity and tell me if there are some errors?

There's no builtin logging, but running cgit.cgi under gdb (or even
strace) should do the trick.

--
larsh
