From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 18:30:57 +0200
Message-ID: <34a7ae040705300930l6b43aeb9qcb2a68858848d3d@mail.gmail.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
	 <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com>
	 <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Matthias Lederhofer" <matled@gmx.net>,
	"Junio C Hamano" <junkio@cox.net>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 18:31:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtR4m-0004ii-OD
	for gcvg-git@gmane.org; Wed, 30 May 2007 18:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbXE3QbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 12:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbXE3QbA
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 12:31:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:54721 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbXE3Qa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 12:30:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so228696ugf
        for <git@vger.kernel.org>; Wed, 30 May 2007 09:30:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VsYQ7pl4wat3Q5MPsVX3kNJpsoZEaRWkn4pGHLvlMLvFN9vDjXcMD/xV1PL4aM/KOlxBg6jqBs5rWwbY6w7ta4amoTZ/HZLPgB3VXDkU7Q9Ef343+Rx464Ru63Djmf3TcDVFwpSLenqLlZM2rE8ZzPHim4imod/VBcXBi96jFHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BABOmeAIm2tgex6KzxIby0S+XP0lYdoVQUvLA95KGVnoHgZ3O+mBVuULK6l3UFvFm1IMwmVW8Edx1MB2PKHUid1Y63b77BrXpnaDa5bc+0tkoXS6abZT6liyoiyL6ub/6gVd+vOiSUji0JPBh7y/EGaxN/60agvKaZB6v00GadE=
Received: by 10.78.204.7 with SMTP id b7mr975704hug.1180542657752;
        Wed, 30 May 2007 09:30:57 -0700 (PDT)
Received: by 10.78.183.11 with HTTP; Wed, 30 May 2007 09:30:57 -0700 (PDT)
In-Reply-To: <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48771>

2007/5/30, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> On 5/30/07, Paolo Teti <paolo.teti@gmail.com> wrote:

> > to move a file in a Clearcase view you have to use 'cleartool mv ...'
> > (or 'cleartool relocate') and not the UNIX mv command...
>
> 'cleartool mv' is used for clearcase-manages files. My git repository
> are private files.

ok, but also cleartool mv works for private file..

Take a look at:

http://www-1.ibm.com/support/docview.wss?rs=984&context=SSSH27&context=SSCGQ7D&q1=mv+read-only+files&uid=swg1IC46584&loc=en_US&cs=utf-8&lang=en

should be a clearcase bug.
