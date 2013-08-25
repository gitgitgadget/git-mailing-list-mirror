From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/13] Remove obscure reference from "Examples"
Date: Sat, 24 Aug 2013 20:53:45 -0700
Message-ID: <xmqq1u5imnna.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<883409466.1091151.1377329645768.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:53:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDROj-0003SG-9X
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669Ab3HYDxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:53:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416Ab3HYDxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:53:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4A712C44B;
	Sun, 25 Aug 2013 03:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9oE3BoBYZQ5Y2ee+iQEFKGnqz3w=; b=kGHdEO
	OWkJ3juZhvRnN0vO2GyRmc2JjgLTfejM7xOolbNkPmlb9LNvRiqFOUY9St5LPI2k
	QPpk71BVLrakiVGHgNtAGMntw4WjDgqHtV9yxpesx8UiGdfjsdDkhTHmzIW4X217
	0anh65lunbTwZ4zztQkDnl395Ej17X4l7YvoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kuBBteBIuOQGGGd/DmG5PkhVlZZ5Dk/z
	3fNZzZdLyaAfkdHGArEqKlXoPbmzWaganoWtPP9a4e4psL5HVJfRNLF4e9ZYi8Aj
	YW9vlSXCOs4SncK4RtMUhi2hPWhUN4CbcEdDgjj62zFwMpa9ItWBapEp/yFzJWl8
	ShYHvBuMYMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB4412C44A;
	Sun, 25 Aug 2013 03:53:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E1D22C449;
	Sun, 25 Aug 2013 03:53:47 +0000 (UTC)
In-Reply-To: <883409466.1091151.1377329645768.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:34:05 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1DC7180-0D39-11E3-9D22-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232906>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index aa6bfab..0d3f04e 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2131,8 +2131,6 @@ He uses two public branches:
>  
>   - A "test" tree into which patches are initially placed so that they
>     can get some exposure when integrated with other ongoing development.
> -   This tree is available to Andrew for pulling into -mm whenever he
> -   wants.
>  
>   - A "release" tree into which tested patches are moved for final sanity
>     checking, and as a vehicle to send them upstream to Linus (by sending

Hmm.... What part is obscure and why does this need to be removed?
