From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: removing very old commits (including initial)
Date: Wed, 28 Jul 2010 09:10:19 +0000
Message-ID: <AANLkTikyN1yHEj+jS0JRbjO+uX4mo0sfQs13_YfTD13_@mail.gmail.com>
References: <20100728115309.08ed6fdd@packard.rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Wed Jul 28 11:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe2el-00059V-MK
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 11:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab0G1JK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 05:10:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37154 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab0G1JKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 05:10:25 -0400
Received: by iwn7 with SMTP id 7so4642070iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=m9fAyHjwXnIOeofAnkd1/v4eLQqYwbNy9pqNRLxJF6g=;
        b=Xfi0AoS7kSZlS8UuIDcCqRXtqVL8zGyvaG28P/swVQs8+lh0XQlWec3EpvxpzpKpva
         Xklzduq2RfMjV63S74UqLGSch1kvl6Z2v7hMwbuzpFHSEA/ojC+B+Qn8/mbN6j3GTWMU
         3FVQwFRzB48QizodVuBue8nvf7FurjqE9I1Po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=k+p2FkpuLhWSyCNe0D/PFM8hVxZ94fLpRh9pDXqu9BKXzjl6fxl3/WvsAolHx2IMh8
         2+sYCRyMy+liqO6qTREYMrn0oM3y24PhXnSlSgIwoJkV/kNy6EbiFU+Oc1uw9Uj9VdVn
         4x+gr3xD+izqb2Z9hbEhk9UwC9aNbpo7SL2OA=
Received: by 10.231.39.69 with SMTP id f5mr11753006ibe.53.1280308219310; Wed, 
	28 Jul 2010 02:10:19 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 02:10:19 -0700 (PDT)
In-Reply-To: <20100728115309.08ed6fdd@packard.rktmb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152060>

On Wed, Jul 28, 2010 at 08:53, Mihamina Rakotomandimby
<mihamina@gulfsat.mg> wrote:

> It's not a problem to definitely wipe the "single file" part of history
> of this project, but interesting to keep the history after the
> split&untracking.

git-filter-branch(1) will do everything you need.
