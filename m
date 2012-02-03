From: David Howells <dhowells@redhat.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Fri, 03 Feb 2012 13:47:00 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <4681.1328276820@redhat.com>
References: <CAD-XujkVK=tOtmVS90U0KAutFZ55jxsHMKuuMppXOi-H6ZY=RQ@mail.gmail.com> <21056.1328185509@redhat.com> <9B990DDC-858D-43BA-BF9E-E0C3435354AF@gmail.com> <15281.1328207789@redhat.com>
Cc: dhowells@redhat.com, "git@vger.kernel.org" <git@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
To: Valerie Aurora <valerie.aurora@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 14:47:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJTv-000793-HW
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447Ab2BCNrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 08:47:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36685 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756168Ab2BCNrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:47:09 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q13Dl4JO008170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 3 Feb 2012 08:47:05 -0500
Received: from redhat.com ([10.3.112.8])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q13Dl1Gh016427;
	Fri, 3 Feb 2012 08:47:02 -0500
In-Reply-To: <CAD-XujkVK=tOtmVS90U0KAutFZ55jxsHMKuuMppXOi-H6ZY=RQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189773>

Valerie Aurora <valerie.aurora@gmail.com> wrote:

> And for a complete (meaningful) rewrite such as David has done, he
> changes the commit authorship and adds a Signed-off-by for the
> original author.

Val[*] hasn't signed off all her patches, and indeed I've merged together some
patches that she has signed off and some she hasn't.  I can't simply add
Signed-off-by her without her permission.  However, if she's willing for me to
add such lines, then I can do so.

> Signed-off-by: Some Upstream Author
> Signed-off-by: Maintainer or Merger (rewrote error handling)

And if the changes are more than can be put in what's left of the line?  I
would've thought it would make more sense to do something like:

  Signed-off-by: Valerie Aurora <valerie.aurora@gmail.com> (Original author)
  Signed-off-by: David Howells <dhowells@redhat.com> (Further development)

David

[*] Apologies for talking about/to you in the third person, Val.
