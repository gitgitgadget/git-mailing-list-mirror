From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [GSoC update] git-remote-svn: Week 1
Date: Mon, 10 May 2010 17:08:46 +1000
Message-ID: <66B5CC1B-044A-483E-88D2-DCB0785E3ABE@cordelta.com>
References: <g2zf3271551005050559v2ea99346gcc59f941d634ce1a@mail.gmail.com>  <90AEA593-35CC-403E-8918-94DB45BC0E06@cordelta.com> <o2pf3271551005091512qdebc006cic2c5b85ab7a9e23e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 09:09:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBN6v-0008D3-3o
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 09:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab0EJHI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 03:08:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52345 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab0EJHIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 03:08:54 -0400
Received: by gyg13 with SMTP id 13so1743340gyg.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=dPHwq7WdSKyGWEVbUuw4vc3xRMmoPvMq/rex5itLkwQ=;
        b=qEP0QGCTBE9VIsITgGiM4JVTQwvfEgqOO80r/2MayCbP4wUrMwVM9ma/gsC6pAGDpk
         R2LJotLo0zcT6ZTFP6pEsM79roNpGI+pybCQ9UdkNLYXv4yiJYt+NhHLR/kIkjJt0th7
         7LJPuBzCO5/hEvcdMnJGCO3snASdVPNbXCODw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=mwOy91VZrB6pZvGcVklf221RGNjmB+h//EpbApRNE0D0VtuvIYEuxiLEzFegZkTGOl
         OYccPSdmGK4Ig3aD7stkmG4TE1nzBwJiVEeN1Ah+o6+6ny75DN4o3vWi6ECjE2mZmum7
         DaXSWT1PjunxLwtNrPN8oBoc9J/E+opTRJ9wk=
Received: by 10.150.120.5 with SMTP id s5mr7560455ybc.331.1273475332776;
        Mon, 10 May 2010 00:08:52 -0700 (PDT)
Received: from [192.168.1.2] (d122-109-106-179.mit3.act.optusnet.com.au [122.109.106.179])
        by mx.google.com with ESMTPS id 21sm3433672ywh.6.2010.05.10.00.08.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 00:08:51 -0700 (PDT)
In-Reply-To: <o2pf3271551005091512qdebc006cic2c5b85ab7a9e23e@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146764>

Hi Ram,

My off-list reply was because I was still waking up.

>> A quick update. I've begun work on a reference exporter written in perl.
> 
> Curiously, why?

I was working on a slow but reliable alternate implementation for
validation and regression testing. So far, it seems really hard to write
anything reliable atop Subversion.

>> I believe I introduced some regressions during code cleanup.
>> From memory, the svn-dump-fast-export_0.8 tag has been verified for
>> 10,000 revisions of my repository.
> 
> Thanks for the heads up. Don't worry about it though- I've started
> cleaning up the code. Will send you some patches off the list by
> email, or whatever you prefer.

I know its bad form, but I've done what I promise is the last history
manipulation on my public repository. Now that the code is at a point
that is quite functional and ready to receive contributions, I've signed
off on my own commits and reviewed the history.
Its not yet '1.0' but hopefully Ram's eyeballing of the code will get us
there.

--
David Barr
