From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 10:32:38 -0400
Message-ID: <799406d60706220732y76d94f07h54bbe9443a08f497@mail.gmail.com>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
	 <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
	 <20070622022426.GA2961@bowser.ruder>
	 <799406d60706220636q4f7a3c17v6833d2eda25e8f0d@mail.gmail.com>
	 <1182521850.6207.42.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Raimund Bauer" <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 16:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1kCD-0005H1-JU
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 16:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbXFVOck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 10:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbXFVOcj
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 10:32:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:22184 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbXFVOci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 10:32:38 -0400
Received: by wx-out-0506.google.com with SMTP id t15so831138wxc
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 07:32:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RpjpB+TazjG2LOHEWC+rMnZjcwvN6dqZ/LFcICpwGTK8BTTfK0+TmFgZ+9kESTAo3rK32A+mhmFGSFAuIHAInjud+147eGs9LsBBDlTxHkvGIm9gx+ywHvw7q07opXMszfpEyJihwnGBiY46VKrhEcnVnq558vMum8wVqAYNnc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bvJjKd+6LrbZagDBEtFAf2lcAv6jGkKo2yT59NngRjhcKEvRX/x9d6DWb6zsmSZ6cykdWQBdb6a0AEQ1eftLVG8e6v3pQU78hwYetVvFOZjCL+UZwCZXmMBMzN47L0kgaoVJZQjkGnJ3SeL8aE5I6Q4LxtRLe34QJtBTHaLBo4g=
Received: by 10.90.95.11 with SMTP id s11mr2659018agb.1182522758270;
        Fri, 22 Jun 2007 07:32:38 -0700 (PDT)
Received: by 10.90.28.17 with HTTP; Fri, 22 Jun 2007 07:32:38 -0700 (PDT)
In-Reply-To: <1182521850.6207.42.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50700>

On 22/06/07, Raimund Bauer <ray007@gmx.net> wrote:

> In my config it looks like this:
>
> [remote "slcom"]
>         uploadpack = /usr/local/bin/git-upload-pack
>         receivepack = /usr/local/bin/git-receive-pack

putting

[remote "glue"]
  uploadpack = /home/ram/opt/git/bin/git-upload-pack
  receivepack = /home/ram/opt/git/bin/git-receive-pack

in my .gitconfig I still get the error saying that git-receive-pack
can't be found. If I specify the path on the git push command line
using the --exec option then git-receive-pack is found, so it appears
that my config file isn't being read.

Cheers

Adam
