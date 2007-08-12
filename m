From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: msysgit: should core.autocrlf=true be the default on Windows?
Date: Sat, 11 Aug 2007 22:36:51 -0700
Message-ID: <84CFEBB5D7FE48FF86FEF3289C8DDAA8@ntdev.corp.microsoft.com>
References: <7816DAAF-53CB-468C-9597-36AA94AC6476@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 07:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK68I-0003Fc-2R
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 07:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbXHLFgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 01:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbXHLFgz
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 01:36:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:25342 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbXHLFgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 01:36:54 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1429807wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 22:36:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=DExU7EWItflVNp9MLy2C1qdKLQ8wDy8CUe2fWNDy0wSgFc5sgd4NCHs0QP4aJGBPGz7tldGmkiqyzq04SkY2OOugjp/MWaVJlL4s/kyyJL7Ciax/GZ76ixl8gF0WSD8ay2UNeU6blwffCCEQbtzVlzJGqGMxlUqb3xeLGDgJBck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=dxkko/Nc5+TTVh2679M7z8QSiX9xZQ/0XJRTBoJy0UCPma1zH4cO8b3xoFgUeVgNhC7PIrSVttUffiuu9evnotEMdoIZSz7kclBoN81hqv5/H/xa3NLNcRv74NdRY0j5UEwGgp9600vCwd3tOifNqJpEpGum+WB5whwqX+9z63M=
Received: by 10.114.202.15 with SMTP id z15mr1392558waf.1186897013550;
        Sat, 11 Aug 2007 22:36:53 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id v25sm4916154wah.2007.08.11.22.36.52
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Aug 2007 22:36:52 -0700 (PDT)
In-Reply-To: <7816DAAF-53CB-468C-9597-36AA94AC6476@zib.de>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MIMEOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55665>

Please keep in mind that msysgit is targeting developers who want to contribute to MinGW port of git.
Since building and editing happens in MinGW environment the LF-only default seems reasonable.
On the other hand, setup for end-users should have it as default, I agree.
Please report this issue here: http://code.google.com/p/msysgit/issues/list

- Dmitry
----- Original Message ----- 
From: "Steffen Prohaska" <prohaska@zib.de>
Newsgroups: gmane.comp.version-control.git
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>; "Marius Storm-Olsen" <marius@trolltech.com>
Cc: "Git Mailing List" <git@vger.kernel.org>
Sent: Saturday, 11 August 2007 13:56
Subject: msysgit: should core.autocrlf=true be the default on Windows?


>I think core.autocrlf=true should be the default on Windows.
> I strongly believe that Windows users expect this default,
> as others Windows application rely on it. I recently tried to
> use kdiff3 on Windows and got satisfactory results only after
> using autocrlf.
> 
> autocrlf should be set right from the very beginning. If you
> found out about it later, you would have to convert your existing
> working trees, which is not too easy. Therefore we should
> guide the user to a reasonable default.
> 
> We can report the defaults we chose in *bold* after the
> installation completed and give a hint where further background
> information can be found, and what would be needed to adjust
> the default.
> 
> What do you think?
> 
> Would /etc/gitconfig in msysgit be the right place to set the
> default?
> 
> Steffen
> 
>
