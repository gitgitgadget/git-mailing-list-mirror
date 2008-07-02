From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 00:39:24 +0400
Message-ID: <37fcd2780807021339u582f340dq2b2014951d5b7f63@mail.gmail.com>
References: <20080702143519.GA8391@cuci.nl>
	 <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
	 <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com>
	 <20080702181021.GD16235@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 22:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE97p-0006ww-Kj
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 22:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbYGBUj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 16:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYGBUj1
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 16:39:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:53722 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbYGBUj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 16:39:27 -0400
Received: by wf-out-1314.google.com with SMTP id 27so500529wfd.4
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 13:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=W4VbleKuAR979Z9JWlCzEPpDMrVD1W+R1fdvTlPRBRM=;
        b=Dag9IyHBM3TI8xqYnk9C5BvBNBFGWM9t6Pe53QSDlrV4Ia9Unn2BLAjZ7YK7ti4abl
         y2E1fTLr3PWG1F+2n/YDx/5ZMXENCZv+F3gU33z9mtNPFuCYPdzY+FMhGsLRcVTR/5zb
         tl7nlrVA4yGu+7JMUNC6NVz7fMK7iB8Ai9mjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=m6xT8ajOF7UOGNgOvUgKiDVcEoZZBDEQjok3g3c0nw/EHf/6YgLE4wFNct2hiZ71dv
         4Vnc12Gsb4aQ/6Nydu1VxiGfGHush6f/q6cLT6kNCHB92ctgAa+2Qs82sHTH6Dnuqmzo
         VLxuvXYiDeNTwHp00sC1xU0JUE/kFFMC3+kJc=
Received: by 10.142.166.20 with SMTP id o20mr3220290wfe.245.1215031164751;
        Wed, 02 Jul 2008 13:39:24 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Wed, 2 Jul 2008 13:39:24 -0700 (PDT)
In-Reply-To: <20080702181021.GD16235@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87189>

On Wed, Jul 2, 2008 at 10:10 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
>
> In that case, I will stick to extending git fsck to check grafts more
> rigorously and fix git clone to *refrain* from looking at grafts.

Linus suggested that "git-fsck and repacking should just consider
it[grafts] to be an  _additional_ source of parenthood rather than
a _replacement_ source."

http://article.gmane.org/gmane.comp.version-control.git/84686

Dmitry
