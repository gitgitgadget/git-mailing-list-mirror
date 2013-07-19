From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation, git reset: fix typo.
Date: Fri, 19 Jul 2013 10:16:59 -0700
Message-ID: <20130719171659.GY14690@google.com>
References: <CADfnUUKVDmuqt9s05ehrHVBVhtRFahna-r8=2_OpQW7ruUq+ig@mail.gmail.com>
 <1374251184-24095-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, imgx64@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 19:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0EIp-00017z-0u
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 19:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab3GSRRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 13:17:05 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:54946 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3GSRRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 13:17:04 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so4485904pdd.6
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fT2SeIHfD7GPVNM7iTZ7ZsN4+eHXBm5yWlFmBG4AJkw=;
        b=ObdCmqas0FqGQVxbkVjJLivjNpyAKmBx6+7sTZmf5cdo7Lfjy1tUqteOkqzxBhvSBj
         5YpP7N+eRqZ5+xASzbyS/q1608c7Jc6VY0WHPh8wJBUxDlhuUSAEyWwxFRn+b4CrEFCJ
         dSoQD8vh5kEvMFtE2goILD1LWY+T3DsBVrV64XcymWREqZy2xsJlIzxfYnnlndU+RDx4
         lu6GtVh3jY+2HZKvX+mSpXUAfjdFvYO1Gv4TSoJHZvBUjgsP/mpV3upt5qmI2JJR8Qmq
         0IW9k1f6T0HAa6Ij0ZbF1wJM88FVrr/P7UlFLRzv2elWorTrsYbAWM6vW3fEgfJx2Yr9
         mFNQ==
X-Received: by 10.66.192.234 with SMTP id hj10mr18822096pac.183.1374254222908;
        Fri, 19 Jul 2013 10:17:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sq5sm23707204pab.11.2013.07.19.10.17.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 10:17:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374251184-24095-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230830>

Stefan Beller wrote:

> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git reset' [-q] [<tree-ish>] [--] <paths>...
> -'git reset' (--patch | -p) [<tree-sh>] [--] [<paths>...]
> +'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
>  'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]

Sure.  Though these days it might make more sense to say

	'git reset' [--soft | --mixed | --hard | --merge | --keep] <commit> [--]
	'git reset' [<tree>] [--] <path>...
	'git reset' (--patch | -p) [<tree>] [--] [<path>...]

since commands accept a commit or tag where a tree is expected pretty
much universally.

Hope that helps,
Jonathan
