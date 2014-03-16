From: Thomas Robitaille <thomas.robitaille@gmail.com>
Subject: git sending messages to stderr on MacOS 10.8
Date: Sun, 16 Mar 2014 10:15:07 +0100
Message-ID: <CAGMHX_2pdQPbHEkpbtSxnFS+GRn1Uiy8CCK6CPWqhidbE4aSmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 10:15:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP7AM-0007cR-4o
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 10:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbaCPJPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 05:15:30 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:50423 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbaCPJP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 05:15:29 -0400
Received: by mail-la0-f47.google.com with SMTP id y1so2898812lam.34
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=jYbwDvF33TszaOIWCMEOHtleFlHI2hq2mKINo8hBo2w=;
        b=N9bslQ3YDXdQu+K98G9OiCrwoYjA56/oXpJqUMzIAjUImYF5RcoPb+XGpxse0QVi6V
         /itAOfCPfh8sSC2UUAzov00bY/IbimhrPR3vsnacnxCOGSvcrGO0kaXCtlV00oF9S2dr
         AC+sN2WeI+iJ847h45oygb7PgTdNEBJsdELkYU62oh/D/TjjQU1JwNI/E7FsFauARmqJ
         P5DAIhglnsQ5Y+yNwLxe+IkEPt4GstIFZwZQ4Mo1hrCyvuWQtVoEmLDak/ZThoxDKG/N
         aiyb5cUBijliU8ktcPxlx1r+tCd7KUGprsbWk8U1lKZp5ExQzub+VT6zQwi66Vh7vsh1
         c8KA==
X-Received: by 10.152.243.35 with SMTP id wv3mr30916lac.47.1394961327471; Sun,
 16 Mar 2014 02:15:27 -0700 (PDT)
Received: by 10.114.79.197 with HTTP; Sun, 16 Mar 2014 02:15:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244183>

I am using git version 1.8.4.2 installed on Mac using MacPorts. When
e.g. cloning a repository, the cloning message is being sent to
stderr, but I think it should be sent to stdout:

    In [8]: p = subprocess.Popen('git clone
git://github.com/embray/astropy'.split(), stdout=subprocess.PIPE,
stderr=subprocess.PIPE)

    In [9]: p.stdout.read()
    Out[9]: ''

    In [10]: p.stderr.read()
    Out[10]: "Cloning into 'astropy'...\n"

Is this expected behavior, or a bug?

Thanks,
Tom
