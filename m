From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Thu, 05 Mar 2009 08:17:28 +0100
Organization: private
Message-ID: <86prgwqvzr.fsf@broadpark.no>
References: <cover.1236187259.git.barvik@broadpark.no>
 <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no>
 <7vk5744x87.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 08:19:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf7rD-0006IX-VO
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 08:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbZCEHRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 02:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbZCEHRd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 02:17:33 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:33962 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbZCEHRc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 02:17:32 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KG000HFLUX4AY70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 05 Mar 2009 08:17:28 +0100 (CET)
Received: from localhost ([80.202.166.182]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KG00074HUX40H00@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 05 Mar 2009 08:17:28 +0100 (CET)
In-reply-to: <7vk5744x87.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112258>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>> Change the source code such that when USE_NSEC is not defined,
>> possible nanosecond timestamps will still be saved in the index file,
>> but not used inside if-test's, and will therefore not affect the
>> outcome of GIT commands, other than the saved nanosecond timestamps in
>> the index file.
>>
>> This will make it easier to use a system with 2 versions of GIT, one
>> with and one without USE_NSEC defined.
>
> I take it that you are responding to my earlier question with this
> patch?

  Yes, you are correct.

 [....]
>     How does this affect a use case where the same index file used with two 
>     instances of git (one compiled with and another without USE_NSEC)?

  If both persons in this use case use this patch, the one with USE_NSEC
  defined will now be able to take full advantage of the nanosecond
  timestamps at all times.

  The one without USE_NSEC defined should not be able to tell the
  difference (without looking into to details of the index file).

  -- kjetil
