From: David Michael Barr <b@rr-dav.id.au>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Thu, 4 Oct 2012 18:17:52 +1000
Message-ID: <A4A111D1488E49FFA4D71D85DD6B87A4@rr-dav.id.au>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUw-0001w8-QH
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965325Ab2JDISA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:18:00 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:47665 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932554Ab2JDIR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:17:58 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so130564dak.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 01:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:x-gm-message-state;
        bh=mFgssH0uGdCPa1fxiijRpEME6K/f+JRSDgTIUA2CsyA=;
        b=Y0WkHxAdecass8idalQgDTVWLhZSOIoyA/vUAYzOPw0F4UbT1Ynsqhu2oMZtaMmrs+
         JzMy4TJtOkqiqbkyBRyX8k2E72J4HnPDL2vp87vSevNWfocW1AvycJOs7Vokzx5dPVl1
         KiPw/6waWdMQgQhXKX8ddK4tCQ53ECM+xntF1ngUni1QsiGPw1QxaMFnJ0is4u7vy2Qv
         lWqR2IKRc0zYS+G7xVDWOqIoNQeODYdHs5idp27eeh+4Oj9IFJC+PhJqazmI9inr+e4w
         Uoq5o1/lrzWD66sGFdNhH8ix2A5ZKCtReyKgTgwcQr8wt8T9ZnUahCSCpWdFvKSAF/vX
         yVxg==
Received: by 10.66.72.132 with SMTP id d4mr11390731pav.61.1349338678308;
        Thu, 04 Oct 2012 01:17:58 -0700 (PDT)
Received: from [192.168.0.12] (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id wn1sm3981689pbc.57.2012.10.04.01.17.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 01:17:57 -0700 (PDT)
In-Reply-To: <7vmx045umh.fsf@alter.siamese.dyndns.org>
X-Mailer: sparrow 1.6.4 (build 1176)
Content-Disposition: inline
X-Gm-Message-State: ALoCoQl7Y6pCQWNj4DycdXHWlid9q+EbyRfqCiJVVtCjtQWuGozeMql4Y3hECBr2/6eveKV9J+Ue
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206998>


On Wednesday, 3 October 2012 at 9:20 AM, Junio C Hamano wrote: 
> 
> * fa/remote-svn (2012-09-19) 16 commits
> - Add a test script for remote-svn
> - remote-svn: add marks-file regeneration
> - Add a svnrdump-simulator replaying a dump file for testing
> - remote-svn: add incremental import
> - remote-svn: Activate import/export-marks for fast-import
> - Create a note for every imported commit containing svn metadata
> - vcs-svn: add fast_export_note to create notes
> - Allow reading svn dumps from files via file:// urls
> - remote-svn, vcs-svn: Enable fetching to private refs
> - When debug==1, start fast-import with "--stats" instead of "--quiet"
> - Add documentation for the 'bidi-import' capability of remote-helpers
> - Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
> - Add argv_array_detach and argv_array_free_detached
> - Add svndump_init_fd to allow reading dumps from arbitrary FDs
> - Add git-remote-testsvn to Makefile
> - Implement a remote helper for svn in C
> (this branch is used by fa/vcs-svn.)
> 
> A GSoC project.
> Waiting for comments from mentors and stakeholders.

I have reviewed this topic and am happy with the design and implementation.
I support this topic for inclusion.

Acked-by: David Michael Barr <b@rr-dav.id.au>
> 
> * fa/vcs-svn (2012-09-19) 4 commits
> - vcs-svn: remove repo_tree
> - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
> - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
> - svndump: move struct definitions to .h
> (this branch uses fa/remote-svn.)
> 
> A GSoC project.
> Waiting for comments from mentors and stakeholders.

This follow-on topic I'm not so sure on, some of the design decisions make me uncomfortable and I need some convincing before I can get behind this topic. 

--
David Michael Barr
