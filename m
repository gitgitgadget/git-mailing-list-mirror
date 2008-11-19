From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and mtime
Date: Wed, 19 Nov 2008 05:29:43 -0800 (PST)
Message-ID: <m3abbvlu9a.fsf@localhost.localdomain>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:31:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2n93-0005cF-U0
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYKSN3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbYKSN3r
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:29:47 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:32911 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYKSN3q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:29:46 -0500
Received: by qyk4 with SMTP id 4so1294004qyk.13
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 05:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=5geey/cbaD48MBk+OobG1ZgSgZbot5CHZtgeIY1y5ic=;
        b=PPS2oShLUdoMFirynDCitzEIGbG39JBJv5JtH/xsp/uX/OXLuPPfdO/Y4DnnSaReVM
         72Z7CvIZXCfupvlJXUjtmXW30cKvDTh94Q3t72G69/q4CtnTxdv4Kmx85Y/PyYiht/lj
         rCFwS3g6TyyQ2Hj+DYgCF6H4SDlf3QJGU2ifk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=k+z0tKQP/1v+LTnNs/BTc3pzXbDcPmODlSmCAi87DWx4L2XLROm5rp50OlQHJcXiS3
         AQyGxsonFD0/7lW63qmroqDP9QmfEEUgwqwSyFFWDlph+g+gNDFqwCKV14fCpZMYxZ5K
         463EamYNLghmraVs591DlhIBsPTlBlmfM6HXM=
Received: by 10.214.79.17 with SMTP id c17mr997724qab.276.1227101384794;
        Wed, 19 Nov 2008 05:29:44 -0800 (PST)
Received: from localhost.localdomain (abwv176.neoplus.adsl.tpnet.pl [83.8.245.176])
        by mx.google.com with ESMTPS id 7sm2336450qwf.0.2008.11.19.05.29.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Nov 2008 05:29:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAJDT8s8029953;
	Wed, 19 Nov 2008 14:29:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAJDSoUm029949;
	Wed, 19 Nov 2008 14:28:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081119113752.GA13611@ravenclaw.codelibre.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101341>

Roger Leigh <rleigh@codelibre.net> writes:

> Would it be possible for git to store the mtime of files in the tree?
> 
> This would make it possible to do this type of work in git, since it's
> currently a bit random as to whether it works or not.  This only
> started when I upgraded to an amd64 architecture from powerpc32,
> I guess it's maybe using high-resolution timestamps.

I don't think it would be done as in core change at all, or at least
soon.

You can use Metastore, or some custom clean/smudge gitattribute
filters with something like Metastore (or etckeeper) to store extra
metadata about files in your tree.

See http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

-- 
Jakub Narebski
Poland
ShadeHawk on #git
