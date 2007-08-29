From: Jakub Narebski <jnareb@gmail.com>
Subject: GitWiki: GUI editing and Wikipedia-like syntax incompatibile
Date: Thu, 30 Aug 2007 01:37:34 +0200
Message-ID: <200708300137.35000.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 30 01:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQX6T-0000Fx-Un
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 01:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbXH2Xhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755792AbXH2Xhi
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 19:37:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:19940 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682AbXH2Xhh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 19:37:37 -0400
Received: by nf-out-0910.google.com with SMTP id g13so319221nfb
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 16:37:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FF0xs5lIbYOPSWxbM3cHvNCY6crR/f/4PxLwzleTzWOKrIkBYwMoDoeJmGtWJT4Z+u23bwxzBKEQqcTAqDu9uKSBjPxk1TTA9EWjNJuAHzlOzCHMaNS1wZ2ejX+j5I08Pvy6vgkHzTnpS6St55lMyZJ6AqnxXXkl2MjXO1/Fr/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PT4fbnQCf5xmCfm+0jS86stvPNv6H6r8IfUsP45pHDIhLrZ43GqSVBzpri8Py71n8b8dpJD8sPoO2OKydyQvt23SZJn7cMYxRyx2jePdku0luRkyqfSILQ1dLjSvONrVS0rW5lJUS9UAdJmn2SUsPrJoH6LH+ZigdGJIr/ddxe8=
Received: by 10.86.58.3 with SMTP id g3mr912864fga.1188430656066;
        Wed, 29 Aug 2007 16:37:36 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 13sm10119849fks.2007.08.29.16.37.33
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Aug 2007 16:37:34 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56990>

Pasky, could you please either turn off GUI editing on GitWiki, or make 
it compatibile with Wikipedia-like syntax.

With Wikipedia-like syntax we denote links by [[link]], and macros by 
{{macro}} (for example {{BR}} and {{TableOfContents(2)}}). In default 
MoinMoin syntax _macros_ use [[macro]] syntax, and you use ["link"] to 
force non-CamelCase link.

Editing page which uses Wikipedia-like syntax with GUI editing makes the 
following changes:

  [[CamelCase]]         -->   CamelCase
  [[Link]]              -->   ["Link"]

(this is not much trouble, beside fact that everyone is used to 
Wikipedia syntax)

  [[Link|the link]]     -->   [:Link:the link]

(much less people understand MoinMoin notation that Wikipedia pipe link)

  {{Macro}}             -->   [[Macro]]

(which causes macro to be displayed as link to nowehere and DO NOT 
WORK!!!)

  Camel``Case           -->   Camel{{{}}}Case

(a bit harder to read).


To everybody else: please avoid GUI editing till it is corrected. TIA.
-- 
Jakub Narebski
Poland
