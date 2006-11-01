X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/10] gitweb: Better quoting and New improved patchset view
Date: Wed, 1 Nov 2006 19:52:32 +0100
Message-ID: <200611011952.32979.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 18:52:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lAW2w4jhTv0LWbj9y7QNOvgVI9ntuCJtLUWdvLK3Wnh//mz1uvTXUTjSnyHXhL2xBxlI6/hKq+6sNgY5xiLM3peuEd9yC26RdlfXoCMkC48J+DzFooF242pCoAWHKxziQoAGaowb6FNcvVDET1PJWkI0YZ7bhHyHVciAicuHIx4=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30650>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfLCM-0006jz-QC for gcvg-git@gmane.org; Wed, 01 Nov
 2006 19:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992545AbWKASwX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 13:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992547AbWKASwX
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 13:52:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:37957 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S2992545AbWKASwW
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 13:52:22 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1791747ugm for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 10:52:21 -0800 (PST)
Received: by 10.67.93.7 with SMTP id v7mr8658173ugl; Wed, 01 Nov 2006
 10:52:20 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 72sm891478ugb.2006.11.01.10.52.20; Wed, 01 Nov
 2006 10:52:20 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> This series of patches is meant to introduce 
> "New improved patchset view" in part-by-part
> case.

And thus endeth "New inproved patchset view" saga.

Patches in series:
 [PATCH 01/10] gitweb: Better git-unquoting and gitweb-quoting of
               pathnames
 [PATCH 02/10] gitweb: Use '&iquot;' instead of '?' in esc_path
 [PATCH 03/10] gitweb: Use 's' regexp modifier to secure against
               filenames with LF
 [PATCH 04/10] gitweb: Secure against commit-ish/tree-ish with
               the same name as path
 [PATCH 05/10] gitweb: New improved patchset view
 [PATCH 06/10] gitweb: Remove redundant "blob" links from
               git_difftree_body
 [PATCH 07/10] gitweb: Output also empty patches in "commitdiff" view
 [PATCH 08/10] gitweb: Fix two issues with quoted filenames
               in git_patchset_body
 [PATCH 09/10] gitweb: Better support for non-CSS aware web browsers
 [PATCH 10/10] gitweb: New improved formatting of chunk header in diff

Diffstat:
 gitweb/gitweb.css  |   79 +++++++++--
 gitweb/gitweb.perl |  378 ++++++++++++++++++++++++++++++++--------------------
 2 files changed, 303 insertions(+), 154 deletions(-)

Shortlog:
Jakub Narebski (11):
      gitweb: Better git-unquoting and gitweb-quoting of pathnames
      gitweb: Use '&iquot;' instead of '?' in esc_path
      gitweb: Use 's' regexp modifier to secure against filenames with LF
      gitweb: Secure against commit-ish/tree-ish with the same name as path
      gitweb: New improved patchset view
      gitweb: Remove redundant "blob" links from git_difftree_body
      gitweb: Output also empty patches in "commitdiff" view
      gitweb: Fix two issues with quoted filenames in git_patchset_body
[*1*] gitweb: Remove "--" from "git ls-tree -z <hash> --", added overeagerily
      gitweb: Better support for non-CSS aware web browsers
      gitweb: New improved formatting of chunk header in diff

[*1*] Not send as patch itself, but as comment about patch
-- 
Jakub Narebski
