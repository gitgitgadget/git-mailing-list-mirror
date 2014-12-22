From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 0/7] atomic pushes
Date: Mon, 22 Dec 2014 10:24:37 -0800
Message-ID: <xmqqbnmva6fu.fsf@gitster.dls.corp.google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 19:24:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37ex-0002Ar-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 19:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbaLVSYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 13:24:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754134AbaLVSYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 13:24:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E079128D59;
	Mon, 22 Dec 2014 13:24:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7vKucxdI4wYc9t2nX+AOOcro2ss=; b=F27paB
	WBQt5pdeFVrV4uWxHbl49UTwZ2NmYwjwOglnnCTn1MXsikx1cOaBUcwwt7slRn8g
	KEe/nv4MOm8UQdCn3mAIpApu0SaOho+znh97504uNlC+EWk5UBKUyAYIG0RnS4mm
	T0yh+vkQbPi3vFde9FVK044q+D+GkoyCRBUdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UDlp1/2lgLRH1LbLz+Z1zFVPjrl59miE
	2NNF4rOHGOk1xyeiIoKDa8OK6S1i4JgnmGBRN36jIyQpiUhVnoe6Mc04IgvM4vNX
	sUQueDZ07D+pXi/flHdnWRNImX7hi34+LBcWsDi1zs9A0fFd8jkndmKLQRO1Riil
	aHghF7NVQ0Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D66C328D58;
	Mon, 22 Dec 2014 13:24:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D82528D57;
	Mon, 22 Dec 2014 13:24:38 -0500 (EST)
In-Reply-To: <1419017941-7090-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 19 Dec 2014 11:38:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C9DB169A-8A07-11E4-8893-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261663>

Will queue; thanks for a pleasant read.
