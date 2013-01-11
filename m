From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2013, #04; Wed, 9)
Date: Fri, 11 Jan 2013 19:56:10 +0700
Message-ID: <CACsJy8CZ9YuzRW6-dh6293EQJAhCDL9wsMdb=NSxMRq060wPbA@mail.gmail.com>
References: <7vmwwi3w5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 13:57:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TteAP-0004t7-4y
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 13:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab3AKM4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 07:56:41 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:43143 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab3AKM4l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 07:56:41 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so1721578oag.37
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 04:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=km0MT3kUR7ncj6FcDRE/fk/3vQKprHjEHeBcyFL9QKY=;
        b=RGdfn9wCCp17k/0AC5S/Az9NoYfDerCIQqBYMKDOm5dPOWfu+STEnG/ezEUfgdBRvc
         MWp0L9KPir2CkYlBUgSbHqz65LJw3pedOllzhOUTtXMif/3l8U79SX4rdpBgimpc9RR6
         rEIHC7zF6YY+p1yxgKNyvDjwEJ+4/ckHrjRa3jmko01t/KVyq3eBDHAjUMlzN0+pWVIj
         k5hiyLPXKyLQsI++KKREEcm5CP7o6tbOgpzt0z9/PtmOtzL2Zy9ZACqnJAR5YDiv14KV
         Ivqw5gpIT9ElbXhRfZLthhVi7hXq/iC6bRu6XoWNBL2yWJOYQ9g5a2LGAmCIAQ3DLBJp
         0kkA==
Received: by 10.182.159.33 with SMTP id wz1mr47824116obb.57.1357909000620;
 Fri, 11 Jan 2013 04:56:40 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 11 Jan 2013 04:56:10 -0800 (PST)
In-Reply-To: <7vmwwi3w5r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213216>

On Thu, Jan 10, 2013 at 4:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.

I see you start to use no-change commits as a way to keep notes in
'pu'. Isn't git notes designed for that? Just wanted to understand why
you chose that way and maybe we could improve git-notes a bit to fit
this purpose.
-- 
Duy
