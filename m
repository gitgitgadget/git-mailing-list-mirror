From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-2.1 and qgit-1.5.8
Date: Mon, 31 Dec 2007 12:58:27 +0100
Message-ID: <e5bfff550712310358g347d883fm9866f328f24e3ad0@mail.gmail.com>
References: <e5bfff550712302335ie96e143g55c93e984fba6aaa@mail.gmail.com>
	 <4778CB78.2010906@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Filippo Zangheri" <filippo.zangheri@yahoo.it>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759081AbXLaL6l@vger.kernel.org Mon Dec 31 12:59:14 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759081AbXLaL6l@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9JIU-0004VR-DK
	for glk-linux-kernel-3@gmane.org; Mon, 31 Dec 2007 12:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759081AbXLaL6l (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 31 Dec 2007 06:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbXLaL6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Dec 2007 06:58:30 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:1789 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382AbXLaL62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Dec 2007 06:58:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4527408rvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2007 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=S7CQd6YB25FYyeZmhGSHV5AW6n7SyxVZ+7pER+0hpP8=;
        b=kHVPkvuHsaRBsgsDf7wStzV1eFTQEamFLrnLzpVoDbgIZxwp9NWbA1QYJWtX/5+ljk0rPaN79F4NSNNLb2EZ3OxxgDDolFN0Mjhi9Mk8A7mfw8wxfG0wAi7jf6J8X+luRRGl0gOXUZ2AEFZeqV3BkgOQCMLQdlHiCruuoAJ0zhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NoHqy7R15V9PwJ+c/oAIiCm8r2lqC6BiE4/8zk7jBYBMYPr2oondFxqxiqPer2lOxubNEmwUbt3C+OiGRmItv9B3FPMn/txjRZ/20vGUgD9Z3me6aF/ybsDnyzMrSZTJf0LhpULDJBg6GDWpcgVCGCOh9EuJT2OL7UHRZDQCzsM=
Received: by 10.141.115.6 with SMTP id s6mr6289726rvm.4.1199102307970;
        Mon, 31 Dec 2007 03:58:27 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 31 Dec 2007 03:58:27 -0800 (PST)
In-Reply-To: <4778CB78.2010906@yahoo.it>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69402>

On Dec 31, 2007 11:59 AM, Filippo Zangheri <filippo.zangheri@yahoo.it> wrote:
>
> Hi,
>
> I git-cloned qgit-2.1 from your repository, then ran `qmake qgit.pro`, but `make` gave me errors.

Yes, you need qmake of Qt4 not the Qt3 one.

> Afterwards I deleted src/Makefile, ran `qmake-qt4 qgit.pro` and `make` starts compiling some files but the process ends with other errors.
> This is the command line:
>
> filippo@master:/usr/src/git/qgit$ make
> cd src && make -f Makefile
> make[1]: Entering directory `/usr/src/git/qgit/src'
> make -f Makefile.Release
> make[2]: Entering directory `/usr/src/git/qgit/src'
> g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -Wno-long-long -pedantic -Wconversion -Wall -W -D_REENTRANT  -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -I../../../../share/qt4/mkspecs/linux-g++ -I. -I../../../../include/qt4/QtCore -I../../../../include/qt4/QtCore -I../../../../include/qt4/QtGui -I../../../../include/qt4/QtGui -I../../../../include/qt4 -I../src -I../build -I../build -o ../build/customactionimpl.o customactionimpl.cpp
> make[2]: Leaving directory `/usr/src/git/qgit/src'
> make[1]: Leaving directory `/usr/src/git/qgit/src'
> ../build/ui_customaction.h: In member function 'void Ui_CustomActionBase::setupUi(QWidget*)':
> ../build/ui_customaction.h:68: error: 'class QHBoxLayout' has no member named 'setLeftMargin'
> ../build/ui_customaction.h:69: error: 'class QHBoxLayout' has no member named 'setTopMargin'

This is because you need at least Qt 4.3 as written in the README.

>
>
>
> I'm running Debian Etch 4.0 with vanilla kernel version 2.6.23.1 and I have the following packages installed:
>
> filippo@master:/usr/src/git/qgit$ dpkg -l | grep qt4
> ii libqt4-core                  4.2.1-2+etch1   Qt 4 core non-GUI functionality runtime library
> ii libqt4-dev                   4.2.1-2+etch1   Qt 4 development files
> ii libqt4-gui                   4.2.1-2+etch1   Qt 4 core GUI functionality runtime library
> ii libqt4-qt3support    4.2.1-2+etch1   Qt 3 compatibility library for Qt 4
> ii libqt4-sql                   4.2.1-2+etch1   Qt 4 SQL database module
> ii qt4-dev-tools                4.2.1-2+etch1   Qt 4 development tools
>
>
> what am I doing wrong?
>

Please upgrade to Qt 4.3 and everything will be OK ;-)


Happy new year
Marco
