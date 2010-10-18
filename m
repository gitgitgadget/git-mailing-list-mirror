From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/RFC 0/11] Building up the delta parser
Date: Mon, 18 Oct 2010 22:30:28 +0530
Message-ID: <20101018170018.GJ22376@kytes>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:01:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7t5Q-0001t8-MN
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467Ab0JRRBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 13:01:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63578 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130Ab0JRRBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 13:01:15 -0400
Received: by yxm8 with SMTP id 8so544425yxm.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=j9Ty2/DzRvNry5g2Hi4hzkddWX3p2yLjVypi/bFKQyY=;
        b=b8LthoDS3MV6i2yZsK8BXmN7KP9MkehDerACvmjBHoNbSItdjHplPV+amDXQ5ImopW
         DLBIlxK3VjXdofOan2XYg68PtpsqpOItDKUOrnBk3nKNtS/iGxsGFCMO7tGWkJe4Wq53
         qnc/k7wzsGtHqLEFxSQaHmhx/ekyHKNgzPcFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fIe0AUTebFabKEVQa6E7wUEzAKXQH/2DwOfUSLDe4Ny+AFH5tXF9Cbpg70R8SW2Izx
         XJKcVXjgR01KD9xBAUH/tjjG2F09dYERLs2+iTcaJujNS2k97RCN3mY1moQHirbkU166
         zxBIs+X0y0qEljqbnGTuZP/mItwDHCAe4vEKQ=
Received: by 10.150.207.20 with SMTP id e20mr7234043ybg.398.1287421274636;
        Mon, 18 Oct 2010 10:01:14 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 3sm9000891ano.21.2010.10.18.10.01.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 10:01:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159266>

Hi Jonathan,

Jonathan Nieder writes:
> Jonathan Nieder wrote:
> 
> > Implement an svndiff 0 interpreter
> 
> I hear that was nigh unreadable, so here's a reroll.  Less
> cargo-cult support for broken deltas, more readability and tests.
> Patches apply on top of "[PATCH 15/16] t9010 (svn-fe): Eliminate
> dependency on svn perl bindings".  As before, the end result
> includes a 'test-svn-fe -d' command that can apply svndiff0-format
> deltas, meaning less binary garbage to worry about as you puzzle
> over that confusing "svnrdump dump" output in debugging sessions.

Thanks for this! The code looks really good and the test suite is
quite comprehensive :)

Eager to see this go through to `master`.

-- Ram
