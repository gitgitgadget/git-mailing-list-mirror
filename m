From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 10:46:41 +0100
Message-ID: <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 11:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr7O4-00030r-Nr
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 11:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbZIYJqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 05:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbZIYJqj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 05:46:39 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:62368 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbZIYJqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 05:46:39 -0400
Received: by ewy7 with SMTP id 7so2407472ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=eG8zSRkk0p2u5W6GJdWuRG9Z5S1ouQI9xsXysN6r97Y=;
        b=lPXgJCe3abKuYZezlajb6bEse69CZfoNbjiDCeWK9HKJ2Kd0AwrQ7jAcVlJrRpLeVm
         pUusfUbxLiOqHyS991R7Hx7Jb7rViV52LqooYTb5Hk8fclrr/OI/iGyZPlWPhK++Jqaj
         XHZ3+HC2cd5rUXjZRyv2exr+t4bWBa79TifHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=okOs/IhQaHMCqZTw9ZvGDUaDglHaSkG5axJrwDJeF1xPn2Vxx1saAhaLbZfGCOMm51
         Owb1ZxoKapiLRKzINzlY9pgJXUhBhwQ8PXV78rQR500k1VcbtLUdQ7LisV3xdR9gDwUg
         3t4O76GP83VRAKLkbXQN8mPStNfY5xiOZh4V0=
Received: by 10.216.52.14 with SMTP id d14mr997875wec.26.1253872001782; Fri, 
	25 Sep 2009 02:46:41 -0700 (PDT)
In-Reply-To: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129071>

On Fri, Sep 25, 2009 at 10:40, Marco Costalba <mcostalba@gmail.com> wrote:
>
> and now
>
> git log --pretty=format:%h
>

Sorry, the correct command is:

git log --pretty=format:%H

but output is still abbreviated.
