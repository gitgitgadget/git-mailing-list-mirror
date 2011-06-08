From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Wed, 8 Jun 2011 14:42:37 +0200
Message-ID: <201106081442.37849.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <201106081312.46377.jnareb@gmail.com> <BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Wed Jun 08 14:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUI61-0006bu-9u
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 14:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab1FHMms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 08:42:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38994 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab1FHMmr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 08:42:47 -0400
Received: by bwz15 with SMTP id 15so378942bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=bu2l781j/TLNh3n1UOzhPY9/oC+fkCWwpufhewkBkRo=;
        b=kiWmC9sdiybfkWcPaYSJPg5pKvf9Rz0OyTs3PHIzbHnR7Ehb86liZJIg+AGnIaL42d
         jRwU+/WAI3AQvZ9YLoe09J8X7G6VHGzN7GucZZZ17atK17P8BriiG1qUKDtO9X00Zh54
         dX6WKcCK7Pf6hElpwU3B/1EBn1fNB7u/C1VP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qzgCjflheZDchZUJ+qAWZ671DFqw57jZgrDn0JzX14MGVvISoD3ZachE2UN01iIyAO
         DKzFT7lHR+3eoZh7IfPIHb2tSw/MEOTMemt5TQv2wYGCaNBljA43xVtvzJ9djf6wbod6
         OlM4OfXsPGz1uzRThUKgoVC6/Ausi6N1CKXec=
Received: by 10.204.57.135 with SMTP id c7mr612595bkh.88.1307536966547;
        Wed, 08 Jun 2011 05:42:46 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl. [83.8.218.41])
        by mx.google.com with ESMTPS id a28sm1087494fak.1.2011.06.08.05.42.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 05:42:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175363>

On Wed, Jun 8, 2011, Michael Nahas wrote:
> On Wed, Jun 8, 2011 at 7:12 AM, Jakub Narebski <jnareb@gmail.com> wrote:

> > I don't quite think that we need "git diff NEXT WTREE"; the short
> > and sweet "git diff" is short for a reason,
> 
> To be clear, I'm not advocating and have never advocated getting rid
> of zero-argument "git diff".  I've advocated that every (whole
> project) diff command should be expressible by a "git diff TREE1
> TREE2".  I'm fine with defaults if one or zero trees are specified.

Those pseudo-almost-refs (almost-tree-ish) are to help new users, isn't it?
But shouldn't new user learn that he/she should use "git diff" to review
his changes, rather than use "git diff NEXT WTREE" to compare staged
contents with working area?

> So "git diff" would default to "git diff NEXT WTREE".

You mean that "git diff NEXT WTREE" output be the same as "git diff",
except for corner cases (merge conflict), isn't it?

-- 
Jakub Narebski
Poland
