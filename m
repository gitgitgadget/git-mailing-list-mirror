From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our
 Documentation/
Date: Fri, 09 Sep 2011 10:37:24 -0700
Message-ID: <7v4o0lvcq3.fsf@alter.siamese.dyndns.org>
References: <4E6A23DB.1040606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 19:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R251E-0005ux-F0
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 19:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759561Ab1IIRh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 13:37:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759356Ab1IIRh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 13:37:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 189F859AD;
	Fri,  9 Sep 2011 13:37:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AUK97sa4PdIY1wYucVY0yW3Rcbk=; b=YXx3fq
	RMpoBrUSLCqx9aJLv3iiYcnepp6DuKJXi2PlHZI9HEDXvV5IoJtcib0BSSPwRj75
	1Ucd/OStlWp/Gq2b6clQTImR6jO80DdAWN8r/WJKVWeLGfmoKzMwVJJ1TqiGKf3s
	aEHIPeUjaZj1Jhrk+OTK5ZPp+DrwQ8EoSlATY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Izq+aBLO5jzfMTPhofA3kDgZ7kOkwUGs
	aKRQtYKdu9VmUVmztHM17ZUlHi7HkpstkcElbdc/Tp3y0aI3EiyUaPwHRZh4JeGy
	Bg+w8xKZhpUPatD9iQfBP639OPPnagRqFfrqCQMxQm4b9dt5LY/h/jngbbqzEC87
	2HTPZdSYYss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E9DA59AC;
	Fri,  9 Sep 2011 13:37:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9585659AB; Fri,  9 Sep 2011
 13:37:25 -0400 (EDT)
In-Reply-To: <4E6A23DB.1040606@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 09 Sep 2011 16:34:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61B0883E-DB0A-11E0-8C56-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181096>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Our own customisation is not loaded (of course) so that, e.g., the
> linkgit macro does not work; and the include statement makes GitHub's
> parser unhappy and choke.
>
> Does anybody feel this is worth pursuing?
>
> + Nicer blob view
> + Simpler way to judge documentation changes
> - Need to get our asciidoc config in there
> - GitHub's parser neeeds to learn include

Personally I am not very interested. Couldn't you just visit the html
branch instead for viewing?
