From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2013, #05; Fri, 11)
Date: Sat, 12 Jan 2013 23:25:45 +0700
Message-ID: <CACsJy8CRbkLAD7LtoE_6FA_zW4YTW6Nb0mJU3ejqbu5URTrU1Q@mail.gmail.com>
References: <7vip739su3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu3vc-0003kK-1T
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 17:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab3ALQ0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 11:26:17 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:37510 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab3ALQ0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 11:26:16 -0500
Received: by mail-ob0-f178.google.com with SMTP id eh20so2648644obb.23
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J9QoIQ9awyWfau6u9lT6xnkHC6ASOPvWbodN1SZB1fM=;
        b=uy2vDBwIR5FAKUxQea6gIdmAub0WV047bSStW2TLKFSzXce9Ioh73KpybHt+dgUj7D
         AQGMf+h+X2kh60uFhLm3moH7PeCo6udCWaiRctNslzH1nO9vSrMlQ6IBwM7VLxlys5Q9
         1w6abgQumI7PWci06VVDelpHMcNENBjoVJTIIPKA3i0wjVRTG8rqh1ZicJprnCVGHl2o
         CVlMAgGn6TWdEtK6yUPXJUu3rQVlylwZ+P/gVr6BJAQMINHpxnyLYCL6QHNzxQmSg141
         eHemkXN2x2A/lvIh9nShr2y5Xp+w3+4KnUlcM//BWy7TB/eEYjYiN/ZYzI9PoEVEAWas
         vvVg==
Received: by 10.60.8.134 with SMTP id r6mr46633081oea.53.1358007975275; Sat,
 12 Jan 2013 08:26:15 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sat, 12 Jan 2013 08:25:45 -0800 (PST)
In-Reply-To: <7vip739su3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213295>

On Sat, Jan 12, 2013 at 6:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/parse-pathspec (2013-01-11) 20 commits
>
>  Uses the parsed pathspec structure in more places where we used to
>  use the raw "array of strings" pathspec.
>
>  Unfortunately, this conflicts a couple of topics in flight. I tried
>  to be careful while resolving conflicts, though.

parse_pathspec has not picked up init_pathspec changes from
jk/pathspec-literal and nd/pathspec-wildcard (already in master) so
--literal-pathspecs is probably broken in 'pu' after a lot of
init_pathspec -> parse_pathspec conversion.
-- 
Duy
