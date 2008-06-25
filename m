From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Windows symlinks
Date: Tue, 24 Jun 2008 20:04:37 -0400
Message-ID: <32541b130806241704y3befda90j78329af2f30d95d2@mail.gmail.com>
References: <m3od5qjtv1.fsf@localhost.localdomain>
	 <911589C97062424796D53B625CEC0025E46193@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
To: "Patrick.Higgins@cexp.com" <Patrick.Higgins@cexp.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 02:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBIWE-0002qL-5J
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 02:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYFYAEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 20:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYFYAEm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 20:04:42 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:33681 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbYFYAEl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 20:04:41 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2993748fkq.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xAFJRZk4Y1zTZqoGj07tTLYUMaInRl4UU5qk94+AjRw=;
        b=hyUJTKobUMJUeqK3Slp75QZ2jXZX72A27t2/b1VZ7j8bATHYYWISPNF1/JRCqRcexZ
         28DtlWTusCb0Pe2VwfIr5CkPbklz+HG0Iqh8bonJDVYg3N8dV6Jmx01WiEbEKIl6+ZaC
         7GkrOuq/IAA/LVYMstaSNAVXf91tMpjm88KDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l/rhzyoRUuK5Waf9zsTqTz64oX6ATykz4FshKeWyqfYsMKEGw8QCrLeX3dPa4gVv28
         +44sEnHm+snnWXkSmPs/Hba+YLKRhUguop+rV+3ccQv/L88EIG+w+2U25ZambWcQmKSY
         aioGQK15NG2onAqwKNisxHY+LxlMH1vYtyvq4=
Received: by 10.82.187.2 with SMTP id k2mr608138buf.55.1214352278000;
        Tue, 24 Jun 2008 17:04:38 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 24 Jun 2008 17:04:37 -0700 (PDT)
In-Reply-To: <911589C97062424796D53B625CEC0025E46193@USCOBRMFA-SE-70.northamerica.cexp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86189>

On 6/24/08, Patrick.Higgins@cexp.com <Patrick.Higgins@cexp.com> wrote:
> Agreed. The first thing we started working on was getting symlinks out of our repositories.
> Unfortunately, we chose to use them because we are using broken development tools that
> don't support proper modularity. We found the best way to get the IDE's compilation to work
> was to symlink shared code into each project. It's a nasty solution, but it was the only one
> that worked. Clearcase made this solution possible. As powerful and flexible as git is, it would
> have left us out in the cold in this situation.

Perhaps git-submodule would do what you're looking for.

Avery
