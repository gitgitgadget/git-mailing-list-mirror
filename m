From: Jeenu V <jeenuv@gmail.com>
Subject: Re: git notes and core.editor config
Date: Tue, 11 Jan 2011 18:42:20 +0530
Message-ID: <AANLkTikYxncadDj_6k+kDVz63_abhud5w8v-WgFmOA92@mail.gmail.com>
References: <AANLkTi=0BrBV+DLF_QfDi0mMVdz5tCLFsDMBKvw52nzz@mail.gmail.com>
 <201101111131.17429.johan@herland.net> <AANLkTik-=s-F8dmBRLU8o9LcSztb1P0WnkN5HK_n_No4@mail.gmail.com>
 <201101111336.19466.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 14:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pce2Z-0001kh-Cg
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 14:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab1AKNNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 08:13:25 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33318 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab1AKNNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 08:13:23 -0500
Received: by wwa36 with SMTP id 36so1742574wwa.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 05:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=2Jx19zy38Q+EaLJdsisPTMrUvfgUvHdohFi0+EzZugY=;
        b=Rcr5TR7Rr/xURwyhpHPjN31IObxbVZvTmc1BeK10aDU4a2NVgQRyxTmlwP+SOoKMOb
         d0ofM7mzObTcSVIYRf0qfDDOBKEfhWuwrI25PHvNtxQdv6W063bLS0Uu6tYa0CSuULIq
         B+LeNcNmj7xRlplf0kDhK8zc6/ZMaHGq0kqJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HkM8oMjd6is7yJk9GAtIJ1GRQunpzoO/Gc//LcYtjnERAKKGpYtDbRHGukwYCfxROZ
         2JvAa3a+r0BOl2hdKnUf6J4+f7D5qnQ1biNE1R+ZyZw21LjSJgxBfeG1/5wfrNfnWrRy
         wRgqkbPt6XMzjrh+ehV9CpvxyuqocMsE2l9tw=
Received: by 10.216.30.81 with SMTP id j59mr447833wea.39.1294751601727; Tue,
 11 Jan 2011 05:13:21 -0800 (PST)
Received: by 10.216.254.166 with HTTP; Tue, 11 Jan 2011 05:12:20 -0800 (PST)
In-Reply-To: <201101111336.19466.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164938>

On Tue, Jan 11, 2011 at 6:06 PM, Johan Herland <johan@herland.net> wrote:
>> $ git --version
>> git version 1.7.0.4
>
> Ah, there's your problem. In v1.7.1 "git notes" was builtin-ified (it
> used to be a shell script, but was reimplemented in C), so you're still
> running the shell script version of "git notes". I believe upgrading
> will solve your problem (as well as making "git notes" more
> featureful).
>

Alright, I'll try upgrading then. Thanks.

-- 
Jeenu
