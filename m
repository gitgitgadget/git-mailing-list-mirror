From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 11:20:39 -0500
Message-ID: <AANLkTim5RYDuius6Oa6KX0weQhwVz+_YP=1-ujb3-CuJ@mail.gmail.com>
References: <20100817144215.GC24886@kytes> <15605020.115671.1282060094242.JavaMail.root@mail.hq.genarts.com>
 <20100817155933.GB6947@kytes> <AANLkTikyrC07OnMJWDmC7n0ks3TdOxb=jPmKWbK9Nc7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Stefan Sperling <stsp@elego.de>,
	Bert Huijben <rhuijben@collab.net>,
	Will Palmer <wmpalmer@gmail.com>,
	Philip Martin <philip.martin@wandisco.com>,
	Jonas Gehring <jonas.gehring@boolsoft.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 17 18:21:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlOv3-0001UH-Iw
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 18:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131Ab0HQQVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 12:21:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53631 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab0HQQVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 12:21:03 -0400
Received: by gyd8 with SMTP id 8so81510gyd.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=v+WkQO2c44Rk8z3OQuNTqPvaV7N0R4JpM+hpvx8Hdow=;
        b=Jx3KI62rQJTvkKtTaOMGgZPbO4Sujy+yVcQ0sJF6PNUs5kbjF5f1C5gsp0xeLdLsfe
         uAk5jbeSAg7KBxvvuZwTfJBmnDKkhnJjy+eAmJrG1s3SYo0km0GCrqgvTu00HD7pRm1D
         nEjnNp/Z/4IucYd6gAk9M9Kb1ootkVE6kwJrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=h/cNrFTzt+NL2UxLNzyH1J/2Eo1yQ/wJTi70QILOz75URoF0SfrtVpeCAXSBTt69z/
         0gDPVRt4jfsRGbO8DO9g8tPKM//s+V7KqqI9NFTvoQcNI/1d8VMtWwPUz2o+/F2oV87L
         MAyC48sI+ApJg5egP2lOjLxkyLEry0hY6Twlw=
Received: by 10.150.13.10 with SMTP id 10mr7599075ybm.416.1282062059175; Tue,
 17 Aug 2010 09:20:59 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Tue, 17 Aug 2010 09:20:39 -0700 (PDT)
In-Reply-To: <AANLkTikyrC07OnMJWDmC7n0ks3TdOxb=jPmKWbK9Nc7u@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153759>

Heya,

On Tue, Aug 17, 2010 at 11:10, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, Aug 17, 2010 at 5:59 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> We're doing better than that- when the whole thing is complete, we
>> should have perfectly seamless two-way compatibility.
>
> Does this include handling SVN repos where the layout have changed
> during it's lifetime? If so, how will this look on the git side?

Perhaps it makes sense to start a new thread to hash that out for when
the time comes to implement that?

-- 
Cheers,

Sverre Rabbelier
