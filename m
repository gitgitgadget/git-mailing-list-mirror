From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Error in Git
Date: Tue, 3 Nov 2009 13:15:25 +0100
Message-ID: <fabb9a1e0911030415m6ed06daaj662a703d801b2e7f@mail.gmail.com>
References: <4AEFEF22.9000909@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ravindra <ravindra.kulkarni@globaledgesoft.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 13:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5IIm-0003r8-CR
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 13:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbZKCMPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 07:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbZKCMPo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 07:15:44 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:50742 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZKCMPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 07:15:43 -0500
Received: by ewy3 with SMTP id 3so1882389ewy.37
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 04:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=AeMGWr9p8y4vph1E9VGdztMy2PCNgi9id+hQRxPDbKk=;
        b=sNmjA1NqcFr8C8sT8WzivcVXkDnzFRHKCIB6coCIRx7f7FLK2tI3Ti7UZBBjiyndqJ
         Qwwhyq+kHwy7SdsqS1UHTnSa/A/JZG6Ha7zAUuEKmizK1PjjlQI37DQ6hy8iQyROawZk
         kjZaP6m3mL42Usg8Tr+053qMvqT0unoL9KpR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OVqPtUDrCI2xr69tJ9vp5OJPGCzhF15IR4RiAJkg0PAAt2IqdQwkCn7tLNshQtP35F
         VkDzEviDq+cuQjSG7u61myatCvAxzTQel3tMmNR96+niNck4xM0dXfEUNtSe3f0+5zgk
         aal4hDBRddG3p55Qh9HmZ1kbh29CQ4esh4e4E=
Received: by 10.216.88.137 with SMTP id a9mr1348985wef.119.1257250548024; Tue, 
	03 Nov 2009 04:15:48 -0800 (PST)
In-Reply-To: <4AEFEF22.9000909@globaledgesoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131969>

Heya,

On Tue, Nov 3, 2009 at 09:51, Ravindra
<ravindra.kulkarni@globaledgesoft.com> wrote:
> When i execute the git command for the url
> git://git.openezx.org/sgh-i900.git I am getting the following error,
> Please let me know how to solve this.

I just tried, and to be more precise, the error is at clone time:

$ GIT_TRACE=1 git clone git://git.openezx.org/sgh-i900.git
trace: built-in: git 'clone' 'git://git.openezx.org/sgh-i900.git'
Initialized empty Git repository in /home/sverre/code/sgh-i900/.git/
trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin'
'--keep=fetch-pack 2980 on LAPTOP-SVERRE'
trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin'
'--keep=fetch-pack 2980 on LAPTOP-SVERRE'
trace: exec: 'git-index-pack' '--stdin' '-v' '--fix-thin'
'--keep=fetch-pack 2980 on LAPTOP-SVERRE'
trace: run_command: 'git-index-pack' '--stdin' '-v' '--fix-thin'
'--keep=fetch-pack 2980 on LAPTOP-SVERRE'
remote: Counting objects: 128422, done.
remote: Compressing objects: 100% (122355/122355), done.
remote: Total 128422 (delta 6110), reused 128357 (delta 6067)
remote: aborting due to possible repository corruption on the remote side.
Receiving objects: 100% (128422/128422), 46.32 MiB | 1.41 MiB/s, done.
Resolving deltas: 100% (6110/6110), done.
fatal: error in sideband demultiplexer

No clue what's wrong though, just wanted to save other people some time :).

-- 
Cheers,

Sverre Rabbelier
