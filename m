From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Thu, 23 Oct 2008 19:50:51 +0700
Message-ID: <fcaeb9bf0810230550t54813c09m3b1984f065732c0@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 14:52:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kszfe-0006l6-Cc
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 14:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbYJWMuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 08:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYJWMuy
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 08:50:54 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:46145 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYJWMuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 08:50:54 -0400
Received: by gxk9 with SMTP id 9so1240749gxk.13
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tL3w694LxgVPU3fVr1KLXM80O3/SRS8+guxw5YLeErw=;
        b=UCERIVUgOhI9i/7SGBuZIjdSLo49OmaW5h6fMjSBDxuGpNGU1eg9nmdSsuL4YN7J6A
         bJEuQj7fpT6Qgmf+Nl1R0fzyxJQFPJ+xQ2WiVB1ndBr31a4s26TKdBJtYBb/W0lzTiLl
         yDXduy0oIVmuTZUBiBieJmZEZEuUOeEa73maA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=khT2fkQrmy/vlPn1jyXXHqCZz3dRLbzRZoHEiQGjoQEX+q1rt1QpKb/QuU1ZILhVS/
         qcfu1/XzZdAPtfkcGGm/jP4Oi34wMWZ51PT63LsYT2eyQ9gBbDJCfHK+bYOfad9VIFQJ
         xiSzqjatMMtSWkFfR/R0eO15D+s1JwGTmbZxM=
Received: by 10.86.4.14 with SMTP id 14mr2244302fgd.20.1224766251588;
        Thu, 23 Oct 2008 05:50:51 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Thu, 23 Oct 2008 05:50:51 -0700 (PDT)
In-Reply-To: <gdok16$vh2$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98957>

On 10/23/08, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
>  The principle is extremely simple: when you choose to start tracking a
>  file with Zit,
>
>  zit track file
>
>  Zit will create a directory .zit.file to hold a git repository
>  tracking the single file .zit.file/file, which is just a hard link to
>  file.

Why not use one .zit repo and track each file on each own branch?.
-- 
Duy
