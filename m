From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc4
Date: Wed, 21 May 2014 12:02:45 +0200
Message-ID: <20140521100245.GB2201@mule>
References: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 12:02:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3MQ-0006SF-5l
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbaEUKCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:02:54 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:39736 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaEUKCv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:02:51 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so1264279pbc.16
        for <git@vger.kernel.org>; Wed, 21 May 2014 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c0s7J3xXPzG9rnDNdHWObhaY1HIpF55TU/eIKd6yb4s=;
        b=wEJFmQD7FJIzLZdfe84gh9/bnmo5r++AfpvGLcJKJRTrhyhr6mmW9DdtufP2DTpnFy
         9WSreRMF2iFM8FXSweMZktRZ4JWF/Iq7LbBhsf1/mY1VBe2npmiXfLguCI0yBH6jwOSu
         jcMpLVizPrQw4Y/ZOcUBexe+KZVDHeLKjQs1FSuLGAefw1+VHXPG5/OOuhEVbJsom2jR
         PBJvkwrZ/q1YXPqak4Js/MpuO8Uvj8StYL/LmlxkeWK1F6Gd+lIuvN+4QMaabkTjhv27
         3rXVfL8LSZ2RErNqwZpT6yTixSDYDN5YpkRkY4rL6lS5QAzcCSIYEso/TOnml3ZWB5zX
         efMQ==
X-Received: by 10.68.162.34 with SMTP id xx2mr56978246pbb.120.1400666571070;
        Wed, 21 May 2014 03:02:51 -0700 (PDT)
Received: from mule (mail.aacmicrotec.com. [194.150.18.17])
        by mx.google.com with ESMTPSA id cj1sm102886050pac.40.2014.05.21.03.02.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 03:02:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249779>

On Tue, May 20, 2014 at 05:24:50PM -0700, Junio C Hamano wrote:
(...)
>  * "git reset" learned the "-N" option, which does not reset the index
>    fully for paths the index knows about but the tree-ish the command
>    resets to does not (these paths are kept as intend-to-add entries).

I find it quite hard to parse this sentance. Maybe something like:

    which keeps paths as intent-to-add entries if they are currently
    staged, but not present in the tree-ish being reset to.

would be clearer (I hope I've actually managed to understand it..)?

(...)
>  * Commands that take pathspecs on the command line misbehaved when
>    the pathspec is given as an absolute pathname (which is a
>    practice not particularly encouraged) that points at a symbolic
>    link in the working tree.
>    (merge later 655ee9e mw/symlinks to maint.)

In order to include the latest cleanup to this patchset:
"setup: fix windows path buffer over-stepping"
this should be 6127ff6 instead. Sorry if it's unneeded to note, but just
wanted to make sure :)

--
Martin Erik Werner <martinerikwerner@gmail.com>
