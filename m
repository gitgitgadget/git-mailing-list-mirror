From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] index_pack: indent find_unresolved_detals one level
Date: Fri, 09 Dec 2011 13:27:00 -0800
Message-ID: <7vpqfxcu6z.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJvrk3Jzg3dQhQnfbmKAFovLuEtJAP4rakHPFeuZ0T5R7g@mail.gmail.com>
 <4ee0be67.05c1e70a.1956.ffff800b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 09 22:27:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ7yJ-0007f7-3d
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 22:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab1LIV1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 16:27:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab1LIV1E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 16:27:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBF22767D;
	Fri,  9 Dec 2011 16:27:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cdsvblsPN9A1
	ZFECMtKA/ZJe3Nk=; b=t/rlPjYRs/S8M8+9Abvx1iNwziuXznExGLH2OTgiRYdj
	lavfp5TOSdH46UYCl5gGGZo225qxza36ORIkt+FIOT6VheX+JlHK7qHxrwGtg6HO
	gYIH+7Mq8q7snqIFjpDKUg/hi3cz4cyJQ9XXCeEl9PpsW80AVPo9Pv4S5iWqUMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wcJToX
	fnluiY5bYwS3cAzLpLQ6JXMSuGEdQigdIpvkNHKyAw5E7HCHNQ9HOO2I4axDr49T
	tkHU8FRXrZgcbIgM7ZX3YNd9xHo2+zoO3rFZLDV04OrlLS3P0HBrQ27DZjFteb6s
	eBRwOJ+pRgB2ERjWbcZ/0du93Y8mJ30g8RR1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E355C767C;
	Fri,  9 Dec 2011 16:27:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61F3B767A; Fri,  9 Dec 2011
 16:27:02 -0500 (EST)
In-Reply-To: <4ee0be67.05c1e70a.1956.ffff800b@mx.google.com>
 (pclouds@gmail.com's message of "Thu, 8 Dec 2011 20:40:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88E2F7FE-22AC-11E1-81A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186697>

pclouds@gmail.com writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> The next patch puts most of the code in one level deeper. By indentin=
g
> separately, it'd be easier to see the actual changes.

Yuck.

Isn't it a sign that "the next patch" should perhaps be helped by a sma=
ll
helper function that does whatever the part you are indenting here?
