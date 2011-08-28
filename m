From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git fast-import : How to change parent during import?
Date: Sun, 28 Aug 2011 16:23:25 +0100
Message-ID: <20110828162325.5f479ef7@fenix.utopia.dhis.org>
References: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
	<20110308024427.GA21471@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:30:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxhJB-0002Y9-KO
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 17:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab1H1PXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 11:23:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60097 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab1H1PXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 11:23:35 -0400
Received: by wyg24 with SMTP id 24so3509985wyg.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=qwTsSBG6z0W9OktIve5E9Z2HlWCJzRjFj6xWDjzECJA=;
        b=r/zYo7BUecetvKyhduKc5oOXW/xPtuu8r22kIzgop32R6hZ+pPQfdxIegbwD/q5cXK
         pHE7Lm/C3viFQ+RS0EA7jrKYjbIKo0G6BY7US5T8psUwMS3dKVh6knnsSOiroyxnFfqp
         BO1exArTM4xWZ63ECgLZRRqS+6KwdANLuCYtc=
Received: by 10.216.221.83 with SMTP id q61mr335385wep.57.1314545013969;
        Sun, 28 Aug 2011 08:23:33 -0700 (PDT)
Received: from fenix.utopia.dhis.org (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fd4sm2963302wbb.64.2011.08.28.08.23.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 08:23:33 -0700 (PDT)
In-Reply-To: <20110308024427.GA21471@elie>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180277>

On Mon, 7 Mar 2011 20:44:27 -0600
Jonathan Nieder <jrnieder@gmail.com> wrote:

> > Is it possible to change the parent of a commit during fast import?
> > I've tried using "reset" command and making a new commit pointing to a
> > new parent, but in both cases I get a "new tip ... does not contain
> > ..." error message.
> 
> Have you tried "git fast-import --force"?

I know this is an old topic, but I'm looking into this again now. What I'm
now trying to do is to stop using "--force".

Is there a way to manually force fast-import to drop an old commit that the
frontend script decided it was no longer necessary?

Thanks,
-- 
Vitor Antunes
