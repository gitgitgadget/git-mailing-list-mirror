From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Does anyone have any benchmarks against CVS?
Date: Tue, 12 Jun 2007 09:54:50 +1200
Message-ID: <46a038f90706111454i5f4898b5kd77d18f4a893904e@mail.gmail.com>
References: <20070611090451.26209.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "linux@horizon.com" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:54:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxrql-0001Ua-9a
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 23:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbXFKVyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 17:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbXFKVyz
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 17:54:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:13188 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036AbXFKVyw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 17:54:52 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1590934wxc
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 14:54:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SUhg+1ZkyvlCi2dijeD3VLngPtndZ7djKJBTEVBwwvfOTZnfGAg1HJh+PUD+CepNi0ZMEoVypCK2EQbATdgAwVLnGx23NSiXFG983XhPnhPubXv5xInNcrUe3E9Aw4Nc4WjaBKQxags5CCA4fFcITAeV1jPT6x/dR29OcBaHD2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=APOTPmMd3l7hE0xKXLs3NWKMqXyPVPdsA2d/T28MHGnMEA7ANDhBZKRmV5yfao4Z2BgKHrDAb9CQST/DkF24K7dm7QnChGrYr7X0Ryjbh+4r0t4cV0heeD+oAHxd2umMBiH935Shy/i0eBdaPzI4pyTERzWGAb21rKeWM1x3OkE=
Received: by 10.90.52.18 with SMTP id z18mr5946076agz.1181598890849;
        Mon, 11 Jun 2007 14:54:50 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Mon, 11 Jun 2007 14:54:50 -0700 (PDT)
In-Reply-To: <20070611090451.26209.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49891>

On 11 Jun 2007 05:04:51 -0400, linux@horizon.com <linux@horizon.com> wrote:
> It seems to be common knowledge that git is a heck of a lot faster than
> CVS at most operations, but I'd like to do a little evangelizing and
> I can't seem to find a benchmark to support that claim.

It _will_ be a bit of an apple-to-oranges comparison, but you could
use a few large-ish projects that have a published GIT gateway.
Measure time and bw use of

   - cvs co vs git clone
   - cvs status vs git status
   - cvs update vs git pull
   - cvs log (at top level) vs git log
   - cvs log path/to/file vs git log path/to/file

I would suggest

 - Moodle (for which I maintain an http-fetchable repo at
http://git.catalyst.net.nz/git/moodler2.git )
 - PostgreSQL (repo.or.cz hosts a repo)

cheers


m
