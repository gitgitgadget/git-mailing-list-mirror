From: Steven Penny <svnpenn@gmail.com>
Subject: Re: Git commit path vs rebase path
Date: Wed, 9 May 2012 18:14:00 -0500
Message-ID: <CAAXzdLUoExTJyDWBJBdWNzTRRN78Bj+gEs9c107B9Nne0Pxa1A@mail.gmail.com>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
	<4FA8BBB0.1080406@viscovery.net>
	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
	<4FA8C5DB.5060002@viscovery.net>
	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>
	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>
	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>
	<7v62c5qaun.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 01:14:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSG5A-0006wW-Lm
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 01:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994Ab2EIXOE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 19:14:04 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40430 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759093Ab2EIXOC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 19:14:02 -0400
Received: by gglu4 with SMTP id u4so539479ggl.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JmQJP7o3v9QUO8VURDgHPaWlhBS7npoPnb4OTFQdp5s=;
        b=mJ+0PzFexAuqJF4ZCfBOWbt1eP+S6+9NyUvjm1+BuQHlO12U7eb8t5OgKaRk94hbtg
         0s/5rk1agq1rmZIx4DlaI1TAL1Es7yMGBW/fIg9YzXK5sx5tL4xJ1m+7GmlRfK/cfxLu
         aA3gNf9Xwfd+sXx9S3PvAShmW3o8DT3634PudLy617zp7tVnSIPa/LpfsL+2nby/0PTt
         hC31EPPRZEiZjF5wnCk/2VQs5kxXZgp7YDmjMF6HVW6XDkmMB/H9XVEXTgwMckB23igZ
         EfpvcJ8OtH3EjYKQ7Bp50UFbi9cPu5jJxVOV6Xm4KQL6yJtW8I5j8255+7ZBxd9QpAxJ
         7xtg==
Received: by 10.50.154.167 with SMTP id vp7mr1063486igb.55.1336605241025; Wed,
 09 May 2012 16:14:01 -0700 (PDT)
Received: by 10.231.80.147 with HTTP; Wed, 9 May 2012 16:14:00 -0700 (PDT)
In-Reply-To: <7v62c5qaun.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197530>

Junio C Hamano wrote:
> What does "uname -s" say on cygwin exactly? =A0Our existing system de=
tection
> code I found was in the Makefile and it looks out "uname -o" output a=
nd
> compares it with "Cygwin".

This is what I get

$ uname -s
CYGWIN_NT-6.1-WOW64

$ uname -o
Cygwin
