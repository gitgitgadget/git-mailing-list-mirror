From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: `git prune` doc or implementation defect, or user misunderstanding
Date: Wed, 8 May 2013 12:05:28 -0400
Message-ID: <CAJELnLHjOUj8EO7RYqK9_9q=9Xa=B4HrZDCUd-JvMXOxTm6G3g@mail.gmail.com>
References: <CAJELnLF_oFcoqhRmzWwFne=8D5kwt8izk5fCDqmxPrROnOxh8g@mail.gmail.com>
	<CAJELnLFpOT=V4f-pthDHkGqVWR7zSS=QYgMz35LWTUB9KvKNUQ@mail.gmail.com>
	<518A6434.20300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 08 18:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua6s8-0004oN-16
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 18:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758316Ab3EHQFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 12:05:32 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54949 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab3EHQF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 12:05:29 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1334670pde.9
        for <git@vger.kernel.org>; Wed, 08 May 2013 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=b9TiZz7DkWXKtnD7DIggvQiJm+qEa0xpFLoGBiwFBQU=;
        b=ay0R2gZSR2oKCeeyCCNsxk99x1TQFEcqmkHC7Je/BRagNmnTVJug2KWXXxfl4bEuoK
         rDzX2RnRdtl+kmQm5mWmZYn3LG6u/3xMKTMuTbpbdILauXfbEfl8P8rbM9f7nyxPZ2C0
         dqWTQmf9X4qG2j9qJr0LzzTtqN/hSe4H+/H5coLNq8xnNYynvkDcDqoTzHzigYTKLrb5
         ZgAXSTfIVKZG7joRnQz9WX/PPlzCWBDjX+HfvWP1BRuALZ0stohkXjijouH0g9J+lxrA
         +IgIght2hM9+hb03tna3dcX1koppfFNud6Z4Hr9b8DlsCC5R4JfkH8ItWxQcEJG4PPuu
         1vWA==
X-Received: by 10.68.251.166 with SMTP id zl6mr8566299pbc.4.1368029129000;
 Wed, 08 May 2013 09:05:29 -0700 (PDT)
Received: by 10.68.43.37 with HTTP; Wed, 8 May 2013 09:05:28 -0700 (PDT)
In-Reply-To: <518A6434.20300@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223674>

On Wed, May 8, 2013 at 10:41 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> git gc moves unreachable objects that were packed before to the loose
> object store, from where they can be pruned.

Thanks. That was the piece I was missing. I assumed `git gc` did the opposite.

-- 
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
