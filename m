From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] rebase-i: do not get fooled by a log message
 ending with backslash
Date: Tue, 6 Jul 2010 13:57:06 -0500
Message-ID: <20100706185706.GA7296@burratino>
References: <1278397631-20658-1-git-send-email-gitster@pobox.com>
 <1278397631-20658-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 20:57:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDLC-0006mM-MR
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab0GFS5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 14:57:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:38528 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab0GFS5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:57:49 -0400
Received: by pxi14 with SMTP id 14so2304981pxi.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VyN/fsNCB9NjLTGkFuzUXVk/bQv3O/habA3acF2wz5s=;
        b=OGQaES+sUaasDj8KCTUAB0hSjnmkZSLF7luK2+oNKc85XZ4OuNr1zkmYFoQ9YP/dE+
         +F4ZmGQRGQMulPNnMtKkwKq7ZvpeAT7+y6oSO1izmScUTGGhPJOQCiqRBl6I084sh8y3
         +yTHUnYc9367TwGh9N/s3dwDN10mJk9CJqm2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YFWkHnPLUg8VoWR+xaUp3TRhkWTtpen5I45VWsazf7s4duoiCvyL6XqrEl/oDgkNEo
         q9JGwDafvjAVyq8i7hq9lYHx5Fi1S3uawxapk3yEiG8qD2aInkC4MzZnDK07rjbrrc2/
         1vR5IBphH7eJFBn4LM/p3edYbe5GhQl1ObJGU=
Received: by 10.142.223.12 with SMTP id v12mr6404243wfg.86.1278442668204;
        Tue, 06 Jul 2010 11:57:48 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm24676447ibk.9.2010.07.06.11.57.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 11:57:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278397631-20658-3-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150395>

Junio C Hamano wrote:

> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Posix mandates the -r option to replace the less convenient =E2=80=98li=
ne=E2=80=99
utility.  read -r is part of SVR4.2[1] so any vaguely Posix-ish sh
should have it (i.e., not Solaris /bin/sh, but that=E2=80=99s okay).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

(Not tested, since I don=E2=80=99t have access to any non-Linux install=
ations
nowadays.)

[1] http://www.in-ulm.de/~mascheck/bourne/
