From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about installing git from source
Date: Tue, 23 Dec 2014 09:43:47 -0800
Message-ID: <xmqq1tnq45yk.fsf@gitster.dls.corp.google.com>
References: <CANCZXo42SdM8hMdTFYgvD8D+RmXua1oJvB+FfTjjfR=yWqhmkg@mail.gmail.com>
	<xmqqioh247th.fsf@gitster.dls.corp.google.com>
	<CANCZXo4daZffQ7binFpHBy9adKKeuwHuR5VRixXUowMdgAdhTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:43:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3TUx-0001i9-Rv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbaLWRnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:43:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751513AbaLWRnv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:43:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ACF528D8E;
	Tue, 23 Dec 2014 12:43:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fXTE9HTlVMfQi2VqkA7d7funMSo=; b=UZPQvZ
	Fc85EkxxHY0nfW10fiD0jSaTEkVZNwQ2H0+hOLxATtII4Wp8JdgAJXSHU3X2Vl7o
	dsGp9gzw388IDKjS4RcwCZgeBGxu/0JIpm5EvJs2gYf7Jxk72I7v0DVWXYkpe4a9
	PEmhh+5Zu7PAnEeiZwVPacBZAX62gkjgu/HqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Skxs+caVii+ZSbDKelSum3KDZavLvT4s
	O9MXwzVRHqtH8X3/wcMxuMDHqnIKCF32gOErb6OyHxAY385iiQqKv2EI0sn+cNOM
	U0K3vgAOeyuLH93xEyYIcO98hzN0fFLRULFu/TIx74E6b2m8F7aRlXe4GY7Kjxos
	9jBT7ASC6js=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82A8728D8D;
	Tue, 23 Dec 2014 12:43:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C34828D8C;
	Tue, 23 Dec 2014 12:43:48 -0500 (EST)
In-Reply-To: <CANCZXo4daZffQ7binFpHBy9adKKeuwHuR5VRixXUowMdgAdhTQ@mail.gmail.com>
	(Alexander Kuleshov's message of "Tue, 23 Dec 2014 23:13:54 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 405AA2F4-8ACB-11E4-B377-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261748>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> install -d -m 755 '/usr/bin'
> Copying scripts to /usr/bin

As 'git grep "Copying scripts"' gives us nothing, the message is
obviously not what we are giving.  Perhaps you have a strange "install"
in your path that does not understand "-d" is a way to tell it to
make sure a directory exists (by creating one as necessary)?
