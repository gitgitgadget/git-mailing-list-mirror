From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4: Small updates to test cases
Date: Thu, 26 Mar 2015 18:45:41 -0700
Message-ID: <xmqqpp7vw6uy.fsf@gitster.dls.corp.google.com>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
	<xmqqwq23w7qx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 02:45:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbJLJ-0006FU-4J
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 02:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbbC0Bpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 21:45:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753061AbbC0Bpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 21:45:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FA1C434F3;
	Thu, 26 Mar 2015 21:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xIFlBH1P1hfS2FrmODfIgMe7XU4=; b=qyjr7o
	H5vaGbqxH7ptQCUdvwMDY7Bw1OuVgVA+L3+KpCrgQEgxoE8Q9DAULJ6p1YwlxHSx
	b5UjT58OAOQCCV8nk+RdkZLQj59vxrHcK7giGHPn33X2WbOFCr8xfHUn1fa3eLMX
	XJPR6MgQXzVK4cTJmk45cuCafOiyvOx8hfTQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KfWytn8axWz+DMU7T8l8G43q36QlsakI
	ohDXFAawDtMGS1vSDAO9VCuX/AB6H00/HvQxtzM3R2pLnpfcETBHztBu2P5H8C+W
	KdbKMnoTPQ6nQC/JETrne+ltC76zGOLBrvUNuAs0RNhXQm+i1qdIPyMIwcS+AGaN
	UeDlZtA8uqo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 90CC1434F1;
	Thu, 26 Mar 2015 21:45:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DB4A434F0;
	Thu, 26 Mar 2015 21:45:42 -0400 (EDT)
In-Reply-To: <xmqqwq23w7qx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Mar 2015 18:26:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FADC6D24-D422-11E4-81A3-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266362>

Junio C Hamano <gitster@pobox.com> writes:

> As to 1/2 the lack of esac is clearly a bug---any self respecting
> POSIX shell should have executed it without complaining.  But

s/should/shouldn't/; sorry for a noise.
