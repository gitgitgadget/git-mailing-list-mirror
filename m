From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Fri, 27 Nov 2009 08:45:53 -0600
Message-ID: <20091127144553.GA24366@progeny.tock>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
 <20091127065904.GE20844@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 15:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE1tT-0004UQ-Ks
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 15:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbZK0Odo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 09:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbZK0Odo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 09:33:44 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:57048 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZK0Odn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 09:33:43 -0500
Received: by gxk4 with SMTP id 4so3272459gxk.8
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=indOzlnUYgiIc8mU7B+QnMFdoUMkRUjleaT+ew7CruI=;
        b=Pp51uOPFHlDfxfs30I6SNURrvvRF2iPpWs6PH+Cq+RR/SJWs72JbjDNv2UNWpM+Aq2
         MU29PDSd1B07MmnVRg4ZnxWZG8uOKhT3hs8up1mCdmXQcVbcGORV7TwLv5HfbQO7g0L+
         xdBwnct6jtEMvSe6DPRLhRg0CYhvM+RPrmmS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cQ4WCs28H6iyHyHtzpJAco9/skWvOeEGZ3KIY0+wpGkASsch8ActWd1pAktMUhCJQA
         VdNodTqhmZnSl4MBcv+MsTbl5FMJIno9YCdky3gkNRdCNcFvArwAtBz4qX9enwAUbYrD
         58dfCaVTq+mEPMl0pid+3JbrQkE+zFC2LBr+Q=
Received: by 10.150.33.5 with SMTP id g5mr1797193ybg.132.1259332430029;
        Fri, 27 Nov 2009 06:33:50 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm686964gxk.12.2009.11.27.06.33.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 06:33:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091127065904.GE20844@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133896>

Jeff King wrote:
> On Wed, Nov 25, 2009 at 05:03:33PM -0800, Junio C Hamano wrote:

>> * jc/grep-full-tree (2009-11-24) 1 commit.
>>  - grep: --full-tree
>>=20
>> We probably would want test, doc and a configuration variable to mak=
e it
>> default (or non-default) before we can merge it to 'master'.
>
> I can try to pick this up. But did we reach a decision on having a
> configuration variable?

I am not sure, but I will say I would prefer not to have one.  Surely
we can come up with a UI that does not require searching through
git-config(1) to be made convenient.

Couldn=E2=80=99t we just add the option (with test and documentation) f=
irst,
to get some experience with how we end up using the two forms? =20

If --full-tree does become the default, I think it should be in 1.7.0,
when it is expected for some habits to break (with a configuration
variable for the transition, I guess).  This might be okay, since
constructions like 'git grep foo -- "./*.h"' should still work.
