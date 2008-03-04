From: =?UTF-8?B?R2FicmllbCBTYWxkYcOxYQ==?= <gsaldana@gmail.com>
Subject: msgmft segfaulting on ubuntu gutsy (clean)
Date: Tue, 04 Mar 2008 01:02:36 -0600
Message-ID: <47CCF40C.2070203@gmail.com>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com> <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com> <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site> <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site> <7vablmqc7q.fsf@gitster.siamese.dyndns.org> <20080228003212.GP8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:03:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWRBI-0002P9-P9
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 08:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbYCDHCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 02:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbYCDHCn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 02:02:43 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:45784 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbYCDHCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 02:02:42 -0500
Received: by wx-out-0506.google.com with SMTP id h31so748768wxd.4
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 23:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=CBzXJe+qH/faxGej9jMr0rQKCcWfVXPu1gKeUscDaqo=;
        b=aFYwqxwiK7v862L72XAm1knnTVu6rnI1geV1l0BaJwLbDPSsyhIVpkYNBx1Yf3rA0P1Hw3ncnbcHEN+Oy6COFBYr0zweXVcDHEbDHco+LjEB1JVYd9LPqYnuOrxZ4rpXwBNC2AYJGMELXGLKhnazVu1dCdvepB7cCEET3R5Bzfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=nyHUHIgnxVHktjMTCERtnpIQz6GtXXuZtHd5pmIEMJPs4QIi9Hhz6kVnqHhZrQwAyui9UNpG/XNc8SgQ44VDebgMN1i5n1S4Xz0KZowE9L6Ci5NaTLpJvvTxunXfkqg0EZiIk3CfuIfYWeBzfkarvV06SyiJDC66QYYOLgr/wbY=
Received: by 10.100.41.16 with SMTP id o16mr949196ano.24.1204614161496;
        Mon, 03 Mar 2008 23:02:41 -0800 (PST)
Received: from ?192.168.1.105? ( [148.243.247.108])
        by mx.google.com with ESMTPS id s30sm2367313elf.17.2008.03.03.23.02.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Mar 2008 23:02:39 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <20080228003212.GP8410@spearce.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76037>

I'm getting the msgmft error message when compiling git 1.5.4.3 on a 
clean install of Ubuntu Gutsy. Installed dependencies using "apt-get 
build-dep git-core".

Here's make output:

GITGUI_VERSION = 0.9.2.7.g3bae
     * new locations or Tcl/Tk interpreter
     GEN git-gui
     INDEX lib/
     MSGFMT    po/de.msg 371 translated.
     MSGFMT    po/fr.msg 371 translated.
     MSGFMT    po/hu.msg 371 translated.
     MSGFMT    po/it.msg 370 translated, 1 untranslated.
     MSGFMT    po/ja.msg 371 translated.
     MSGFMT    po/ru.msg 367 translated, 4 untranslated.
     MSGFMT    po/sv.msg 371 translated.
     MSGFMT po/zh_cn.msg 53 translated, 57 fuzzy, 253 untranslated.
     SUBDIR gitk-git
     GEN gitk-wish
Generating catalog po/de.msg
msgfmt --statistics --tcl po/de.po -l de -d po/
make[1]: msgfmt: Command not found
make[1]: *** [po/de.msg] Error 127
make: *** [all] Error 2

It is very similar to Tiger's error message.

Gabriel Saldana
