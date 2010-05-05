From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re-submitting patches
Date: Wed, 5 May 2010 16:24:37 -0500
Message-ID: <20100505212437.GA26487@progeny.tock>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
 <20100505005153.GC25390@coredump.intra.peff.net>
 <4BE115EF.8010306@viscovery.net>
 <20100505070131.GA11265@coredump.intra.peff.net>
 <19425.9169.537598.876589@winooski.ccs.neu.edu>
 <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
 <19425.54504.163875.379151@winooski.ccs.neu.edu>
 <loom.20100505T225117-534@post.gmane.org>
 <19425.56291.689142.569365@winooski.ccs.neu.edu>
 <19425.56411.745112.753594@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 05 23:24:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9m4m-0006yE-JA
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 23:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172Ab0EEVYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 17:24:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55666 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab0EEVYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 17:24:09 -0400
Received: by gwj19 with SMTP id 19so2464246gwj.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=moU+H1vNUWHlqH12/zRxnzUE+Tj8n25WWtaVyeeXk4U=;
        b=eufwS8MDAHRep0bj8AecGHJMV70xNy61p7VlCc0alqHZU7/6s3AY7PWk37KKxXMA4i
         4G6cXMW5u3g1t8EVY2MIcypdwwcFhfbABXtaPefCeFiUXQRZ8lGkvGcg1workxqAhB93
         ljernFAiBTsij05FP8l5nLHfmwGQq6PuZ4k0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lcEIiMXdM7VosM4O3nrle6D25ZPvzSn2NR4j+99HPh67ezoMOj0sQw+XvXmg0UP4BP
         UsgQJVY8bvLQDgoUX45CSl9vyjuwQFch0reTqHQEffokPt4F0WVhMbzxTOCkoMBKQFBm
         ZdiAdpb6OoB1ilDKSyTZWxKS5l6FWvfUNF3b8=
Received: by 10.101.198.22 with SMTP id a22mr3001217anq.0.1273094647961;
        Wed, 05 May 2010 14:24:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm211606ywh.10.2010.05.05.14.24.06
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 14:24:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19425.56411.745112.753594@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146421>

Hi Eli,

Eli Barzilay wrote:
> On May  5, Eli Barzilay wrote:

>> (*sigh*)  That's correct, I fixed this, but improperly remade the
>> patch.
>
> Is there some convention for sending a fixed patch?

With a small patch like this one, you can just send the fixed patch
as a reply to the thread.  Putting =E2=80=9C[PATCH v2]=E2=80=9D in the =
subject would
make it clear that this is the newer and better version.

With larger patches, doing that too often can overload people.
My preferred solution: describe the changes as soon as you want, but
then take some time to polish them before resubmitting.  This gives
people time to breathe. ;-)

The =E2=80=9Cideal patch flow=E2=80=9D section in Documentation/Submitt=
ingPatches
says:

-------
 (3) Polish, refine, and re-send to the list and the people who
     spend their time to improve your patch.  Go back to step (2).
-------

Maybe this could be clearer.  In particular, sometimes it is not
obvious to people that even the patch submitter can pretend to be a
reviewer and discuss small incremental changes.

Thanks for bringing it up,
Jonathan
