From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-ls-files -m lists the same file multiple times
Date: Wed, 25 Apr 2007 19:52:04 +0100
Message-ID: <200704251952.07644.andyparkins@gmail.com>
References: <200704251035.33713.andyparkins@gmail.com> <7v8xcgz4ye.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 20:52:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgmbR-0001H2-UN
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 20:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992913AbXDYSw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 14:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992898AbXDYSw0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 14:52:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:2547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992894AbXDYSwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 14:52:25 -0400
Received: by ug-out-1314.google.com with SMTP id 44so475524uga
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 11:52:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uJYGv8x+VXaxccP0ybvOQmitPlVM3tglRRQbLKiBiSXlpdPaeOaVVuVewLr1tmG819/6X/B9y7oZrH5d1LiJtd2U5zvbwKth4BdtshBMIC2P7RXs2y3zZ31mDRqPXh2cU13247Rw/40pz9byUy5pT0osCfvttOc+4fYPWgFA/DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mcRzimoj63AULcZc9MUrsKwdlXHA2To+ooMPWh8uV1whQjNoWFEzmWb2PbhtVQQnhsf4DSJe91Od0KvvB5j6CpEfwvSzZhMumPo8X6ze7NS4vB50dZ5JIU9+pL2ZCzifxNUJcMesYU+8pca2YvmlbaADqcGg38rCX1L8tNpiOBA=
Received: by 10.67.106.3 with SMTP id i3mr1595339ugm.1177527144662;
        Wed, 25 Apr 2007 11:52:24 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id k28sm3739160ugd.2007.04.25.11.52.23;
        Wed, 25 Apr 2007 11:52:23 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v8xcgz4ye.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45542>

On Wednesday 2007, April 25, Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> > I did a merge, which had conflicts, and then fixed the conflicts. 
> > To see what files I'd changed I did git-ls-files -m.  This listed
> > the same file multiple times.  Some of them twice and some of them
> > three times.
> >
> > I guess that it's showing different stages; but as the list is just
> > filename, there is no way to tell which is which and it is just
> > confusing.
>
> I did not imagine that anybody actually found 'ls-files -m'
> useful, either during a conflicted merge or under the normal
> situation.  'git diff --stat' is usually much more pleasant to
> see.

Definitely.  You see I am in the strange position of being able to type 
faster than I can think, so typing

 git-ls-files -m | xargs git add

Saves me the trouble of engaging my brain :-)

> Use 'ls-files -u' during conflicted merge and be happy.

Great stuff - that's the one I wanted; in fact git-ls-files -m did what 
I wanted, because it didn't matter that xargs listed the same file 
multiple times.

Thanks


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
