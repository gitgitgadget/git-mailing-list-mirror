From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk: Failure of new tabbed preferences dialog
Date: Tue, 03 Apr 2012 09:53:29 -0700
Message-ID: <7vaa2sdaeu.fsf@alter.siamese.dyndns.org>
References: <4F749C71.7050201@ramsay1.demon.co.uk>
 <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
 <7vty12gl8r.fsf@alter.siamese.dyndns.org>
 <20120403121944.GC24141@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 18:53:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF6zB-00048e-KO
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 18:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab2DCQxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 12:53:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34905 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846Ab2DCQxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 12:53:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6295D6A1B;
	Tue,  3 Apr 2012 12:53:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rPPMcMHRc5hluW7WH5Mc3GFeFz0=; b=dAGYoj
	2Gpdy/3k5D7LqSZzSfclqu+o4zEDpMmkH4GEajuTpvDqVE24nYR6ZwIG4FUJBYNd
	pm+5GclJStCvQ6x1LaK3/gBWf/n2w0DqbFRHKNTWmoCCV9u8M9xLcfozUFsMw6pl
	JTTf/dtTmXZy588+ipNrAeytV90SxeWzBdXhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=whFrsqR1kcPY57Q3QEw+VBno2PVr517h
	kVQtpamOt3Ui4KLVM/+035mzvhp0WXAxBqjtgfHcAeBbgCRVorVSoiE0oq0VGKwL
	ky03ansbJ9fpfti7Q/Hwpg+mPoUHJd+FQs/H5PvEiI8shn4lmF1B5ysO29SYS3NX
	jBUtfuwvvco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A4986A1A;
	Tue,  3 Apr 2012 12:53:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4EA96A17; Tue,  3 Apr 2012
 12:53:30 -0400 (EDT)
In-Reply-To: <20120403121944.GC24141@bloggs.ozlabs.ibm.com> (Paul Mackerras's
 message of "Tue, 3 Apr 2012 22:19:45 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ACF8896-7DAD-11E1-A452-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194631>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Apr 02, 2012 at 09:19:00AM -0700, Junio C Hamano wrote:
>> 
>> This seems severe enough that we should put it in the coming release.
>> I can queue them directory to gitk tree (and later ask Paul to pull it
>> from me), and merge the result to expedite the roundtrip.
>
> OK; the patches look fine to me.  If that's what you're doing, I won't
> apply them to my tree, to avoid duplication.

Thanks.
