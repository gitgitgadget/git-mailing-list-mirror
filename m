From: bill lam <cbill.lam@gmail.com>
Subject: how to do "git merge --abort"
Date: Fri, 21 Aug 2009 22:51:57 +0800
Message-ID: <20090821145157.GA6471@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeVTU-00017r-T9
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 16:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbZHUOwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 10:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbZHUOwF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 10:52:05 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:41234 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbZHUOwE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 10:52:04 -0400
Received: by pxi34 with SMTP id 34so4031107pxi.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=lwXfIa6p/uoG3qlWNptxRsNKOhW6E7NZ0OrndFaPmd8=;
        b=UP6njxtwZ6+TyiIuuDefyrFVzqfma1CkcRrbbWB1/niV6yd6hjRuAJAlchHAAnbhoF
         F50aT//gHXGudL0hVlDNbqhhHrzATeKgNpbzUT9V/EWrM0RJMxkJmW0ymU6XzQL4DpLt
         PdG8t0jWef14cXYNbfclJb5B6ajKZ7YiYWA68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=A6J6H8uEl8OKsMDk/TojPWSIL1dmvowvXJ16ohqOJzBO16QITRGfIkjLu+f/ILT6KR
         /1Vmbq++M6raMkQhkoFUnKuQz7at0yOtJvn0Pj+8ISKF98GnQL+9hRufCRWrbA5RxBsv
         pybReN4pXAP0y+3A0rjgPUWwv5dfAb2cH19yw=
Received: by 10.115.29.5 with SMTP id g5mr661512waj.223.1250866323805;
        Fri, 21 Aug 2009 07:52:03 -0700 (PDT)
Received: from localhost (n219079101006.netvigator.com [219.79.101.6])
        by mx.google.com with ESMTPS id j31sm1404550waf.49.2009.08.21.07.52.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 07:52:02 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126729>

How to abort a merge if it said there are conflicts but I do not want
to (or can not) resolve it for the moment.  I can not find the --abort
option as that for git-rebase.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
