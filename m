From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Test the Git version string
Date: Tue, 16 Apr 2013 11:12:33 -0700
Message-ID: <7v8v4imjji.fsf@alter.siamese.dyndns.org>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
 <7v8v4k6hp2.fsf@alter.siamese.dyndns.org>
 <79879228B71A45A48A961F5B1880B61F@PhilipOakley>
 <7vli8k4lnj.fsf@alter.siamese.dyndns.org>
 <99AE5E981E2547B6A71A4D77B17167B9@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAMz-0002AG-8N
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab3DPSMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:12:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab3DPSMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:12:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3D0B171C2;
	Tue, 16 Apr 2013 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=92f4lF1BU3wT0irSPtL1qrGU/qg=; b=q6K4Lw
	U5n/Js/q9hKy/RYYBW4O4g816Hy0ouOXWTTmSHOYaK2uMSGlQdZTcH6lAZ5Nox16
	scdIVWtg5I8zfI6So8iWPbOIGMPOq/Pqh+zJT2o4vR65QVuvv1JfWONzMkS8sNof
	TQVl1pFlpivENBRvzLgCCjojL/f11efrPKJ9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I82bO12c0p8hqVnZmcLMean7DQFbFRJ6
	U42SNOX9GPSP3YPer9ywbfEVE0iPJcs8WPDf+I+bNU0bJ+7nthkw95elRGBO3MMh
	fw/H7ke3izH+8Cxt9V6sCMFgxm3Y3oTkbbJU9ChwCgRUoq0vM1V9lpXJfhJWxoC+
	5wJGUITD+BE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8725171C1;
	Tue, 16 Apr 2013 18:12:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D9D7171C0; Tue, 16 Apr
 2013 18:12:35 +0000 (UTC)
In-Reply-To: <99AE5E981E2547B6A71A4D77B17167B9@PhilipOakley> (Philip Oakley's
 message of "Tue, 16 Apr 2013 08:25:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36C9BF94-A6C1-11E2-81C3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221443>

"Philip Oakley" <philipoakley@iee.org> writes:

>> What kind of benefit are you envisioning out of this?
>
> The purpose of tests is to detect mistakes and spot regressions.
>
> A change to the 'git version X.Y.z' string would be a regression, as I
> spotted earlier, as it conflicts with expectations of standard
> programmes such as git-gui.

Sorry, but I do not follow.

A released version says "git version 1.8.2.1".  In a month or so,
I'll have another one that says "git version 1.8.3".  Or I may
decide to bump in preparation for 2.0 and it may identify itself as
"git version 1.9".

Neither of which no existing "program such as git-gui" has ever
seen.

In what way is that a regression?
