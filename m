From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 18:18:26 +0100
Message-ID: <200704171818.28256.andyparkins@gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
	"Tomash Brechko" <tomash.brechko@gmail.com>,
	"Pietro Mascagni" <pietromas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 19:19:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdrKS-0004sS-6Q
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 19:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbXDQRSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 13:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbXDQRSo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 13:18:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:31886 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161095AbXDQRSm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 13:18:42 -0400
Received: by ug-out-1314.google.com with SMTP id 44so222364uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 10:18:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mw9X9hA7oraPF9b2FUwzO8klSHHQ6R8nMTSXq3AnIpWc1gQEJPD4S4dlxYCOTeLuihcna1sU65NCJ5g0yqNWf0uqtyN048vvUyNBUzDtCHWXKu+NBb56YsRyot2yA6Lfsp5TcfzK5ZHH+9xIfiZ42K9p5qy2r/M6q24cpKCsvAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cISesvfyi+FjpeiTK/fR7uOepl6yuhiz0zldQv7oo3fxXaYkwzpk2t0Jp3QmTJ1namps7JtAzb7fGKhTGjqf2qgGquqpbJ1yiyJUkErCkiL8A9kOWrp/bzZjoxlsU0VfbLOQkkuKLmKrAEL4QDGKH42gk4ZG1ixU2WagqnV7qL0=
Received: by 10.67.106.3 with SMTP id i3mr625832ugm.1176830321216;
        Tue, 17 Apr 2007 10:18:41 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id b23sm1421370ugd.2007.04.17.10.18.39;
        Tue, 17 Apr 2007 10:18:40 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44803>

On Tuesday 2007, April 17, Guilhem Bonnefille wrote:
> I'm new to Git, but completly crazy of it.
>
> In my point of view, in corporate team, lot of people does not
> want/need the power offered by Git.
> So, my conclusion is the better model in a corporate is a centralyzed
> repo with some users using Git as "frontend". Other people will
> simply use the native tools for accessing the repo.

Git has you covered there - it works better than other version control 
systems for that model too.  I do it all the time; the only difference 
is that with git it's not the tool doesn't force the choice on you.

If you want a central repo, just make one - designate one repository as 
central, put it in the .git/config file for each of the others and away 
you go.  Pretend it's centralised if you want; you and your colleagues 
need never know otherwise.

What's even better is that everything will also work faster, take less 
diskspace and be heavily backed up just by everyone doing their normal 
work.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
