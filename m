From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Why is git-subtree docs XML and not HTML?
Date: Tue, 29 Oct 2013 15:03:40 +0100
Message-ID: <CAHGBnuO1xPrAFG1tvS5zaVD9yefa2VUNYM93YLt1pQ1yJwHkrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Oct 29 15:03:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb9tb-0004KX-BZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 15:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab3J2ODn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 10:03:43 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:57646 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3J2ODm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 10:03:42 -0400
Received: by mail-lb0-f177.google.com with SMTP id u14so55942lbd.36
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=h9HdTa4pA+UcgN0QxtzNETEIR6U3Lx96h+8am72vecM=;
        b=MPMOZK8H915jV5DcrEryMiGPlZAamkeZCXJdY9g3J7tWCS7Ar5omc13D5jcdYPMH0U
         wDXBj0cP+KXMd0KlHZQhMnBprq6+ajR9Uwk+hjHj/dU6N9LS2jxPkrFcvj+f1EG8QWky
         GQrlR2BzC4l7j8LgQjLOKtPssFB0MrzFfT3mth29+P2PmgSv91DtJ27+bCt4nTsZt65P
         nug1/ve1hWwHaQC8lP2j1Gsg2sg9+G3b4MxBMYDvRttFYFcqVsO5jpdhIT8g+fXxafvx
         tRpcvQZKvJJSjykrgDCEfEJXijcPiaTBauLpouE8zdH8lxA8KzT8Px1Q6mZF0p/hf1QU
         zYfw==
X-Received: by 10.152.243.34 with SMTP id wv2mr18597188lac.2.1383055420800;
 Tue, 29 Oct 2013 07:03:40 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Tue, 29 Oct 2013 07:03:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236925>

Hi,

I'm currently looking at subtree's Makefile and wondering why the
generated markup docs is git-subtree.xml, and not git-subtree.html
like for the rest of the git commands. I have not looked at
git-subtree.xml because I'm lacking asciidoc right now, but is it just
a matter of changing the file extension from .xml to .html, or does
generating a HTML file involve more work?

-- 
Sebastian Schuberth
