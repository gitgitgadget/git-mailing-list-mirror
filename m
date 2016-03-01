From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv21 00/10] Expose submodule parallelism to the user
Date: Tue, 01 Mar 2016 14:36:10 -0800
Message-ID: <xmqqziuh6d2d.fsf@gitster.mtv.corp.google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:36:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aastv-00051w-V5
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 23:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbcCAWgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 17:36:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751025AbcCAWgN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 17:36:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC6D149DFC;
	Tue,  1 Mar 2016 17:36:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U/o7AMT/gMRV14dAwQlZu7QMplw=; b=dX0Y1H
	LOCeU1Yh/ZRiTod/UpZ9LRikJf0swaACtZVhhi8zpgz6Xm89ZNi7oaNAQVranFHk
	NMGJSHOUxxZVwzYNHeFd4BOkZzJ1jou/GoMiJH1VTO318JMlzu+jLFigWQ20IMkK
	HkIoIt0aLlkLn4Hsd8fnqoJEZ/3aAwqAiWCuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qJiK6o0jglkb/NoGamGgOsAJaEuKqTjg
	HPRt3t3My/IljMVEia/Ixtc1syy2vm5Xi+WY2HhJI2BsO/hzDre5bqdP9CMtf5j2
	M7IdU1XfmRslaT0mzdGbHCaaMB+z3bbqQ2w2eXzuhT+P2qfGzZoJsyJF5QjdvFo5
	K02adlOBDyY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A417149DFB;
	Tue,  1 Mar 2016 17:36:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 08BDC49DF3;
	Tue,  1 Mar 2016 17:36:12 -0500 (EST)
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 29 Feb 2016 18:07:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 001C9DC6-DFFE-11E5-B212-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288072>

Stefan Beller <sbeller@google.com> writes:

> * evicted patches:
>   run-command: expose default_{start_failure, task_finished}
>   run_processes_parallel: correctly terminate callbacks with an LF
> * rebased on top of origin/sb/no-child-process-access-in-run-parallel-callbacks
> * followed Jonathans advice on improving the situation for translators.

Queued on top of the fix to parallel-fetch topic, and the
two patches for submodule-init rebased on top of it.

Thanks.
