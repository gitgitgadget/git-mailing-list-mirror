From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] mergetool--lib: add new merge tool TortoiseMerge
Date: Mon, 6 Apr 2009 02:27:36 -0700
Message-ID: <20090406092736.GA16408@gmail.com>
References: <1238904024-11238-1-git-send-email-davvid@gmail.com> <DB42161D-8B55-4739-B418-D286B280EFF8@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, markus.heidelberg@web.de, charles@hashpling.org,
	git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 11:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lql8q-0001YR-GT
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 11:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbZDFJ1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 05:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbZDFJ1s
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 05:27:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:26358 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbZDFJ1r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 05:27:47 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2118132rvb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3yBO65Il0EwMM0RSCNYQr3M7tejjqj4uiobLUSyfwGw=;
        b=WWYaPj8dXfq7XceNy2bXtSiQPRlIlX8+d2L4k5073mvFAS4PbNfqeiubqmKsBJlagY
         b1NznwwsW5LvNaKDsttUwjaPe0MdvBpmBt0IK35JtrqXWEubBI+SpgEAHxPsaYxoyLfA
         oWEWeqCskqWumEGWYEBPcA30ROuLn8w+U20l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pIRGZcfrI47c1e4aHJ7kryriyXiNrCU7xzLPXr7gfWK2eknNKl84Po0H2WZYGWxjvm
         8ICsROGFDBwofeiXL4+7glGrJCY21ZPh989xDtW+BJQIuP8L+J/q5216ghSDQMOBkErW
         FT4G77YTpOetIfHyo7FM9gpjV/brxUyyG7x7I=
Received: by 10.114.52.13 with SMTP id z13mr2176548waz.150.1239010065424;
        Mon, 06 Apr 2009 02:27:45 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n9sm3823498wag.46.2009.04.06.02.27.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 02:27:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DB42161D-8B55-4739-B418-D286B280EFF8@silverinsanity.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115799>

On  0, Brian Gernhardt <benji@silverinsanity.com> wrote:
>
> On Apr 5, 2009, at 12:00 AM, David Aguilar wrote:
>
>> valid_tool () {
>> 	case "$1" in
>> 	<lots-of-stuff>)
>> 		if test "$1" = "kompare" && ! diff_mode; then
>> 			return 1
>> 		fi
>> +		if test "$1" = "tortoisemerge" && ! merge_mode; then
>> +			return 1
>> +		fi
>> 		;; # happy
>> 	*)
>> 		if test -z "$(get_merge_tool_cmd "$1")"; then
>
> Why is `case "$1"` being followed by two `if test "$1" =`s?
> Wouldn't it be simpler to have separate case arms for them?
> Especially with how long that list is getting...
>
> ~~ Brian

It would.  It wasn't until after the rewrite that I remembered
this email... oh well [PATCH v2 14/14] it is

-- 

	David
