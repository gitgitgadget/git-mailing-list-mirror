From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 Question
Date: Mon, 20 Apr 2015 20:26:53 +0100
Message-ID: <553552FD.80703@diamand.org>
References: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: FusionX86 <fusionx86@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 21:27:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkHLz-00043q-F2
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 21:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbbDTT1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 15:27:21 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35834 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbbDTT1T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 15:27:19 -0400
Received: by widdi4 with SMTP id di4so112276283wid.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=mb7mnV5dUr5Qh32MJ4pBnRa/4NhN/O6EXnO351W23IU=;
        b=PE2SRbxjuJQ6SyFqqQFBlsrxFaULlYbcmmzNgXr5k/QqEnPSbUg6yjk1AzGOzfYgwk
         rRR7jOP9F6Vs0dWigAzUBt4fQaY1IfP+FAcXqGvbrHcKLR86uvTZL7XvRE2A3RUJWQBX
         fq9OG67810JloaGQU6lVV8Cd9YDhcZU78ajHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mb7mnV5dUr5Qh32MJ4pBnRa/4NhN/O6EXnO351W23IU=;
        b=Pn9OYfqSdbpFgi2D3DwoEg8FxckA4KxMLjXN9lTEG4dWoyzIsq3miRQV926XSL5E5P
         yAd1WU8qjVN13UZSmMke+yTAjx6UQfHQVuuynG+lR5nXdU/gQFFkbjiwXTLBQPy2AtFo
         7PRdLbJRpP8EmutLdRIia7PzAybcn0GbIITEPKPaKMeqX7VUGcX2tx89PcV7MjnhYy9f
         nSgcMVtMfYVPm1n4O+6YRh3d8e3H58MQ4sqIq3BgNKO5XYjw2UtNus1CjZ2h1y85yV70
         pNaPB361+0ymBUZQbJrSmcbuLfm2hPOO5RdjI6v66zZ74aQblwhFC18gohbwNJBuGuW3
         RqyQ==
X-Gm-Message-State: ALoCoQlNnNh9rdQNGmpcB0Ng0FFtmnl8bJbwlbff79gXggSl7Ya1cHpzRIrIebABQiHNVHBQ3wn0
X-Received: by 10.194.88.131 with SMTP id bg3mr34749233wjb.119.1429558037832;
        Mon, 20 Apr 2015 12:27:17 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id l1sm16523321wiy.20.2015.04.20.12.27.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 12:27:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267491>

On 20/04/15 17:41, FusionX86 wrote:
> Hello,
>
> Hopefully this is an appropriate place to ask questions about git-p4.
>
> I started at a company that wants to migrate from Perforce to Git. I'm
> new to Perforce and have been trying to learn just enough about it to
> get through this migration. Anyway, I've been playing with git-p4 and
> have one question/problem to discuss.
>
> After setting up the p4 cli client I can 'p4 sync' some
> //depot/main/app1 which pulls down the files I would expect from the
> Perforce server. If I use 'git p4 clone //depot/main/app1', I get:
>
> "Doing initial import of //depot/main/app1/ from revision #head into
> refs/remotes/p4/master"
>
> But I don't get any files from that depot/folder pulled down. I can
> git p4 clone other depot/folders though and get some files. I suspect
> that I'm just not understanding how the git-p4 module works.

You could try doing the clone with '-v' to get a bit more information.

>
> Basically, I'm hoping to setup a live sync of Perforce to Git of
> certain depots in preparation for the migration. Also, if anyone has
> pointers or guides for this type of migration, any help is
> appreciated.

I've done something similar in the past. You'll want to enable the 
--preserve-user option, for which you will need admin rights.

If it's a one-way mirror (p4-to-git) then just run git-p4 periodically 
(if you use cron, then try to avoid having two or more instances running 
at the same time).

If you want it to be two-way then it gets a bit more complicated.

You might also want to consider using git fusion, which is Perforce's 
take on this problem. I've not used it myself.

 From past experience though I would say the biggest problem is getting 
developers to switch from the P4 mindset (centralized; code review hard 
to do or ignored) to the git mindset (decentralized; code review 
actively supported by the version control system).

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
