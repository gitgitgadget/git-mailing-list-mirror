From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Fri, 04 Jan 2013 15:20:51 -0800
Message-ID: <7vobh4sffw.fsf@alter.siamese.dyndns.org>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com>
 <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Manlio Perillo'" <manlio.perillo@gmail.com>,
	"'git\@vger.kernel.org'" <git@vger.kernel.org>,
	"'szeder\@ira.uka.de'" <szeder@ira.uka.de>,
	"'felipe.contreras\@gmail.com'" <felipe.contreras@gmail.com>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 00:21:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrGZe-0004qt-Mo
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 00:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab3ADXUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 18:20:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab3ADXUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 18:20:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51019ADA6;
	Fri,  4 Jan 2013 18:20:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vqgPoFMtfe1a4Cztd/bukXxgfL8=; b=omRYxH
	+hkW2WX0SaWzFm+ayqWr2UQrZSOp3AideNrDiCzkrMPSis7akeazpT/dcF/t3WO8
	VdrqqjA4zqhqpYpy/o5czutIWeTln4gX1aq4afxk5hqE4YQfJCDt0Y3XCSWQ27cR
	6BQ8h0/8wjil/AWOWkv7PaGxvXMDBl7jRPMRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p0r9EeUrC2+zdXb+MuFEi48zro/zBkZx
	rHaWrHIbuz/6iWI0rYiJjxKM9X7VsDk8lVIWbjpfOaVwxFeKHy+2OF+RAHbuociB
	whCO9vVWzvFj24yNKDp33HZzRw7vy7D8E8l71cb5sed5xKatZwMM6mc0z05J/qDh
	oegdxEvLeaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40DBFADA5;
	Fri,  4 Jan 2013 18:20:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B37E5ADA2; Fri,  4 Jan 2013
 18:20:52 -0500 (EST)
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se>
 (Marc Khouzam's message of "Fri, 4 Jan 2013 21:25:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6202D5FC-56C5-11E2-A73B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212652>

Marc Khouzam <marc.khouzam@ericsson.com> writes:

> I've been playing with it but I'm not getting the expected 
> behavior when I cd to a sub-directory.

Thanks for testing.  Manlio?
