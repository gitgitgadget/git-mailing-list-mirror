From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to generate pull-request with info of signed tag
Date: Fri, 16 Dec 2011 08:22:24 -0800
Message-ID: <7vmxasjxkv.fsf@alter.siamese.dyndns.org>
References: <874nx1korf.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 17:22:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbaYK-00035E-1B
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 17:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759419Ab1LPQW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 11:22:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756517Ab1LPQW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 11:22:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EEC96867;
	Fri, 16 Dec 2011 11:22:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xVk5vLfhcXULxJPA4wUpiors6WY=; b=ETngwz
	bVlx/29eZKWTKnMdblNpDCAidcLwGBpEFjF/dpY7Bg9M8t10AVaquvNUjg309sV3
	zc7AUkDzhfKf20lHuDIYug8qeraNzsvB7oqHPiGVc4uxnEvZuw4IZfb6d0jQazUM
	Ueu0mWbb/xBg3zgWqUMoXek+NcOpvta6wRrTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9iLeLKY2o+HAoELjRrhF1Z9Jfj3SB0e
	uc/QERiW+ZE/Pt0eyjPx28UWJ/aReWBHMG/kMp0bNlllOY09Z20KdEufLMmO08DD
	dXBqMJ7YRRtCH2ouc9+XnkkwJp1VJJ0Oc1SONWhmV4S63ZQezG0BeVOMsuHC5xVR
	xKIpGt6ePs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 050006866;
	Fri, 16 Dec 2011 11:22:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76C9D6865; Fri, 16 Dec 2011
 11:22:25 -0500 (EST)
In-Reply-To: <874nx1korf.fsf@linux.vnet.ibm.com> (Aneesh Kumar K. V.'s
 message of "Fri, 16 Dec 2011 12:05:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23E341DC-2802-11E1-A269-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187285>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> I am using git from master branch and wanted to try the signed pull
> request. I have pushed the signed tag to repo.or.cz, but not sure how to
> generate pull request with signed tag information ? git-pull-request
> insist on a branch on the server and put the branch details in the
> pull-request text, It do add tag description but not the tag name and
> still put "repo-name branch" name in the txt. Shouldn't that be
> "repo-name tag-name" so that one can cut-paste that in pull request ?

Yeah, you are right.
