From: solsTiCe d'Hiver <solstice.dhiver@gmail.com>
Subject: [bash-completion] syntax error near unexpected token '<' on line
 123 in bash_completion.d/git
Date: Sun, 25 Jul 2010 13:12:00 +0200
Message-ID: <1280056320.7883.9.camel@soho.example.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 13:12:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocz84-00036f-RF
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 13:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab0GYLMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 07:12:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52106 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab0GYLMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 07:12:05 -0400
Received: by wwj40 with SMTP id 40so6005594wwj.1
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=nvWEjE3rsVbK17RgrE2+UriI8bRyHaBQH6igde4cBmg=;
        b=E/RWzB4Uo82U+bp66MqvkzIDhpATd60xc/l2JH1lokaB5mmEMInoFXKS7ujPhFURpj
         m2I5iM7oQBsEkwyJea2MQ+f25VQOK1D5iBmMdUtY0awDMNccJI6GLCXtRvSsjQYRpT5U
         RsHh5rJ52thVhMeoocWAA1+h8+QenxhOI89/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=T/OS1C8h8whg8riB6xjD1rfzdGaama8bBGvVGdKMrRLyJze4eehoppG4b9KFZttfU3
         iAecjBEzVw4RUkEhUnLXljwDGYkwHNeTYrikmNm1Yqqg9pI/8W3xyh3M+2m+Hk46RZxO
         Er4nHgEVjItePLcYexpogJO4E3K4wIUV9EPCQ=
Received: by 10.227.147.82 with SMTP id k18mr5890743wbv.64.1280056322279;
        Sun, 25 Jul 2010 04:12:02 -0700 (PDT)
Received: from [192.168.0.50] (ARennes-553-1-38-213.w86-214.abo.wanadoo.fr [86.214.125.213])
        by mx.google.com with ESMTPS id a20sm337302wba.6.2010.07.25.04.12.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 04:12:01 -0700 (PDT)
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151723>

hello,
I want to report a tiny "bug" (?) and I couldn't find a bug tracker so
here I am

When I boot my pc, I got an error on my console before gdm kick in to
launch gnome.

This is an error in /etc/bash_completion.d/git; it says
syntax error near unexpected token '<' on line 123

I use git 1.7.2 and bash 4.1.007 and the line 123
of /etc/bash_completion.d/git looks like this

	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash
\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')

I think that may be there is too much < there.

but strangely if I source manually that file in a bash it works without
error.

originally reported there: http://bugs.archlinux.org/task/20264

P.S.: I have not subscribed to the ML.
