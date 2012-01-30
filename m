From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Sun, 29 Jan 2012 20:27:44 -0800
Message-ID: <7vd3a1erwf.fsf@alter.siamese.dyndns.org>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
 <20120130023642.GA14986@burratino>
 <CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 05:28:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rriqo-0002yy-4L
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 05:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab2A3E1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 23:27:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab2A3E1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 23:27:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF337700C;
	Sun, 29 Jan 2012 23:27:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90g7YpBACF3bIRy9cpjg9Lh7NGc=; b=GRd0P/
	D+hA8FaFRlho5EQpx7wrK/AzZBgwssJRD2ukhyehf6+1XaP2UyWMY45Ns/+1YllV
	oY+UmdjAtR/zKHT+zsLddEi5Hj15Y51QFhR7Cvc32a9imBP+29jtDK41PWoXTYRi
	yw4y4KnrkPTCjEpXnQSotdIRo3sSoh4sE1NIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EmVHR/7j/D2gctqqbpFRlOsykxfOKm2y
	HdlCha968w0HIKPe1+/nzU0fWdM8cO2Shnj2vvrNxBC1XadFunNIRzq6ylmB4A1f
	fBbmJhl9K4cz+vg03SIdZYfpp9UMiMS1TwpfzlT0TvsXrjlmk6L3KXNyZUIUwPxx
	kUH3/MDW5wQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA187700A;
	Sun, 29 Jan 2012 23:27:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50A967009; Sun, 29 Jan 2012
 23:27:46 -0500 (EST)
In-Reply-To: <CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 30 Jan 2012 05:24:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2822630-4AFA-11E1-A7C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189321>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> OK, maybe some people use it, but most likely they are using an old
> version of git, and thus an old version of the completion script.

Please adjust your attitude about backward compatibility to match the
standard used for other parts of Git.

Most likely they are using repositories that they started using with an
old version, but at the same time, most likely they are happily using more
modern version exactly because the rest of Git still support it, except
for the completion script after _this_ patch breaks the support.
