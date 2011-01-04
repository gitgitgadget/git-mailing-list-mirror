From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] git-send-email: added support for S/MIME
Date: Tue, 04 Jan 2011 11:22:36 -0800
Message-ID: <7v1v4sfp8j.fsf@alter.siamese.dyndns.org>
References: <1294156930-21367-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roberto Sassu <roberto.sassu@polito.it>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:22:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCT3-00060z-TG
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab1ADTWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:22:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab1ADTWo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:22:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 545093046;
	Tue,  4 Jan 2011 14:23:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PUB2ktbho3g3jHYoa3cUwysORHw=; b=mVwZ1mncwy4IwBfiptUugN/
	dFJj/m2QREpt8hJmfyfLuCaiWdCCnngNMrqRtMQ7H2mwyORR5thZTBJ9LMV/Bu9K
	sWmo9HvHStMJUigJsim1ezYrsj9pOmJ/9tc9FYJW2bBGCAiL9g+zeEEmetrc9U3m
	JZjMOcevLCBOiyH7u2xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Zjnti558xjhie1VNv2JO2ZET5ZvzgLq0qOxFI4V0GJG2hEOl6
	MxsRS+9hOo4nIoVfs92yTJpPnpuV6cRWj5Je2/tNMHV1nIManP9r7arNZTQrrbcn
	B/y8yGX3Um85//1JdEE9nLJSQgLdZAJtoBSSPEGvXPerR32DCrmFAVuRYg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31AC13045;
	Tue,  4 Jan 2011 14:23:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1B5B03044; Tue,  4 Jan 2011
 14:23:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 15A73EDC-1838-11E0-842F-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164513>

Roberto Sassu <roberto.sassu@polito.it> writes:

> ...
> Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>

The patch with so many "if ($sign) do this else do that" is too ugly
beyond words.  I wonder if the surrounding code can be better
restructured.
