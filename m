From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn - canonicalize: Assertion `*src != '/'' failed.
Date: Mon, 26 Aug 2013 10:28:53 -0700
Message-ID: <20130826172853.GR4110@google.com>
References: <521B8D61.8040608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Development <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0b9-0006r6-9T
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab3HZR27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:28:59 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:38218 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3HZR26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:28:58 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so3693644pbc.2
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9xBIbZAAr9No/9nPRb2V+zMv+1qklaQSbmlhK25Sl1A=;
        b=FaPALpibyx3JEbjwJZPFGC3Es01Ydt9tCRKxnpOj5hykH7RgvgK2jv9oVpSnM3YbZL
         igw0bzKvbxrHqRMbPsnvLJTgc2bFsRhHbwnwFyPZMUK+gGyw2j/GhGqNtiXFeev0TqSE
         +Q9Mg53zppa9TJUWh9wz9IA76ieCEVjarDZkpFy5A4pCuf9U/umScAQdT35tXrrcvhFf
         G0gE/cSFP+s1SHyLsay1qONc8p7a9tLtnQVIUtn+EY62T0VdS/mBe9H/tl/2ZRnmowO4
         Y7kdAk3xeEKaKDRY+Noy52HPRH7XrFCQTamOmJVHrP2jIc7vblxnydlFInFxCwl4BXEd
         rs5g==
X-Received: by 10.66.25.232 with SMTP id f8mr16046989pag.25.1377538137687;
        Mon, 26 Aug 2013 10:28:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id a5sm19262925pbw.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 10:28:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <521B8D61.8040608@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233009>

Hi,

Bruce Korb wrote:

> I was trying to clone a SVN repo, but not having luck:
>
>> $ git svn clone $PWD/private-lustre-svn $PWD/private-lustre-git
>> perl: subversion/libsvn_subr/dirent_uri.c:321: canonicalize: Assertion `*src != '/'' failed.
>> error: git-svn died of signal 6
>
> What is Perl or Subversion or GIT trying to tell me, please?  Thank you!

What version of git are you using?  And what version of libsvn (and the
libsvn perl bindings)?

Thanks,
Jonathan
