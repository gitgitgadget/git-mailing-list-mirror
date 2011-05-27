From: Jakub Narebski <jnareb@gmail.com>
Subject: What's cooking and todo in gitweb (27 May 2011)
Date: Fri, 27 May 2011 21:47:52 +0200
Message-ID: <201105272147.54723.jnareb@gmail.com>
References: <7v8vtxrlq1.fsf@alter.siamese.dyndns.org> <7vhb8kail7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 21:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ311-00015u-Kc
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 21:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab1E0TsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 15:48:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40828 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791Ab1E0TsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 15:48:05 -0400
Received: by bwz15 with SMTP id 15so1557602bwz.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=tMOg8NMyKVR6iY1vQjfvUkIofZIWX2hkgp7NUWW87uI=;
        b=WkuaklH4sgzHYEMdkvARBLsK616wmOTI90A895/OEy5To32spagAt1FIBJ4i3v9tA2
         Br/dpqj3JeftS4F3Fe2IIOvHsWmu/JMZ44W6eqTaVpxA20kmvqgtO96K4AFPaHXdxmni
         Y7I9tspizF6CpYTaJZDDpt3jCMEavyXAkVOzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ML9T/d5l2V9tM0VwR1sDk7JlRuwRKYMojtYGutb1GbdMz9zhUigMVIfsnneT8XlBrR
         SdbCIAFtMQvF4DwgFCiZxNIB9qf93kK05+JMFaPt13HFX+sOBDFwBFAI8Ib/9MA09P02
         VKZSqs/lNnZhQo3Jv5a8jjxRsutE9Nf98LSDY=
Received: by 10.204.41.77 with SMTP id n13mr1313422bke.39.1306525682731;
        Fri, 27 May 2011 12:48:02 -0700 (PDT)
Received: from [192.168.1.13] (abvw13.neoplus.adsl.tpnet.pl [83.8.220.13])
        by mx.google.com with ESMTPS id ek1sm1508627bkb.9.2011.05.27.12.48.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 May 2011 12:48:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vhb8kail7.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174642>

Here are the topics that were send to git mailing list, topics that
are cooking, and stalled topics (todo issues) for gitweb subsystem.
Commits prefixed with '+' are in 'master', while commits prefixed
with '-' are present only on git mailing list.  Commits prefixed
with '.' are available only in my repository.

Some of those patches are available on 'gitweb/web' branch in my
repositories, other are on separate branches.

  git://repo.or.cz/git/jnareb-git.git
  git://github.com/jnareb/git.git


$gmane=thread.gmane.org/gmane.comp.version-control.git

--------------------------------------------------
[Sent to git mailing list]

* "gitweb: Improving blame_incremental.js" (2011-05-27) 3 commits
  Message-ID: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
  http://$gmane/174616
  part of 'gitweb/web' branch
 - gitweb.js: use setTimeout rather than setInterval in blame_incremental.js
 - gitweb.js: No need for loop in blame_incremental's handleResponse()
 - gitweb.js: No need for inProgress in blame_incremental.js

First two of those are code removal and simplification.  Last patch
might be split into smaller patches.

* "gitweb: Improve handling of configuration files" (2011-05-25) 2 commits
  Message-Id: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
  http://$gmane/174424
  part of 'gitweb/web' branch
 - gitweb: Introduce common system-wide settings for convenience
 + gitweb: Refactor reading and parsing config file into read_config_file

The second patch (version C) addresses I think concerns both of Junio
and of J.H., but there are a few minor issues that would be better to
be resolved first.

--------------------------------------------------
[Cooking]

* gitweb/doc (2011-05-15) 2 commits
  Message-ID: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
  http://$gmane/173422
 - Starting work on a man page for /etc/gitweb.conf (WIP)
 . gitweb: Starting work on a man page for gitweb (WIP)

My contribution, i.e. gitweb.txt is currently based mainly on SVN::Web
manpage structure.  Drew Northup's gitweb.conf.txt OTOH is managed a
bit differently.

* gitweb/split (2011-05-27) 2 commits
  "gitweb: Beginnings of splitting gitweb into modules"
  Message-ID: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
  http://$gmane/172659
 - gitweb: Create Gitweb::Util module
 - gitweb: Prepare for splitting gitweb

Version in my repository is rebased on top of current 'master'; the
one sent to git mailing list has now trivial conflict with change to
gitweb/Makefile that splitting _JavaScript_ files introduce.

--------------------------------------------------
[Stalled and todo]

* gitweb/cache-kernel-short-pu (2011-01-05) 12 commits
  "[RFC PATCH v7 0/9] gitweb: Output caching, with eval/die based error handling"
  http://$gmane/164101
 - gitweb/lib - HTTP-aware output caching
 - gitweb: Background cache generation and progress indicator
 - gitweb: Add optional output caching
 - gitweb/lib - Cache captured output (using compute_fh)
 - gitweb/lib - Very simple file based cache
 - gitweb/lib - Simple output capture by redirecting STDOUT to file
 - t/test-lib.sh: Export also GIT_BUILD_DIR in test_external
 - gitweb: Prepare for splitting gitweb
 - gitweb: Introduce %actions_info, gathering information about actions
 - gitweb: Make die_error just die, and use send_error to create error page
 - gitweb: use eval - die for error (exception) handling
 - gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in die_error

* gitweb/cache-kernel-pu (2010-12-06) 24 commits
  "[PATCHv6/RFC 00/24] gitweb: Simple file based output caching"
  http://$gmane/163052
 - gitweb: Add beginnings of cache administration page (proof of concept)
 - gitweb/lib - Add clear() and size() methods to caching interface
 - gitweb: Support legacy options used by kernel.org caching engine
 - gitweb: Wrap die_error to use as error handler for caching engine
 - gitweb/lib - Add support for setting error handler in cache
 - gitweb: Add startup delay to activity indicator for cache
 - gitweb/lib - Configure running 'generating_info' when generating data
 - gitweb: Show appropriate "Generating..." page when regenerating cache
 - gitweb: Introduce %actions_info, gathering information about actions
 - gitweb/lib - Regenerate (refresh) cache in background
 - gitweb/lib - Serve stale data when waiting for filling cache
 - gitweb/lib - No need for File::Temp when locking
 - gitweb/lib - Use locking to avoid 'cache miss stampede' problem
 - gitweb/lib - capture output directly to cache entry file
 - gitweb/lib - Use CHI compatibile (compute method) caching interface
 - gitweb/lib - Adaptive cache expiration time
 - gitweb: Add optional output caching
 - gitweb/lib - Cache captured output (using get/set)
 - gitweb/lib - Simple output capture by redirecting STDOUT
 - gitweb/lib - Regenerate entry if the cache file has size of 0
 - gitweb/lib - Stat-based cache expiration
 - gitweb/lib - Very simple file based cache
 - gitweb: Prepare for splitting gitweb
 - t/test-lib.sh: Export also GIT_BUILD_DIR in test_external

Two main prerequisites are splitting gitweb (handled), and better
error handling, i.e. what to do with error pages when caching is
enabled (not solved).  I'd like to fulfill requirement that one can
set $cache to any CHI-compatibile or Cache::Cache-compatibile cace and
it should work, but that default custom caching layer should follow
J.H. one (and be fast); that unfortunately makes for more work.

Some of discussion about gitweb output caching can be found in
"[RFD] My thoughts about implementing gitweb output caching" thread
on git mailing list:
  http://thread.gmane.org/gmane.comp.version-control.git/164788

-- 
Jakub Narebski
