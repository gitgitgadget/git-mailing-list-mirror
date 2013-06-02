From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/11] t3509, t4023, t4114: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Sun, 02 Jun 2013 16:44:49 -0700
Message-ID: <7vk3mckrgu.fsf@alter.siamese.dyndns.org>
References: <cover.1370076477.git.j6t@kdbg.org>
	<984288047a44d58c55009c32a96d92104d7988c6.1370076477.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jun 03 01:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjHxI-00048p-7n
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 01:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab3FBXox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 19:44:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab3FBXov (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 19:44:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9897724F6F;
	Sun,  2 Jun 2013 23:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bRB2Nr0GM0YDbOzshH9YpsMBCCs=; b=uFIVx+LNc0I0BLrdcDVM
	vmdtgqfk0QicuWDWNOrFf0+5452qoP2e/697sZrwcxNLpMF1GzdDgwFMpSQ0BXjR
	+GKlvlL3Rcztg5B5+3T6LARjcdUee2sA6Iy78ID0/V6OS1ahHSPte9JxAHA+lOIP
	bQLXYijIbD5W0czP+h8ve3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wwZXnf9yuaswLZk/4lBsqtB4WCepmYV/ysvr84TlbhF13S
	In/TZBqwXtEoTwisP9xoXghnboX93GEHvB2on8s3LXOcQbhTaK20plG4QcftDwJ6
	xgSZGoPXkXzbQmJ5xNZCexH3pS9STvUp/t8FvLESHnB1TiUm3WxnqkN2kw4j4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F2F124F6E;
	Sun,  2 Jun 2013 23:44:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0603F24F6B;
	Sun,  2 Jun 2013 23:44:50 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AD90FB4-CBDE-11E2-A03D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226196>

Johannes Sixt <j6t@kdbg.org> writes:

> In t4023 and t4114, we have to remove the entries using 'git rm' because
> otherwise the entries that must turn from symbolic links to regular files
> would stay symbolic links in the index. For the same reason, we have to
> use 'git mv' instead of plain 'mv' in t3509.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

I am in general in favor of the direction this one is going.  Thanks
for working on this.
