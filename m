From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git svn project shuffle
Date: Fri, 15 Oct 2010 11:48:11 -0500
Message-ID: <20101015164811.GA10204@burratino>
References: <AANLkTimL18WHOrLjA5iWNcsgd6H8Eeq19LfJNjkKu_b-@mail.gmail.com>
 <20101004185424.GA6343@burratino>
 <AANLkTimxbmk2u=4d1b1LS+GMp9ry__4TtEx5UMJPk4-5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Snapp <snappca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 18:51:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6nVX-0006Ck-3H
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 18:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354Ab0JOQvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 12:51:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60422 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081Ab0JOQvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 12:51:44 -0400
Received: by wyb28 with SMTP id 28so835681wyb.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/1lQoW/kJ0pNl1sZ1LthLxR966+c7nN96uL7/YTG5gM=;
        b=xYrPPNy7+I36RWfDKvDcF1dBb4BCFVjVqZzBDTovgioB8ngi8GY380Z+DMqninaBY5
         fBzPM+6aEMHXcE1ZpY/seQ2uOXveADbdFijnJetX7ruz5LiD77z3yMuADo1DKr0PQPoK
         YVmPWCCd3r5lqY7N2oeYyw+QcA5YqNdp+gytQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jzXXzhscpI1IOE8ANczgLrtyKaoTb/sz8dQmWZRwmogIBIWGfiTzCdBhuGdtBSZN/y
         c1ZckuMJhNgHvi+Pu0712XkDPWyvj7qfGhMDEeMn+uxTSGw2VDFX5XNMDmRH4r5HtHfD
         7Ig21/BWwKetJBti7SRGkrG8H9IzMTc6129DQ=
Received: by 10.216.91.16 with SMTP id g16mr1081951wef.78.1287161503057;
        Fri, 15 Oct 2010 09:51:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x12sm4130376weq.18.2010.10.15.09.51.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 09:51:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimxbmk2u=4d1b1LS+GMp9ry__4TtEx5UMJPk4-5@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159124>

Hi again,

Christopher Snapp wrote:

> If you remember my old project's trunk has been copied to a
> subdirectory of the new project's trunk.  So, oldproj/trunk is now
> newproj/trunk/oldproj.

Yeah, I was ignoring this part. :)  git svn is not really wired for
it.

The instructions were meant to also be usable in a case where oldproj
and newproj are entirely independent repositories.

> When I do a git svn clone of the newproj I
> would expect it to follow the svn copy that created
> newproj/trunk/oldproj but it doesn't.

If the layout has been relatively stable before, maybe "git svn
--no-follow-parent" would give some joy.

Still I would be interested in hearing where the grafting procedure
went wrong.  If you end up tracking it down to a single step, do
please let us know.

Regards,
Jonathan
