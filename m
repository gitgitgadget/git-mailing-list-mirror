From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 28 Mar 2013 09:46:33 -0700
Message-ID: <7vppyjv5ee.fsf@alter.siamese.dyndns.org>
References: <1364446721-13351-1-git-send-email-jkoleszar@google.com>
 <7v38vfy48e.fsf@alter.siamese.dyndns.org>
 <CAAvHm8NAqVHLz1wjNN-3ocpYzWfO-PDo0PAJ6pZO7KrMkhJ6Jw@mail.gmail.com>
 <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:47:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFyi-0000QV-IP
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab3C1Qqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:46:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844Ab3C1Qqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:46:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72FD0AAC0;
	Thu, 28 Mar 2013 12:46:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xXjap1oQU2huD2Ag1IdXsG1+pSs=; b=tX0avB
	zzBgFEpcrWzC3jlLHYN4AMQUSg5uDRRtKwJ7JBmES9F3+oK8LSABBeNvXknccxfw
	8Tm0SH1Q+NX+sBfKouiad4auCu3s3TBG7Bj5TyIctvcaDLeobxrgfLnN26/HS8Cx
	m2dF/Ol/k9hDSstpAkONr0QClBDTS6P/oIByc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u7KwYyzMukeIJKGmRBzjTFRLbnghTNNP
	Z5k/wAp1U/02o2HoXYJMFhP66PsLGLboTq3BP0waiuwK05uynD85I3Uqs2Bl6y5/
	eyUSMfs0a84UouwmkvPMingg2OsBFEg2QGr+S14qWSnRnxudPNT1ggkEiOi0BymV
	++iION2SORA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6828CAABE;
	Thu, 28 Mar 2013 12:46:35 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2071AABC; Thu, 28 Mar 2013
 12:46:34 -0400 (EDT)
In-Reply-To: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com> (John
 Koleszar's message of "Thu, 28 Mar 2013 08:54:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D2EAD6A-97C7-11E2-B47F-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219428>

John Koleszar <jkoleszar@google.com> writes:

>> Facepalm. The intent here is to invert the grep, to make sure that the /ns/
>> does not appear in the output. No idea why I wrote it that way. Will fix.

OK, "! grep /ns/ exp" would do.

Thanks.
