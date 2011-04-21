From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 5/5] Date Mode: Tests
Date: Thu, 21 Apr 2011 15:44:41 -0700
Message-ID: <7vd3kfusva.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <bbf61df6-b7fa-429e-866e-899354953cbd-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:44:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD2cI-0005ZF-TC
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 00:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab1DUWou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 18:44:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab1DUWot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 18:44:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E1124C85;
	Thu, 21 Apr 2011 18:46:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2HKcJ8hC8G/VQCkKzS+e+KvppUQ=; b=hd4CjsmNpZDgyAqoYJPc
	zX49k7Lcn8bB+/Be6r/tidxrSKVxpGwY5ytrB60zZsukHqt0dEvdjchcyzUrlmgB
	yROMaynbgd+nDo7/drjQyDGgo+MDoKBKTyilYuqFtnJDqtRF/C1nM1Gq64Ipuoup
	5YkjmzGbf/3yP3SE9BlaXEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bJnFGpb6cW2ZCUJiUzX+8/QKHFlUft28ORSGl8PZjinYNw
	hsf43buYeGkZ/FrdCp2M8tzSEF5GNSh/vORfXUZmEQnZyeIlb++7ayDah7dDWbn7
	yVnVgu3jTvkiUF58jiDy//pNyEk7t7KzlZ4WWmQzaRzd47UUCE98utYuwGfqs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C1F94C84;
	Thu, 21 Apr 2011 18:46:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 417254C82; Thu, 21 Apr 2011
 18:46:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D80DC12-6C69-11E0-B34B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171927>

I'd like to have part of the tests in this patch at the beginning of the
series to document and protect the behaviour of the current --date related
options, then your enhancement that adds --zone that lets the users
specify the timezone and the format independently, and finally the
remainder of this patch as an addition to the test script to document and
protect the interaction between the two options (e.g. what happens when
none or only one is specified? what happens when conflicting options such
as "--date=local --zone=gmt" is given?).

Thanks.
