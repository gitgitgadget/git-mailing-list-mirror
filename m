From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2011, #02; Mon, 8)
Date: Wed, 10 Aug 2011 14:20:38 -0700
Message-ID: <7vk4alrmjd.fsf@alter.siamese.dyndns.org>
References: <7v8vr3v7az.fsf@alter.siamese.dyndns.org>
 <m3ty9p1oaa.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 23:20:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrGCl-0006YB-MH
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 23:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017Ab1HJVUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 17:20:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011Ab1HJVUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 17:20:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 142384CD5;
	Wed, 10 Aug 2011 17:20:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F78d1DlKwODOndAnbop2hPe/YsQ=; b=SS4h9Y
	yGCVFgLySzA4DkNMd3VgTm/fttH6hDyMKXdkOxBo39EYmbolnRHC+rmwlyJ2cZUD
	DT8sBuais4jTlwwXEm/lES82+6EhANqH2ciCKyNo0bJm4I9Ejl+zVVqRyywtmRvN
	JZynVONcaEblp4lNgqqLGKPGUka4cql4uFOo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSxunT4vhPVoeoEGeaqxz4S9je4QO227
	EJSV+AK8waOwcTaFzI/yaP/ScVIVE7gwMGQUOOVdRFolxlVotwF1NPJkiN1Y/mRU
	xumh5aZMRpTnpsbIt7GF7X394CZUC/eGtEH9n1k6CMLaPbL5SOcXcO8vVWDVEiEz
	Ljbai7nF0Xc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B5264CD4;
	Wed, 10 Aug 2011 17:20:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9457C4CD3; Wed, 10 Aug 2011
 17:20:40 -0400 (EDT)
In-Reply-To: <m3ty9p1oaa.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed, 10 Aug 2011 04:48:10 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9956103C-C396-11E0-B6E6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179077>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> --------------------------------------------------
>> [Graduated to "master"]
>
>> * jn/gitweb-config-list-case (2011-07-31) 1 commit
>>   (merged to 'next' on 2011-08-01 at 9268738)
>>  + gitweb: Git config keys are case insensitive, make config search too
>> 
>> * jn/gitweb-system-config (2011-07-24) 1 commit
>>   (merged to 'next' on 2011-08-01 at 4941e45)
>>  + gitweb: Introduce common system-wide settings for convenience
>
> What happened with "[PATCH/RFC 0/6] gitweb: Improve project search"
> series from 29.07.2011?

I dunno--you tell me ;-)

You solicited for comments, presumably you collected them and have been
preparing a re-roll based on the comments? Or perhaps nobody was
interested in these changes and you dropped it?
