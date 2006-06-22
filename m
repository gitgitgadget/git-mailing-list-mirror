From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Added macro support to qgit
Date: Thu, 22 Jun 2006 16:04:55 +0200
Message-ID: <e5bfff550606220704q568d8345o1420a0a3e29544e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: proski@gnu.org
X-From: git-owner@vger.kernel.org Thu Jun 22 16:05:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtPnp-0005xX-2v
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 16:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWFVOE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 10:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWFVOE5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 10:04:57 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:42352 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751787AbWFVOE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 10:04:56 -0400
Received: by py-out-1112.google.com with SMTP id f28so315940pyf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 07:04:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eaJ1zG54pd+UEU66aiLs1QEtrPoAtCLzKtTNFFzsZDE5Ig2N8IwmIwV6dw3R61ZZZywFOyAsHOt0U+Io16GNFtGPKSb+TTnH63UWhwK3cQtHhaS84QNvX7VFuhZ+wlNsUTLFvF3s9p+tw0TA/8AF33DTN1+yrVlOMTJ68Q57V6U=
Received: by 10.35.135.12 with SMTP id m12mr1126848pyn;
        Thu, 22 Jun 2006 07:04:55 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Thu, 22 Jun 2006 07:04:55 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22342>

I have pushed some patches that add macros to qgit.

>From menu bar it is possible to  run a macro created by a fancy new
dialog invoked by 'Macros->Setup macros...' menu.

See http://digilander.libero.it/mcostalba/macros_menu.png
        http://digilander.libero.it/mcostalba/macros_dialog.png

A macro can be associated to a any sequence of commands or to an
external script.

In case of commands sequence, these will be wrapped up in a temporary
script and executed as a whole.

A macro can also ask for command line arguments before to be run so to
allow for maximum flexibility. In case of multi commands sequence
given command line arguments will be bounded to first one only.

While a macro is running a terminal window is shown to display the
corresponding output.

qgit repository is: git://git.kernel.org/pub/scm/qgit/qgit.git

Comments and feedback are welcomed.

     Marco
