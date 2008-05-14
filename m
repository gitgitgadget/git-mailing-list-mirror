From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] add push line in git-clone
Date: Wed, 14 May 2008 11:16:00 -0700
Message-ID: <7vhcd0oiov.fsf@gitster.siamese.dyndns.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
 <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
 <7vve1yzgfc.fsf@gitster.siamese.dyndns.org> <482018E4.9000908@gnu.org>
 <482B0354.2060207@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 14 20:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLXB-0000N9-Ao
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156AbYENSQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757150AbYENSQK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:16:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbYENSQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:16:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6988F4303;
	Wed, 14 May 2008 14:16:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9435443F2; Wed, 14 May 2008 14:16:03 -0400 (EDT)
In-Reply-To: <482B0354.2060207@gnu.org> (Paolo Bonzini's message of "Wed, 14
 May 2008 17:20:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D283D6AA-21E1-11DD-863A-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82126>

Paolo Bonzini <bonzini@gnu.org> writes:

> Paolo Bonzini wrote:
>>
>>> Used together with [1/7], this change is Ok in a homogeneous environment,
>>> but it would break people who use git of different vintage on the same
>>> repository (think of a repository on a networked filesystem).  You clone
>>> like this, and older git won't grok the push configuration anymore.
>>>
>>> It may look a very minor point, but I think it deserves mentioning.
>>
>> I think it is reasonable to require cloning with the
>> least-common-denominator version in this case.  Think of what
>> happened if the pack format changed.
>
> Any news on this (and on 1/7, which is in pu)?

I did not personally find that argument convincing, and I thought list
agreed with me with silence ;-).

The pack-format change is a big deal and benefit everybody.  Comparing it
with this change feels like comparing an apple and a poppy seed, doesn't
it?
