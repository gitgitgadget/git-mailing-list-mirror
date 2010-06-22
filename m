From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git push controls / config
Date: Tue, 22 Jun 2010 10:53:22 +0000
Message-ID: <AANLkTikIkyZQyvaZTUE-JzUOqKioVf_ubqBONQazP9Uf@mail.gmail.com>
References: <AANLkTin8O01vNL8JlPcNqB7FdvMssjOce_YFF82iW6GC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 12:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR16f-00047h-7F
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 12:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376Ab0FVKxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jun 2010 06:53:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48844 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292Ab0FVKxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jun 2010 06:53:23 -0400
Received: by iwn38 with SMTP id 38so775908iwn.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KCOiu85f8mzFma/rvPwA16l5AW+6VjjjYjLg+wwkiM4=;
        b=RSmMbDGa+wjYJ61N3OHvwenPSDbwMkOm9Ghtoar7CxJpo1z7B1OnWTmsYMg8Q3V7c9
         z234GpoRXtHdsSBU0LmSn+/TRPmJSF31wy1JnsY7TwW75cbXWpFe7b7d4Ccu7Wrux0Zv
         Vtj4Sz+1uRst2OzD+YjNfv5nan7MQv1VwEWmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JMpCA1uLX+j2i42ZxZupuSzAmZGz5SALDc1Old8EKojq0vcAnTpqW8GZ8xx2gDqKTB
         k1BDGB8Dffdpsp9Dy/RB09Amkksz02GLUtyelWLrzCAbEDvcEVtnHtgALYVS0zYVeWBg
         Jvjct/BUz30DQm9J8uG0kKkUacaq5PlGN8ssg=
Received: by 10.231.148.200 with SMTP id q8mr6830866ibv.10.1277204002950; Tue, 
	22 Jun 2010 03:53:22 -0700 (PDT)
Received: by 10.231.158.195 with HTTP; Tue, 22 Jun 2010 03:53:22 -0700 (PDT)
In-Reply-To: <AANLkTin8O01vNL8JlPcNqB7FdvMssjOce_YFF82iW6GC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149471>

On Tue, Jun 22, 2010 at 10:50, Mahesh Vaidya <forvaidya@gmail.com> wrot=
e:
> How can I prevent (via a config file) someone from pushing a
>
> 1) same commit with --amend;
> =C2=A0 =C2=A0 =C2=A0- we rely on commit log; bug number. If some one =
changes bug
> number via amend; that risks the integrity.
>
> 2) creating and removing Tags and Branches
> =C2=A0 =C2=A0- same - Tags are of special importance to us.

Check out some of the on-commit filters, e.g. gitosis that do this.
