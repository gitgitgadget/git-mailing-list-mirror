From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [msysgit] how to detect git.exe directory?
Date: Sun, 23 Dec 2007 17:25:34 +0100
Message-ID: <e5bfff550712230825o5e73bd3dm31057847106b8722@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: msysgit@googlegroups.com, "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 23 17:26:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6TeN-00063f-2L
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 17:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbXLWQZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 11:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbXLWQZf
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 11:25:35 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:63926 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbXLWQZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 11:25:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1144094rvb.1
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=tfmXEsn8TxbuYZjPols7KZaFeyB0RzBAwUtYVjBoJsM=;
        b=gezeCDNPbnGLUNJoGcIhNILo0D5UI+m2IEAEv28wciD4dDKz9LX4mQJHSAIMl1hnHmdUqlq5ao3JiGu9OAj6qqTECsDzBaebyX+fs3s6tPHsogVr0Oh/HUS+LiHBaHeML+vK3cfjRgR5CGs+0NZd/+Bo6+3GafiG8Gum6YPsY10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rxH/IuG6+EW7ay32BpFxVk+bjTaYt/K+hrWz8CilIzGq2gkozAraCctvj2rTUMkY3eEEEIcWtR5tK6P06vr61qYQdw8ke1TVf5Bca2OyFr9Jg283z2ZW6J1g6HcZ+cF+zDEoZqbinyIlmhp0PulFnHjnVjESHMzmt54+JP6VL3M=
Received: by 10.140.249.20 with SMTP id w20mr1872908rvh.225.1198427134304;
        Sun, 23 Dec 2007 08:25:34 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 23 Dec 2007 08:25:34 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69183>

Hi all,

   I'm progressing on qgit installer for windows, I have switched to
MSVC for compiling Qt4 and qgit sources and I have to say that first
results are very good, qgit.exe now seems to work without problems or
artifacts and the speed is much more similar to what we achieve under
the Linux platform (read much higher).

So it seems Qt+mingw is not the _best_ possible solution.

Anyhow, under Vista you cannot simply copy qgit.exe in the git
directory (OS barfs regarding some administrative rights, note that *I
am* the administartor!), so to make qgit.exe work git.exe file must be
in PATH.

To easy the user and allowing to call qgit.exe double clicking on a
nice desktop icon I need a way to know where git.exe is installed *at
runtime*.

So my question is: "What is the preferred way to detect git directory
at runtime for msysgit files?"

- environment variable ??

- windows registry ??

- others ?


I don't plan to use the cygwin version of git but going directly to
the "long term" solution that is msysgit.

Thanks for your help
Marco
