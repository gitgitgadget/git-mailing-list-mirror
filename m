From: Eugene Sajine <euguess@gmail.com>
Subject: feature request/proposal - clone --bare, init and init --bare with 
	descrition
Date: Fri, 9 Oct 2009 14:24:41 -0400
Message-ID: <76c5b8580910091124w442e67fco52a445f16689b3ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 20:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwKDs-0003Cy-Sf
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 20:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760406AbZJIS0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 14:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759077AbZJIS0Q
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 14:26:16 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:44780 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZJIS0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 14:26:16 -0400
Received: by ywh6 with SMTP id 6so6434500ywh.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=tNIFYoxDZ05qO2M5PyHz62Vm//X9OV9VriV8dhO41XY=;
        b=hiMvKuE6YasLSsfZWEw1c/79D+EWopzWcj3lsQ9v+m8JB/17aRyGgzbpcKtGtyd5cq
         nAZay9lYbj7wJqUHOAReZi3/O2LYKTelmWEIjUDMd4JxrVHpaQOFehD+HumMATEum1uA
         wETEsaLfzCRwhKRlpBetyPBkwViB7eiXFXXG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=ozqk961Ho1mwKHQ/6twLa/5BJVoO0YIao1Hd3tbSb5ZVu2dcKpQ5XQgn9Z1fF/rztE
         xmzrk4QbLfyD81FhVDmVKBtSPW2f3oPpwOS3PyLaVsN48Q2/kL9LoAvt2c5mXZPxvpZG
         IixnIkbF20mWzT/T0DmX789TK/+nDWVMlC3l8=
Received: by 10.90.176.16 with SMTP id y16mr1588174age.52.1255112681823; Fri, 
	09 Oct 2009 11:24:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129828>

Hi,


here is the use case:

I'm migrating a project from CVS. I'm geting a git repo from git
cvsimport. Now I have to create a bare copy of it and put it on the
server so gitweb will see it.
Currently i have to do:

$ git clone --bare repo repo.git

I would like to be able to do

$ git clone --bare repo repo.git -d "this is my super-duper project"

So, the message goes directly to the description file.

Same thing with init or init --bare

I should have a possibility to do

$ git init --bare -d "this is my super-duper project"

What do you think?

Thanks,
Eugene
