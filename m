From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Topics currently in the Stalled category
Date: Thu, 22 Nov 2012 18:24:10 +0700
Message-ID: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org> <7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
 <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 19:50:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbbqx-00089K-7F
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 19:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246Ab2KVStZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 13:49:25 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41810 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab2KVStW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:49:22 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8289857oag.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Lb8N9nulIgMIvTIgnZ6uipiqy0yuC8uSooenGVbHfmc=;
        b=B8BFTnp4oC8Mz6ALi4+LT1vfE9ykyO5AJIpar4BpFBzqo+6740MgL25eeaavXuepTo
         OBR4Wj2Dr6VFUjqOO+5UvLhEesqkrBqlEVgeDkUGR9TiaPpK6a2cZhwvtoUC8YjOt0Wt
         +CNEqRxiRmcOHyKLZpXyYdh/xMzTGoxfuAk677eW+HZUYd3AH3erVgGcQ2Jn8fhYA4g2
         c4OWZh36/0MrbeCDhjet/xKMEURZUOX7t1ek2tY52ILDdKLUcMRZS9IrdMclkL9SwGAx
         NSb3LF3WhdcA/lTsUqzGZAoYI42FPNFvJVx9d0lY2jfgb1vSBQftg7QoBPLNRScJGK2F
         BW8A==
Received: by 10.182.177.7 with SMTP id cm7mr191387obc.20.1353583480528; Thu,
 22 Nov 2012 03:24:40 -0800 (PST)
Received: by 10.182.177.98 with HTTP; Thu, 22 Nov 2012 03:24:10 -0800 (PST)
In-Reply-To: <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210185>

On Wed, Nov 21, 2012 at 7:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/unify-appending-of-s-o-b (2012-11-15) 1 commit
>  - Unify appending signoff in format-patch, commit and sequencer
>
>  I am not sure if the logic to refrain from adding a sign-off based
>  on the existing run of sign-offs is done correctly in this change.

I'm not sure what's the right logic here. The original code in
format-patch has exactly one test just to verify that --signoff does
_something_. There's another signoff code in git-am.sh and we should
make sure at least the behavior is consistent. I guess I should start
over by writing new tests to record the current behavior, then fixes
and finally the unification. I think you can drop this for now.
-- 
Duy
