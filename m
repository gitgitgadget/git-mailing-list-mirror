From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Wed, 11 Apr 2012 08:51:16 -0700 (PDT)
Message-ID: <m3y5q29si7.fsf@localhost.localdomain>
References: <11292500.AVmZFUUvNi@flobuntu> <2148933.pnpYo0xMAP@flomedio>
	<2487557.B8qfnaixh3@flomedio> <1421035.yALBSXSHGd@flomedio>
	<20120410171707.GA3869@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 17:51:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHzpM-00070I-9S
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 17:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab2DKPvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 11:51:19 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34106 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab2DKPvS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 11:51:18 -0400
Received: by wibhr17 with SMTP id hr17so4136081wib.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lsEawR3sHkz14kNSSmnOpge1b8s+uu3ereYVVE1XpiM=;
        b=cRW7R+dAEfrhnUjEwhZL5eU6YDR9+ykocxmRbL26Q79Agm7MX+tpwXQhbl9Nq6WBXB
         AtKXA3VIh/hzTRIeFbH5gJPR0tI2i2lXkt81P+JdsKvwuLyGqihKX0pST1VJTAxJAN+S
         anOp2IKcnI6d1hHyVEs3MWoZ3Q6seZxhEPsHNeIcLjLs6frQ3KdPKTCSa8R7++dfPcmI
         bogjrONrFE22inloefg/JBjsCqIPQQupnOQ+cL6SJ5bBFshnCeOisbcS6ZdBdMslOqpr
         DqxOP3Y24o7wjtoVYg4c759yOg9bcSzxn64JY+9hsaosbteJU7DErn/ypDGS0btuIWqG
         k1pQ==
Received: by 10.216.225.216 with SMTP id z66mr8975320wep.71.1334159477243;
        Wed, 11 Apr 2012 08:51:17 -0700 (PDT)
Received: from localhost.localdomain (acxc116.neoplus.adsl.tpnet.pl. [83.11.160.116])
        by mx.google.com with ESMTPS id k6sm45709808wie.9.2012.04.11.08.51.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 08:51:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q3BFpFi7024282;
	Wed, 11 Apr 2012 17:51:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q3BFpDRm024279;
	Wed, 11 Apr 2012 17:51:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120410171707.GA3869@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195193>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  2. Teach the remote helper to import a single project from a
>     repository that houses multiple projects (i.e., path limiting).
> 
>  3. Teach the remote helper to split an imported project that uses
>     the standard layout into branches (an application of the code
>     from (2)).  This complicates the scheme for mapping between
>     Subversion revision numbers and git commit ids.

Can't we use the either peg rev notation of externals, or the notation
that Subversion itself uses for svn:mergeinfo?

-- 
Jakub Narebski
