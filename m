From: Thibault Kruse <tibokruse@googlemail.com>
Subject: git clone tag shallow
Date: Sun, 17 Feb 2013 20:13:30 +0100
Message-ID: <CAByu6UWEF48XvTmRnVDb2Bqxy1dNdUSXpTuy804215Vgs_KJxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 20:13:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U79gS-0006Gg-46
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 20:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab3BQTNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 14:13:32 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50592 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3BQTNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 14:13:32 -0500
Received: by mail-oa0-f46.google.com with SMTP id k1so5264147oag.33
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 11:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=7wJdgE5TLvPoepD1h/nc8H1yANis2TSsC50YWGGS74g=;
        b=xzrrJfRDrHMIj/L4rMVrAHcPjDeZOXZU6oV0hFUkQMircA0CHFMAmKY/THog2Y/LEJ
         wVuOTTkYxLqXXQy4hQlteFUT/T+MlwpoJY9K1GUEFIm7gr4Ee80r8XSHR10KtpY8JcG1
         wZ+ga7sCyx7VAyFRb43PLZ2zVJfKShG6XEwzYsXO3vFI1TlaXLwEniF3OmD2IyMMKYaf
         G+n2xZkpD23AjZrtzveb0xI6lzQAf+4dBXTsj+HjL09ZYx6FUv6jbZm8jGJAqX46X+tk
         CeO5C/B/9qyQHmhDDOFJSfYypnL+Ewm/irzf/IMLl9ev6f7estwlqV1lASfWQp6/yTEL
         iX4w==
X-Received: by 10.60.5.165 with SMTP id t5mr5131181oet.117.1361128410365; Sun,
 17 Feb 2013 11:13:30 -0800 (PST)
Received: by 10.182.251.165 with HTTP; Sun, 17 Feb 2013 11:13:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216403>

Hi all,

I notice that using git 1.8.3, I can call
git clone repo1 repo2 --branch tagname
with a tag, not a branch. Is this going to be a stable and documented feature?

cheers,
  Thibault
