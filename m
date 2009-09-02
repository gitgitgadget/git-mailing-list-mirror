From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Re: [StGit PATCH] Import git show output easily
Date: Wed, 2 Sep 2009 22:51:40 +0200
Message-ID: <a1e915350909021351l315358a0s9d8c076440bc0fb7@mail.gmail.com>
References: <20090902175039.21633.25294.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 22:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miwo5-0003M0-8E
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 22:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbZIBUvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 16:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbZIBUvn
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 16:51:43 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:56018 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbZIBUvm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 16:51:42 -0400
Received: by fxm17 with SMTP id 17so1095398fxm.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=3dr9tCwKEn9F/ZKYaIkYehdP+geSSlLaXg/euWBFNiQ=;
        b=VlHpZm9tRfYXFxeR0MFbXnAKKfOnbQNhGDLQxgs+0Y6gkRBZ2dR8bK7OSMBXpBH5VX
         CmsqpcvQoaxEkhIJ6vkdS7T6gYBMeOA5LQOI9jFvuDdwYYktnoNWHYSYoCGnhqgdOHv9
         3l3ebURCs/WWISP0VU4VlCVpsBMhmPejzrGcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=k8Vf1vkZmoQypUS+sYiwOW420Rmcd5/68RiOp0S3i1xNY8wb3ApjUB7qAeCeFWhNjq
         sTtn4BemLTy7Pjhgkdkw+uvo/+zJi8hWvVTVtIBbfidFOl897ggJvvWFH1KgrRUwdPDn
         9/GViGtslv1EGQbC6ZGjOd/xGVh5Hu2Z6WRgE=
Received: by 10.204.8.21 with SMTP id f21mr7135561bkf.129.1251924703913; Wed, 
	02 Sep 2009 13:51:43 -0700 (PDT)
In-Reply-To: <20090902175039.21633.25294.stgit@pc1117.cambridge.arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127630>

Somewhat related:

It would really rock if stg import could handle the regular patch "-p<N>" flag.
In particular, I miss -p0 as some broken versioning systems default to
such output.

- Gustav
