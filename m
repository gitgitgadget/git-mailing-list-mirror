From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git clone --reference not working
Date: Thu, 17 Nov 2011 15:56:08 +0100
Message-ID: <4EC52088.3030308@alum.mit.edu>
References: <20111116234314.GF3306@redhat.com> <7vobwbpnzr.fsf@alter.siamese.dyndns.org> <4EC4926D.5050004@alum.mit.edu> <7vr517nvi7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrea Arcangeli <aarcange@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 15:56:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR3Nz-0005L9-AG
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 15:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757749Ab1KQO4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 09:56:14 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:43078 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757712Ab1KQO4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 09:56:14 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAHEu8bq021007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 17 Nov 2011 15:56:08 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vr517nvi7.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185599>

On 11/17/2011 06:55 AM, Junio C Hamano wrote:
> As a tentative measure, for tonight's pushout, I am inclined to queue an
> equivalent of this patch on top of both mh/ref-api-2 and mh/ref-api-3
> topic and merge them to 'next' and 'pu'. I'd appreciate if you can double
> check the two merges on master..pu after I push them out in a few hours.

I checked the merges in the following (but didn't run the test suite, as
I assume that you have already done that):

   bc1bbe0..09116a1  master     -> gitster/master
   973592c..ada4ec6  mh/ref-api-2 -> gitster/mh/ref-api-2
   caa8069..37817ba  mh/ref-api-3 -> gitster/mh/ref-api-3
   25e8838..cc76151  next       -> gitster/next
 + 06ad567...b032ac4 pu         -> gitster/pu  (forced update)

They all look fine.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
