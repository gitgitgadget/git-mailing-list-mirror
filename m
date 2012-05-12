From: Angus Hammond <angusgh@gmail.com>
Subject: Re: git-notes, how do they work?
Date: Sat, 12 May 2012 12:41:10 +0100
Message-ID: <CAOBOgRbN3FgahEbRAWWjQsZwhzBy5M37S6+5xtK2zbquBs6KVw@mail.gmail.com>
References: <20120512104332.GN71676@acme.spoerlein.net>
	<CACsJy8DRujbCc5Etod8eCoUW5+SxK-1qbJaAYw7gdvkO2SdSRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ulrich Spoerlein <uspoerlein@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 13:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STAhJ-0008Jz-Nr
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 13:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab2ELLlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 07:41:12 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41205 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab2ELLlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 07:41:11 -0400
Received: by lbbgm6 with SMTP id gm6so2435323lbb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4gRXzbKb3FqfsYlVa4jv5R/AWIQkPvkINuMHMpfEERk=;
        b=S3s4XZGnZLwHT1IArDcX0dxVX4MMz+kvZZXt9uUKUjnyI0VhkUgbkumlEGVjvCvr2T
         0NrUSTQ725VMxBEuNm+fYWqXn5lT0PlI6JMeE/2Go7EozfN6VZj+PU9E5IKw5O/Xibw3
         W25W6uAz8EIrNcYjbZp8d/zw7/3x6G+Vc6+H6/D9ouLhdLayN7nxIx2oFQxRsGClN+LU
         Mvm4bmc0WtPBL3QC/KNE1sRRw1AvH+QSwy3CVipFwysRnheDgYKZeyM2JE9sBhlj5nI5
         t3+rnq/GqC102FzlnhiF6qVj+Cuob2UAZcvHyeCZCdReAIcR1Z9cpDTWJo9M4rBPzzTH
         8ycw==
Received: by 10.152.111.200 with SMTP id ik8mr1485969lab.15.1336822870209;
 Sat, 12 May 2012 04:41:10 -0700 (PDT)
Received: by 10.114.12.1 with HTTP; Sat, 12 May 2012 04:41:10 -0700 (PDT)
In-Reply-To: <CACsJy8DRujbCc5Etod8eCoUW5+SxK-1qbJaAYw7gdvkO2SdSRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197725>

> What I wrote about were my findings while I studied the notes code.
> I'm new to it too. And I believe there's no mechanism to transfer
> notes. Of course you can transfer resfs/notes/commits like any other
> refs, but the objects those notes are attached to might or might not
> exist at destination repo.

If anyone's interested Scott's written a bit about the problems with
using notes with remote repositories here:
http://git-scm.com/2010/08/25/notes.html . Having said that the post
is almost 2 years old and I have no idea about how notes work in git
myself so I don't know if it's still completely accurate.
