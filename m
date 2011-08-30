From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Makefile: Improve compiler header dependency check
Date: Tue, 30 Aug 2011 10:17:32 -0700
Message-ID: <7vbov63jkj.fsf@alter.siamese.dyndns.org>
References: <20110830040515.GC6647@elie.gateway.2wire.net>
 <1314692855-75113-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:17:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyRwS-0005GE-5r
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 19:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048Ab1H3RRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 13:17:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691Ab1H3RRe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 13:17:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 761FB40AE;
	Tue, 30 Aug 2011 13:17:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MStkbDsm8Az33q2hJKtftafuGSA=; b=gWLMfu
	pJzziwkXt0anDrR52JPxxGBZ6SCYHZAan7LqJZwqCgPoAbeO7AplaQk3NAOBHa0o
	hdxzJkPf+v4fK+Te62jQL4TldtvPfIhVKxKCzWuzbqrfFmi+PaK97Emup4v0tv82
	9SJnyVsfeEBigGiXCpK7T5f4BKChnQFuxekPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D9w/MZJwj8O8qDOeTlX1vCTaCQqcP8Qt
	z4AjA4xkWeChFPe6Z6fDExAHHmAhx2saYaHjwVspDiV4oTZrMWMrQ9DwStu6Juhb
	J6k1UA1qZRsrYr3yUrYBe+7iVBeRGNT360OwVXobxZ+Nil21GE+jLaiDld4Jmcmo
	zADZNxeo9x4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A2B740AC;
	Tue, 30 Aug 2011 13:17:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E530840A9; Tue, 30 Aug 2011
 13:17:33 -0400 (EDT)
In-Reply-To: <1314692855-75113-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Tue, 30 Aug 2011 01:27:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3441EC8-D32B-11E0-B993-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180420>

Thanks, both; will queue with the final paragraph updated to Jonathan's
suggestion.
