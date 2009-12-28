From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] Smart-http documentation: add example of how to execute 
	from userdir
Date: Sun, 27 Dec 2009 23:06:59 -0500
Message-ID: <905315640912272006o6a8fecddiebb66cc243593fad@mail.gmail.com>
References: <1261847255-13970-1-git-send-email-tarmigan+git@gmail.com> 
	<20091227211557.GC609@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 05:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP6uZ-0001EE-6e
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 05:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbZL1EHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 23:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbZL1EHU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 23:07:20 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62872 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZL1EHT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 23:07:19 -0500
Received: by pwj9 with SMTP id 9so6086552pwj.21
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 20:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=5frgqpVJgkz5XSa6zYY9eBz/gXcnhh/gqTRmE5JlN/o=;
        b=dvW33xhED9sxpH4rdIPmf7/SXlmh6WA/MdrAek2txkb6r2EGuL+kRDbYGMF+db9MNp
         Udk5DF3FHzgiGYfuVW1MmDf+VdujECaoNvKjdxgbRAEIvJ2Ujz8Ef8gheDS5fOrHmH/e
         4t6FR3W+vA3dZmpZEIJeeYd+1lvIzz6vafPfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=UxtCo8rh5/5e73xtDv0/NXiltZPxO4TG34TNGA17OuJ5eDJWIWeVhXx9sMUt2WZzmA
         eazz/DYArsiHONhwMjqVCzKCzGCvWmBbjR+Fsxf8VwU0ftf8Ep3oBQ772AJBPxVeYaqM
         Pzgk56dU5SRDHVmtbVqwvGaGFVlgweq/Il5Uo=
Received: by 10.143.25.29 with SMTP id c29mr10160711wfj.255.1261973239117; 
	Sun, 27 Dec 2009 20:07:19 -0800 (PST)
In-Reply-To: <20091227211557.GC609@spearce.org>
X-Google-Sender-Auth: 7399d18e73ca6b18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135722>

On Sun, Dec 27, 2009 at 4:15 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
>> Smart-http may be an attactive and easy way for people to setup git
>> hosting on shared servers whose primary web server configuration the=
y
>> do not control. =A0To facilite this, provide an example of how it ma=
y be
>> done.
> ...
>> + =A0 =A0 =A0 \~/public_html/cgi-bin/.htaccess:
>> ++
>> +----------------------------------------------------------------
>> +SetHandler cgi-script
>> +Options +SymLinksIfOwnerMatch
>> +SetEnv GIT_PROJECT_ROOT /home/$username/devel
>> +----------------------------------------------------------------
>
> At this point, isn't this just easier?
>
> =A0mkdir ~/public_html/git
> =A0vi ~/public_html/git/.htaccess
>
> =A0SetEnv GIT_PROJECT_ROOT /home/$username/devel
> =A0ScriptAlias / /usr/libexec/git-core/git-http-backend/

Yes, that would be perfect.  But ScriptAlias is only valid in the
"server config" or "virtual host" contexts which is why the
symlink/copy executable convolutions might be needed.  Can you see a
simpler way around it?

Thanks,
Tarmigan
