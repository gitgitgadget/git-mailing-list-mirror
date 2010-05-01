From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: Integration-Manager Workflow and merges
Date: Sat, 1 May 2010 05:44:09 +0100
Message-ID: <p2u86ecb3c71004302144w942be5f6p9ce8f431653338f7@mail.gmail.com>
References: <4BDB6FA1.4070802@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sebastian Andres Mancilla Matta <smancill@alumnos.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat May 01 06:45:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O84Zv-0007nF-1N
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 06:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829Ab0EAEoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 00:44:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55755 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0EAEo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 00:44:29 -0400
Received: by pvg7 with SMTP id 7so509688pvg.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 21:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=BV7mJ0jACK6QpTUba2KmD70t67UWzbuaJPeoNy5DFms=;
        b=RtljBeGJKenXw1gm07/ErLYvN5rwiheuJyeRL9fRUYprKTBR7oFp2xqO7agYjbXGjM
         QpktS/j9ekjTiRxoPsrpoxywD02XmtuAI6aL04CCO0tIHIOZmlBs3cWD1XSB2YEZoQYs
         tVmZKiKuqXgEALhLuXmKeyo2SdDvcfG6vCBc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=MuDpqygFVQQfXqmnEcSkiFq7FYxbLnUHxeTUfNSlSQ4v3C2SPHND1X+o0yMkre0myM
         Rh/7903wGyj59TmCgsuNMmcP1J55UL8DFbUaDhPcgrLzw6JmlaHYwOKDhAJ3OAy1Noa8
         fBn4CcPJjJrxIT67NH3UoqI+Nn1c7BqppY/Yo=
Received: by 10.142.67.2 with SMTP id p2mr1474987wfa.288.1272689069117; Fri, 
	30 Apr 2010 21:44:29 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Fri, 30 Apr 2010 21:44:09 -0700 (PDT)
In-Reply-To: <4BDB6FA1.4070802@alumnos.inf.utfsm.cl>
X-Google-Sender-Auth: 75d0dd256f487974
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146077>

On 1 May 2010 01:02, Sebastian Andres Mancilla Matta
<smancill@alumnos.inf.utfsm.cl> wrote:
>
> This way, there is no duplicated merges. Is this a good workflow? Can
> anyone using a similar approach give me some comments?
>
> Thanks.
>

Don't worry about duplicate merges. Allow everyone to pull from each other =)

The "duplicate" merge will not make you to resolve the same conflicts
again if you are worried about that.
