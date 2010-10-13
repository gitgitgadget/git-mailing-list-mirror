From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Hidden refs
Date: Wed, 13 Oct 2010 12:53:39 -0500
Message-ID: <20101013175339.GA8686@burratino>
References: <4CB5CEA3.8020702@xiplink.com>
 <20101013173555.GA13188@sigill.intra.peff.net>
 <7vvd56m1ke.fsf@alter.siamese.dyndns.org>
 <20101013174647.GB13752@sigill.intra.peff.net>
 <7vmxqim167.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65Zj-000442-BJ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab0JMR5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:57:08 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60201 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab0JMR5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:57:07 -0400
Received: by ewy20 with SMTP id 20so2455391ewy.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GV/1XOqpoUc5GYDv0WmqpSOxjfGngO2dkPgKbwKpC2c=;
        b=D9wUsQjMkVUYCXoemSwB8ZpcpZ0HxResbgZve8YN78C4xkzeLPpoLIQ4JN+Izmazp2
         ktQQhYtQ8yNBAOAWoR7oQp4mhCiDH+PPB2j4ut5FY2NnemqJ8Q7jyv02YVuUzGKKkQHa
         jDIDhlFgh2VHB/qIRzE9BCju5GiWFgxPkrtkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jyfsgvaAnRZpyqpX4jf+Uyt8qn1YbuqrvXZV+EJQjlecVtrbHqXdcyjyPolgATPwhE
         C/zJlUT86B3gtQsM3G4DGrQQOad2eqiDjPKcfcA+8onQYXmxEddF6NzL4UjUaw4PQMOe
         k7jDsF/HaqJ0AufrUkhCSYRgOCrx1932XlL3Q=
Received: by 10.213.97.129 with SMTP id l1mr168847ebn.56.1286992625520;
        Wed, 13 Oct 2010 10:57:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x54sm5293062eeh.11.2010.10.13.10.57.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 10:57:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmxqim167.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158955>

Junio C Hamano wrote:
>> On Wed, Oct 13, 2010 at 10:42:41AM -0700, Junio C Hamano wrote:

>>> Is "log foo...bar" a symmetric difference between foo and bar, or is it an
[...]
> Of course, it points at an existing bug as well.  --- the example could
> mean an asymmetric difference from foo. to bar ;-)

Fixed about a year ago, I think. :)  (cbdffe4, check_ref_format():
tighten refname rules, 2009-03-21, part of v1.6.3)
