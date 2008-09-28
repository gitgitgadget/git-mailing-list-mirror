From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sun, 28 Sep 2008 12:01:03 +0200
Message-ID: <200809281201.04161.jnareb@gmail.com>
References: <200809251230.11342.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 12:02:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjt6l-0006Rw-Rw
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 12:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYI1KBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 06:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYI1KBW
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 06:01:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:48630 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYI1KBV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 06:01:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1101133fgg.17
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TZMjACnbW/gaCo47UtqW/ZuuouGYhRIJvj1mq+ApRmk=;
        b=C7Ece2M5wPKYQ56KdFfQmTchNSzov2dPmL6R0u6xjVnXBi0q2xIGkDShe1oPOyurTR
         rfJDg4vy/zkuek2C0Xg8V1TxuNBjmpgJFadBCLeHzHO1QTHbDSNja+PsK6nGKzAGRwUK
         ETwOCvYnlGFYMo8jNocihqwzypwPt9vbzbFX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XET0DoxoYWAGYP9QGcZ9C2bLfvL9s2Bkzg1J3AMPnqHjVk/3Bf4xVghu58juuyPUIx
         xfxkZeqBmZA5F+zhiUPQwwX6E0A+LkfRyBn/fHw+zFL1oJ2jvkaWpMHP1Oft0pdIz7EH
         QfmJNlWnDZpkswMg0gi00uTQgn59JHehARmYM=
Received: by 10.86.74.4 with SMTP id w4mr3014289fga.78.1222596077562;
        Sun, 28 Sep 2008 03:01:17 -0700 (PDT)
Received: from ?192.168.1.11? (abvg103.neoplus.adsl.tpnet.pl [83.8.204.103])
        by mx.google.com with ESMTPS id 4sm1516904fge.8.2008.09.28.03.01.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Sep 2008 03:01:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200809251230.11342.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96955>

On Thu, 25 Sep 2008, Jakub Narebski wrote:

> This is yet another series of planned gitweb features. It expands more
> on new user-visible features than on improving gitweb code (therefore
> for example using Git.pm/Git::Repo, gitweb caching, and list form of
> open for pipelines are not mentioned here).

Below there are a few more features which were missing from the list:

* Support for invoking gitweb.cgi (the compiled version) from command
  line to easy generate projects list in format used by gitweb,
  perhaps also to generate web feeds (RSS, Atom, OPML). It would
  probably require adding support for CLI parameters.

* gitweb-admin or gitwebmin; I guess best as separate script.
  
  Allow to set gitweb configuration, gitweb-related per-repository
  configuration (visibility, access, description, README, URLs,...).
  Perhaps also allow to set access permissions, delete/create
  branches, change denyFastForward, rename project, set alternates,
  etc.

* Make gitweb use less dependent on understanding git terminology, like
  'tree' -> 'browse' etc. (proposed by Pieter de Bie (Pieter) on #git,
  as "simplified interface", 2008-09-27T14:56+0200).

  'tree' -> 'browse', 'blob' -> 'file' or 'show', 
  'snapshot' -> 'archive' or 'download', 'heads' -> 'branches'
  'commit | commitdiff | tree | snapshot' -> 'show | browse' for heads
  
  Unfortunately there is no consensus on how such simpler terminology
  should look like...

* Support for generating bundles, and not only snapshots, either
  depth=1 bundles, or diff bundles (snapshot for diff is bundle).

* Support for i18n (translating gitweb), best using 'gettext' which
  the rest of git (gitk and git-gui) uses (use Locale::TextDomain,
  or Locale::Maketext?).

* Possibly: fallback to "user.name <user.email>" for repository owner

-- 
Jakub Narebski
Poland
