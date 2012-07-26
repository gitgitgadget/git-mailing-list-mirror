From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] git on Mac OS and precomposed unicode
Date: Thu, 26 Jul 2012 16:04:14 -0700
Message-ID: <7vhasu5dld.fsf@alter.siamese.dyndns.org>
References: <201207081550.25850.tboegi@web.de> <5011AD4A.8060901@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 01:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuX6W-0008Nq-RP
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 01:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab2GZXES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 19:04:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764Ab2GZXES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 19:04:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 300168922;
	Thu, 26 Jul 2012 19:04:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eKuowAbQagFsf/d+AZ7Or2lmcqU=; b=ZaclvL
	uVi/y89H/B3SaLNADRPuoaMRwRem9J3KOndL6VYSwCrc9QSWry2VaNY9EfSQTAsn
	R8ojcQ/EGNd0atYEJnvhHA1oZWxRKvEvJwBuylHXVSBrKsU4Gu/LJfvDmRR7GWbY
	sViwkMieP2Kk7R4Dvp2JDRSmovA23dPe3CCcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HN2lZF6jOZwvgbmV1VhI+W79JZTiP1Kf
	mapjiQGgjFbV6K+8gHAZ5+9wWoEFFnImrtLe8T6wI0gKlI17jZm/Y2WPhfELYLn9
	BKMxZn7DDLahIfL2QimMUDjxFhBWFMZmNqIjv+0lS5wwocF5bD0YVw35O3UtFWEp
	oU6Ku2Yiak4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C8EB8921;
	Thu, 26 Jul 2012 19:04:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 407F7891E; Thu, 26 Jul 2012
 19:04:16 -0400 (EDT)
In-Reply-To: <5011AD4A.8060901@dewire.com> (Robin Rosenberg's message of
 "Thu, 26 Jul 2012 22:49:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3925D41E-D776-11E1-8E79-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202312>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Just a couple of nitpicks.

Polishing is always good and better late than never, but for a topic
that has long been graduated to 'master' already, it would be easier
to review and discuss if it came as a patch form relative to the
codebase _after_ the topic has been applied.

Thanks.
