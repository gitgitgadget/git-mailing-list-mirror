From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Thu, 20 Mar 2014 18:08:12 +0100
Message-ID: <87lhw4er2b.fsf@fencepost.gnu.org>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
	<xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
	<87ob11g9st.fsf@fencepost.gnu.org>
	<xmqqlhw5260l.fsf@gitster.dls.corp.google.com>
	<CACsJy8C3=bz1HmVgQuJRdixMhhb-JKouM7b1L7M047L_4PBViA@mail.gmail.com>
	<xmqqsiqcztu8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 22:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQkVF-0001PK-UK
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 22:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760237AbaCTV1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 17:27:46 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:60923 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759758AbaCTV1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 17:27:43 -0400
Received: from localhost ([127.0.0.1]:59962 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WQkV4-0006MD-Iz; Thu, 20 Mar 2014 17:27:42 -0400
Received: by lola (Postfix, from userid 1000)
	id 64B0EE08C8; Thu, 20 Mar 2014 18:08:12 +0100 (CET)
In-Reply-To: <xmqqsiqcztu8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 20 Mar 2014 10:02:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244587>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> The only
>> downside I see is large blobs will be packed  undeltified, which could
>> increase pack size if you have lots of them.
>
> I think that is something that can be tweaked, unless the user tells
> us otherwise via command line override, when running the improved
> "gc --aggressive" ;-)

deltaBaseCacheLimit is used for unpacking, not for packing.

-- 
David Kastrup
