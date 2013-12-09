From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: fix status with branch...rebase=preserve
Date: Mon, 09 Dec 2013 13:18:52 -0800
Message-ID: <xmqqiouxwwn7.fsf@gitster.dls.corp.google.com>
References: <1386421717-27698-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Jay Soffian <jaysoffian@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq8EI-0006SW-FE
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761502Ab3LIVS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:18:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab3LIVS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:18:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9FA4597A6;
	Mon,  9 Dec 2013 16:18:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=oBYKxy
	OoAalbtCXGrN/3P6IvXBFDgoS2Q7uZFDJpPFD54TsiJ4MwElmVMfnhpdIVLZ7ZOv
	Fx3fXqo2HsZGC/1rBdsqZoTLhiGVZBGR1pkO+xgpUy3uqPrhT2QooK08SoS0jyk8
	Cnb5zda0wSDEHJYoDSahfgoB6ehiEkrTr7q14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WbaPF+oPO/JoiwvqjI4ctaFeXTB+kxvT
	ZQF7oyuXiNr7FPbEDNQo8VPvm8UpNi9JFT3DVLk0f1zT/0CEW4DWvsIOTbvuvyb1
	tz9FIDc1UA4xxgjOzJJe8+9RbJd133ufjbU6rR1KbZx7mlUo+8AswHDeD5wehF7b
	rajXhCRyBX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98C79597A5;
	Mon,  9 Dec 2013 16:18:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4F0A597A3;
	Mon,  9 Dec 2013 16:18:54 -0500 (EST)
In-Reply-To: <1386421717-27698-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 7 Dec 2013 07:08:37 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8243184C-6117-11E3-ACB0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239106>

Thanks, will queue.
