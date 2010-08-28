From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sat, 28 Aug 2010 17:20:31 -0500
Message-ID: <20100828222031.GC5777@burratino>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
 <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
 <20100828214641.GA5515@burratino>
 <20100828215956.GB5515@burratino>
 <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marcin Cieslak <saper@saper.info>
X-From: git-owner@vger.kernel.org Sun Aug 29 00:22:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpTn3-0006EE-Qp
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 00:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab0H1WWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 18:22:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36289 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab0H1WWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 18:22:16 -0400
Received: by yxg6 with SMTP id 6so1555654yxg.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5jV/2kc97xPbj5ggWY6h9WI2VsripMKWAWJ69VjtRMc=;
        b=kGmnKK/PJqjsys14agnCADEQChI0mUfNMr7hM4rGA5FXYy36JcJywqCvW+j+lawVwl
         BfhK5Gyle0C8Vz2gySQ/dBGN7IomPB5/vnaX71AAurCbrnHTUkZHzAwufgea4msTqkGm
         XO9eGE/9YU/RJ8QPdO+rOx/3wSc28rAv5Hi0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Tu4P5KYIJLHncREbmv1VmfMyKtsqT+2rEOfQfj0gl2YQ/UwDbSd37waTxp8pdU83PS
         6bZFP0aCB+DziPU4o96UkEZ9kh1FkgGpoqbl3UYiWILP4NcnHDvTiIGKMq4wqQOW4/G7
         RbAOvoSWCQTWuVASZfiU+r6hiwYLuwaklKQeY=
Received: by 10.150.178.11 with SMTP id a11mr3782527ybf.40.1283034135474;
        Sat, 28 Aug 2010 15:22:15 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m11sm5751435ybn.16.2010.08.28.15.22.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 15:22:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154663>

Marcin Cieslak wrote:

> What's wrong?

http://sourceware.org/bugzilla/show_bug.cgi?id=6530
