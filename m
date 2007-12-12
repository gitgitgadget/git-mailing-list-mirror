From: "=?ISO-8859-1?Q?Eirik_Bj=F8rsn=F8s?=" <eirbjo@gmail.com>
Subject: Re: Efficient retrieval of commit log info
Date: Wed, 12 Dec 2007 16:19:05 +0100
Message-ID: <34660cca0712120719p2d7cda44s97ab770abd648742@mail.gmail.com>
References: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
	 <Pine.LNX.4.64.0712121453150.27959@racer.site>
	 <alpine.LFD.0.99999.0712121001430.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 16:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2TNh-0006tm-EJ
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXLLPTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbXLLPTH
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:19:07 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:43205 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbXLLPTG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:19:06 -0500
Received: by rv-out-0910.google.com with SMTP id k20so234868rvb.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 07:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4knaBeeawgnh9uDToHk5IvyRaq8vM+h6EJSksdyNvWI=;
        b=rM7eLvvxxPcvXba8nA4BvbSGRzdtx34BGDuZP2wsj/lQgmzFYRJ3Fud4uC3gXqHF0DjtoOHN0kJcz6gCKjqBdayWxbdu4R0yKVH6BgqjFeSFjHawseYhdclARtNnz/3TmjrkHOvyYtdoomRhfiMxYvYtIra31K74EZK+eQmpVGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=erRYZcBdfxZr2vzniXrRZ7WSDII3NyXWx5ostTt97dxNBgVd7Tq1bgDx3Iwxw0VoOMorFvI07bzN0GCN3hsqoObopvbVE/sNxZJnQ7PJfeunun746z//1FdADgVPM1xE3pvYJ+Kl/Xm73Ksa+yvMam6OW77xRnNxg5RwEd6fowY=
Received: by 10.141.136.19 with SMTP id o19mr391733rvn.250.1197472745868;
        Wed, 12 Dec 2007 07:19:05 -0800 (PST)
Received: by 10.140.207.1 with HTTP; Wed, 12 Dec 2007 07:19:05 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712121001430.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68048>

> On the other hand, this is pretty trivial to extend the protocol so only
> commit objects are transferred.  Using 'git log' on the client side
> would work, as long as you don't use any of the content walking options.

Nicolas,

So what you're suggesting is that:

1) git-clone could be changed such that the user could ask not to
fetch content, only commit objects.
2) git-daemon (or the protocol layer, again I'm not familiar with the
implementation) could be changed such that it only sends commit
objects on request.
3) Changes to git-log is not necessary.

Anybody have a clue how much work this would require and if this is
something that would be generally useful for the community?

Eirik.
