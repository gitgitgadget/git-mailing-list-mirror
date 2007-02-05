From: Baz <brian.ewins@gmail.com>
Subject: Re: qgit on Mac OS X
Date: Mon, 5 Feb 2007 19:20:33 +0000
Message-ID: <2faad3050702051120o245e0554wa8625b6f48e3bb6a@mail.gmail.com>
References: <loom.20070205T130544-216@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pazu <pazu@pazu.com.br>
X-From: git-owner@vger.kernel.org Mon Feb 05 20:20:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE9OU-0001r9-Bf
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 20:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933348AbXBETUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 14:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933379AbXBETUf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 14:20:35 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:20652 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348AbXBETUe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 14:20:34 -0500
Received: by an-out-0708.google.com with SMTP id b33so1106057ana
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 11:20:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PRf1ZfmL5MS7mmto9TzgNAPL6DArmrJlYlK1Z9F0GFqfT9aeH1vJx9FX1mbEP44l2eENPXqpeArlmtzM0zurl76RZW5Ve7L4/DlDMQtJxpqzngt188VyrnIXQnb2zKTjL8AqEv4VoX8PYteLGDaIYRTxmEdlHgsJnlXKFOW59Hg=
Received: by 10.100.132.16 with SMTP id f16mr5279129and.1170703233342;
        Mon, 05 Feb 2007 11:20:33 -0800 (PST)
Received: by 10.66.238.7 with HTTP; Mon, 5 Feb 2007 11:20:33 -0800 (PST)
In-Reply-To: <loom.20070205T130544-216@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38769>

On 05/02/07, Pazu <pazu@pazu.com.br> wrote:
> Has anyone tried to compile and use qgit on Mac OS X?
>
> This week I installed qt-mac (3.3.7), and tried to compile qgit. Everything went
> surprisingly well, and compilation finished without any errors. Now I'm able to
> launch qgit, but the main window seems unable to receive focus, so I can't
> interact with the application. Here's an screenshot:
>
> http://pazu.com.br/dav/qgit-osx.jpg
>
> So, I'd love to hear if anyone else tried to use qgit on OS X, and if you had
> better luck than me.

I havent tried qgit, but I've seen this happen with other apps, and
the Qt/Mac docs mention the problem:
http://doc.trolltech.com/3.3/mac-differences.html
"GUI Applications must be run out of a bundle (something like
widgets.app/) or using the open(1) command. Mac OS X needs this to
dispatch events correctly, as well as gaining access to the menubar.
If using GDB you must run with the full path to the executable."

I'm guessing the command line you used, obscured in the screenshot,
was something like
> `pwd`/qgit

Try:
> open ./qgit
instead. BTW, the same advice is in the docs for Qt4.

HTH
-Baz
