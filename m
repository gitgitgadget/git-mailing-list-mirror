From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: reverting a file or files back to repository copy
Date: Sat, 2 May 2009 11:25:37 -0400
Message-ID: <eaa105840905020825v561f610dj99b1b00581bf1b3d@mail.gmail.com>
References: <137A749092D040488A7F25B4CA5ED1DC@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Sat May 02 17:25:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0H64-0007Cy-Ig
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 17:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbZEBPZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 11:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbZEBPZj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 11:25:39 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:40604 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbZEBPZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 11:25:38 -0400
Received: by bwz7 with SMTP id 7so2773324bwz.37
        for <git@vger.kernel.org>; Sat, 02 May 2009 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=lBH3oAFmoDfiVVXc0xsDshaxxh1MIJD/i0+5Bw/KO2Y=;
        b=se0jtV1VaqvZV/IZmpRzYhht9Z5sMihhbc+frZTfkRApkJGxfswWo877nUAcdWzl9y
         ayWij5TmuDEK2btg8aWALRSQBh3qE2LEPlQoPI2aCO3FG8NTu9ICUnyZTlzVe3KQa6X0
         4044q8VgHameDVw/IEe14BhRQEjVgpFWBkt5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=x2G7IsoJgN/mgOi+D4BHz+3+6hcNL1McucvfrA5R0Jx4Yvq87WF4zc6hPZA/PHiBs0
         9tlL18tW16EGuP80/FWfYI1i/JAmE9ZMnPXvhZ7OhyNaQM++ZGKsXUBzFXrCPr67t//E
         tZnVEiTcTaKfCcqkXzZbVkiOOHz6pGuCdCyIg=
Received: by 10.204.31.204 with SMTP id z12mr3752144bkc.80.1241277937594; Sat, 
	02 May 2009 08:25:37 -0700 (PDT)
In-Reply-To: <137A749092D040488A7F25B4CA5ED1DC@HPLAPTOP>
X-Google-Sender-Auth: a54290b35b3e4e16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118136>

On Sat, May 2, 2009 at 10:54 AM, Aaron Gray wrote:
> How do I do the eqivalent of an 'svn revert' on a single file, on a
> directory of files, or on all files ?

git checkout <files>

Peter Harris
