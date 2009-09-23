From: Nick Edelen <sirnot@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2009, #05; Wed, 23)
Date: Wed, 23 Sep 2009 22:48:30 +0100
Message-ID: <c77435a80909231448l774ef841iba6e9e01d8239ff3@mail.gmail.com>
References: <7vhbuui1ys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 23:48:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZhU-0000R6-RT
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbZIWVs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2009 17:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbZIWVs1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:48:27 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:58079 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbZIWVs1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2009 17:48:27 -0400
Received: by bwz6 with SMTP id 6so898364bwz.37
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vYVkbA6zz6o93rnBheMKMb7/SsHiCGr29MAiyLJihuU=;
        b=W7dAOJSOu+NbOc/9/GAOdz2g6MqE/5vz86JbOsp1nAz0A7+sCLnqkD7lACT1II41/R
         dW3FQqw2HCWqmeaDCU5e54Rvp//oIiLsJ3514ATj5WPzhbza7jB9554C/1Ue6dXeojdI
         cVHJl5DK6tNm9iNMtWGeNqc1jLbZbLv4qN1yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bA5YrS2GWvI2514xnTv0TJ+C8vIDq10vBOFL4hb2TVMSH2VGP7eXNj1HqoEu/+x+Y2
         tOEE+P9dDmZSWoW7YxgIvkVbg9NMRidAVEXVFnhqwiubPEeqkcSGkcozDfE6ju4ySdrG
         fdeZC+3ACV/ZAR44obeGOevVbP5X3s60xPoRI=
Received: by 10.204.175.80 with SMTP id w16mr2329982bkz.207.1253742510129; 
	Wed, 23 Sep 2009 14:48:30 -0700 (PDT)
In-Reply-To: <7vhbuui1ys.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129009>

> * ne/rev-cache (2009-09-07) 7 commits
> =A0- support for commit grafts, slight change to general mechanism
> =A0- support for path name caching in rev-cache
> =A0- full integration of rev-cache into git, completed test suite
> =A0- administrative functions for rev-cache, start of integration int=
o git
> =A0- support for non-commit object caching in rev-cache
> =A0- basic revision cache system, no integration or features
> =A0- man page and technical discussion for rev-cache
>
> Tonight's 'pu' ships with this and this series seems to break a few
> tests. =A0I didn't debug.

Ack, I see your hesitation now...  Sorry, so many tests are borked on
cygwin I didn't catch it, and I hadn't gotten around to booting into
*nix.  Will fix these soon.

 - Nick
