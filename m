From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: qgit4 segfault
Date: Fri, 16 Feb 2007 00:38:32 +0530
Message-ID: <cc723f590702151108u1bb8e9e8se72e9f216a23d2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 20:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHlyX-0005lR-I2
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 20:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030680AbXBOTIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 14:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbXBOTIf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 14:08:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:60085 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030680AbXBOTIe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 14:08:34 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1245809nfa
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 11:08:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=msiI3TFZ/l2r9pWxN/YbLy4CXreRObl5tnBp6FyAxBpaBtYVFyBztUagMp4HDYK3w2HzW1uW2ijuV9PB5hWxpMxYwocaeu/bPoghz38taytKK7b4H9DWu/mxY8Fbf42RZCjXQsu8Qcqqe4xgjQwc2cyrSrQC7aMNiKafKpwQqVc=
Received: by 10.49.90.4 with SMTP id s4mr1639166nfl.1171566512238;
        Thu, 15 Feb 2007 11:08:32 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Thu, 15 Feb 2007 11:08:32 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39842>

on a linux-2.6 repo it fails during exit

Done.
QProcess: Destroyed while process is still running.
Segmentation fault (core dumped)
Program terminated with signal 11, Segmentation fault.
#0  0xb764db4f in QTabWidget::indexOf () from /usr/lib/libQtGui.so.4
(gdb) where
#0  0xb764db4f in QTabWidget::indexOf () from /usr/lib/libQtGui.so.4
#1  0x080ce7c5 in ~RevsView (this=0x81bb070) at
/usr/include/qt4/QtGui/qtabwidget.h:171
#2  0xb6fa1e61 in QObjectPrivate::deleteChildren () from /usr/lib/libQtCore.so.4
#3  0xb736add5 in QWidget::~QWidget () from /usr/lib/libQtGui.so.4
#4  0xb760fe41 in QMainWindow::~QMainWindow () from /usr/lib/libQtGui.so.4
#5  0x080de0a4 in ~MainImpl (this=0x813a498) at ../build/../src/mainimpl.h:34
#6  0xb6fa460b in QObject::event () from /usr/lib/libQtCore.so.4
#7  0xb7371d77 in QWidget::event () from /usr/lib/libQtGui.so.4
#8  0x080b0a7c in MainImpl::event (this=0x813a498, e=0xb30df08) at
mainimpl.cpp:653
#9  0xb7329590 in QApplicationPrivate::notify_helper () from
/usr/lib/libQtGui.so.4
#10 0xb732bc66 in QApplication::notify () from /usr/lib/libQtGui.so.4
#11 0xb6f954a4 in QCoreApplication::sendPostedEvents () from
/usr/lib/libQtCore.so.4
#12 0xb6fb7790 in QEventDispatcherGlib::processEvents () from
/usr/lib/libQtCore.so.4
#13 0xb6e0b802 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
#14 0xb6e0e7df in g_main_context_check () from /usr/lib/libglib-2.0.so.0
#15 0xb6e0ed45 in g_main_context_iteration () from /usr/lib/libglib-2.0.so.0
#16 0xb6fb76ae in QEventDispatcherGlib::processEvents () from
/usr/lib/libQtCore.so.4
#17 0xb73a7935 in QX11Info::copyX11Data () from /usr/lib/libQtGui.so.4
#18 0xb6f932f1 in QEventLoop::processEvents () from /usr/lib/libQtCore.so.4
#19 0xb6f933fa in QEventLoop::exec () from /usr/lib/libQtCore.so.4
#20 0xb6f957f8 in QCoreApplication::exec () from /usr/lib/libQtCore.so.4
#21 0xb7329007 in QApplication::exec () from /usr/lib/libQtGui.so.4
#22 0x080c8fb4 in main (argc=0xb78dd7a8, argv=0x814f150) at qgit.cpp:22
