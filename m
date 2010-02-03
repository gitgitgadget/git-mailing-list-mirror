From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Odd error when doing "clone && cd && checkout -b"
Date: Wed, 3 Feb 2010 05:25:58 -0800
Message-ID: <20100203132558.GA4595@vfb-9.home>
References: <20100203070016.GA18089@vfb-9.home>
 <4B692863.9000409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 14:26:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcfFC-0004Um-79
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 14:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243Ab0BCN0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 08:26:05 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:59771 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685Ab0BCN0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 08:26:03 -0500
Received: by pzk28 with SMTP id 28so1339921pzk.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 05:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:received:user-agent;
        bh=+HBWXIuA4x3KLM8oj1yJpOfRXYyhgxNCxauxBQ/DqYk=;
        b=D6dTZ5mQnOO9YU0XEhdwQ9PWnXQa3D1Kaj+SwdwdKMlJzqffIGEm5dzdmPxDitKegl
         QvNQHjlnL9RVjmfl95AQoBEGRTHrhzrVR4tgrbHL/Yj/+RiIPihjgv7oiw7/dWbVTXJQ
         9o/VKayl07j8fjFo/EsxeQqpS3uD8BgCs3wmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n1ZvIYPpDMrAZFV7SWTKEyLlidRieQexaQymjzX9AUW/u19O/rIm3sPfJ3GPLlu/4A
         KSG4wOnu3SafSR53aEyGl4IPeShMz8tjDzvQWrng5fU/9bd7yBWQeqOKmrtsupiSL74G
         rMqmVgX82rX3tItk+YlG86OM0j0hHFcIVTuEg=
Received: by 10.142.9.37 with SMTP id 37mr1483544wfi.101.1265203561198;
        Wed, 03 Feb 2010 05:26:01 -0800 (PST)
Received: from vfb-9.home ([96.225.220.117])
        by mx.google.com with ESMTPS id 23sm6475342pzk.12.2010.02.03.05.26.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 05:26:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B692863.9000409@viscovery.net>
Received: by 10.141.34.12 with HTTP; Wed, 3 Feb 2010 05:24:32 -0800 (PST)
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138833>

On Tue, Feb 2, 2010 at 23:40, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Jacob Helwig schrieb:
>> vfb-9 ~/tmp % git clone git://github.com/rich97/CakeCMP.git && cd CakeCMP && git checkout -b permissions-rewrite origin/permissions-rewrite
>> Initialized empty shared Git repository in /home/jhe/tmp/CakeCMP/.git/
>> remote: Counting objects: 1508, done.
>> remote: Compressing objects: 100% (1432/1432), done.
>> remote: Total 1508 (delta 256), reused 1235 (delta 60)
>> Receiving objects: 100% (1508/1508), 844.43 KiB | 104 KiB/s, done.
>> Resolving deltas: 100% (256/256), done.
>> fatal: git checkout: updating paths is incompatible with switching branches.
>> Did you intend to checkout 'origin/permissions-rewrite' which can not be resolved as commit?
>
> Or did you intend to track 'origin/permission-rewrite' instead ;-)
>
> -- Hannes
>
> PS: Please don't set Mail-Followup-To for this list.
>

Well, I _thought_ I had used the exact same command for the "checkout
-b".  Obviously, this is not the case.  Bah.  That's what I get for
trying to do anything so late.

Apparently Mutt defaults to setting the Mail-Followup-To, if you've let
it know about a list.  Anyway...that's been fixed.

-Jacob
