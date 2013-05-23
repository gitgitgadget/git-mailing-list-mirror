From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: push not resolving commit-ish?
Date: Thu, 23 May 2013 13:56:25 +0300
Message-ID: <20130523105625.GA17455@redhat.com>
References: <20130523105310.GA17361@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 23 12:56:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfTBp-00063o-9b
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214Ab3EWK4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:56:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62453 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758125Ab3EWK4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 06:56:03 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NAu2vl027661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 23 May 2013 06:56:02 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r4NAu0bx004439
	for <git@vger.kernel.org>; Thu, 23 May 2013 06:56:01 -0400
Content-Disposition: inline
In-Reply-To: <20130523105310.GA17361@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225237>

On Thu, May 23, 2013 at 01:53:10PM +0300, Michael S. Tsirkin wrote:
> Looks like push can't resolve tags to commits.
> Why is that?
> 
> linux$ git push -f $PWD v3.10-rc2:refs/heads/vhost-next
> error: Trying to write non-commit object
> a8c6d53c4d84b3a5eb182758a9cdceceba4691da to branch refs/heads/vhost-next
> To /scm/linux
>  ! [remote rejected] v3.10-rc2 -> vhost-next (failed to write)
> error: failed to push some refs to '/scm/linux'
> 
> linux$ git log v3.10-rc2|head -5
> commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon May 20 14:37:38 2013 -0700
> 
>     Linux 3.10-rc2
> 
> 
> linux$ $ git push -f $PWD
> c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:refs/heads/vhost-next
> Everything up-to-date
> 
> 

Forgot to say - this is recent git.git master:

1.8.3.rc3.8.g5e49f30
