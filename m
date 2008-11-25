From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 22:19:35 +0100
Message-ID: <200811252219.38530.jnareb@gmail.com>
References: <900638.56188.qm@web37904.mail.mud.yahoo.com> <m3skpfk1mp.fsf@localhost.localdomain> <7vprkjjz79.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Koch <thomas@koch.ro>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gary Yang <garyyang6@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 22:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L55LP-0007aF-Jj
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 22:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYKYVT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 16:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbYKYVT6
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 16:19:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:58838 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbYKYVT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 16:19:57 -0500
Received: by ey-out-2122.google.com with SMTP id 6so68836eyi.37
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 13:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nLThFHrofnpYap2o+f6JTcU4XU3Szm6AM/RvPgIqzUM=;
        b=MCQ7XsN8sr8TVnZvme6/741SGIHK8gilmWGbXP3LvT0nJNUH97m3O2tvnHPNIpWkfL
         9waHHb8UQsfcF8PmaPjQrSZR++iSWHgImYgUKqLoFQXxGV3dw/djyGqNPSN1868J1fqZ
         UrMoIcLb5ssqIropgcAHNSoql8luc0I3VkJu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=F0AXvKOXgXkO4FHz7kIYJyCcYe3PddwgGhweW+7/mY0h/zJc0NimMiQbDN5lJdabZP
         pBAMA0Q8wU6qhAzg28pDWI9GSUeXjek+UxV6FUAcGzLTQoBMVxWTULK2w0WaXBrcdwF0
         N+xcaAbnccoUoCWhB+RKy3OCPBrzoezHCtX28=
Received: by 10.86.100.19 with SMTP id x19mr3252917fgb.29.1227647995698;
        Tue, 25 Nov 2008 13:19:55 -0800 (PST)
Received: from ?192.168.1.11? (abvl147.neoplus.adsl.tpnet.pl [83.8.209.147])
        by mx.google.com with ESMTPS id 3sm47087fge.3.2008.11.25.13.19.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Nov 2008 13:19:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vprkjjz79.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101684>

On Tue, 25 Nov 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > If you have something more fancy, check out newest gitweb and take a
> > look at gitweb/INSTALL: you can now, thanks to commit dd7f5f1 by
> > Alexander Gavrilov, see
> >   http://permalink.gmane.org/gmane.comp.version-control.git/99962
> 
> Somehow I had an impression that you weren't enthused about that
> patch. 

I didn't like original version, but quite like the one that got in 
git.git: very flexible and nonintrusive. I have acked it, haven't I?
-- 
Jakub Narebski
Poland
