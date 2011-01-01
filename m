From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4 v4] minor gitweb modifications
Date: Sat, 1 Jan 2011 17:02:14 -0600
Message-ID: <20110101230214.GA1483@burratino>
References: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
 <20110101104121.GA12734@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Sun Jan 02 00:02:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZAT6-0007FT-Ap
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 00:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab1AAXC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jan 2011 18:02:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50864 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab1AAXC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jan 2011 18:02:28 -0500
Received: by iyi12 with SMTP id 12so11202579iyi.19
        for <git@vger.kernel.org>; Sat, 01 Jan 2011 15:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=b2Q7svg1EASswHPI89AXHeFWph5A41Gc8RCDaegOG54=;
        b=E22lPAgZtqKW9j/2WDK5GAaLtB+JXT9wBR0o3S6QhmY+LEK8qQUBKa1p1Pkwp7j/F6
         YooNTenAlg5QMPdqm0sYZdbwoe64X2uLpVXOWmM9XLjtnHrtZxSXn8ZftxfIajW76cPO
         F2C7HHmvyMrs5vOsnw0+vcNUx5ma9US6AMBJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iQZRgeVaywgPCaThOExSdSPpu4xu2jKL5KINVq+OIPsQ7lbvDfWt7YY/VNLosFU156
         MVYL69D4iOf0iTRNU5N2szZzwbL5cv+dX3rOLPyAWPHwKdrG/4O4RDSQKECE+UMmbHmY
         3gROupdTQYijaUUHBqldQkfJeITc8TVroOkLA=
Received: by 10.42.240.68 with SMTP id kz4mr19439985icb.471.1293922946101;
        Sat, 01 Jan 2011 15:02:26 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id z4sm16999023ibg.13.2011.01.01.15.02.23
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 01 Jan 2011 15:02:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110101104121.GA12734@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164405>

Jonathan Nieder wrote:
> Sylvain Rabot wrote:

>>   gitweb: add css class to remote url titles
>
> I had a question (why make the remote url table inconsistent with the
> older projects_list table) and suggested a more generic approach in
> reply to v2[1]:

Sorry, forgot the link before.

[1] http://thread.gmane.org/gmane.comp.version-control.git/164004/focus=164010
