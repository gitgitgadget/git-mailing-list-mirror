From: Brian Zitzow <bzitzow@gmail.com>
Subject: Re: fatal: BUG: dashless options don't support arguments
Date: Thu, 7 Oct 2010 17:06:27 -0700
Message-ID: <AANLkTikqB-EvE6uxgBmutssJoiH2RiPjSxtjbo++Jj-X@mail.gmail.com>
References: <AANLkTi=xscHHPTBtTJ3uXPO9y9gpQTBF4AWTe47C9njU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 02:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P40Tw-0001FE-1J
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 02:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab0JHAGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 20:06:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45352 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab0JHAG3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 20:06:29 -0400
Received: by wyb28 with SMTP id 28so631021wyb.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 17:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=72o8dV7lKdhF0xxNKyhPOOc42FkViG1mOkA384PMMP0=;
        b=xeQYEZU5fCNZHJ+SjTLBYdXKGi+Of+0BPRI5tfKuTiLjsKYA1r5CjtLvfiPENsbAo6
         2AnilWLtHPCPgUi2j3yaZdTD/1Ktu6z0IynYqoTxvlaALhtUNBf8UzoEXMjKsWUBCGGr
         tg4mBmbYmlrcxKDXEMQIM9/6o8CIXNwyDRvvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=oZNf1rsb1U4fcGWmzqIqJSZqbVbsckqcUFcYY+vF7VeNm9++WcWjJCMNsaBYYOnhTp
         FSn8dOa+Tsae3/jHDKf+HlU5vT8hAdIlvg6JNSaMjJoufinhcpLZ6zSFqgZabChqgERi
         IIxI8AA597OWCgk9JffCc9qmQ8tzlWNepBYWc=
Received: by 10.227.138.76 with SMTP id z12mr1631559wbt.60.1286496387747; Thu,
 07 Oct 2010 17:06:27 -0700 (PDT)
Received: by 10.227.146.137 with HTTP; Thu, 7 Oct 2010 17:06:27 -0700 (PDT)
In-Reply-To: <AANLkTi=xscHHPTBtTJ3uXPO9y9gpQTBF4AWTe47C9njU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158465>

Hello,
 I was asked to report this bug error... Environment: OS 10.4.11 PowerP=
C:

Ki:$ git branch
* branch1
=A0 master
Ki:$ git checkout master
fatal: BUG: dashless options don't support arguments
Ki:$ git --version
git version 1.7.3.GIT
