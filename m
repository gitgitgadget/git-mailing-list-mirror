From: Junio C Hamano <gitster@pobox.com>
Subject: Re: OS X Unicode Normalization Hits Again
Date: Mon, 08 Feb 2010 19:44:12 -0800
Message-ID: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
References: <C417EBAD-9254-448C-9FD1-2D2FABB8CF32@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 04:44:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neh1U-0005fO-LN
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 04:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329Ab0BIDoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 22:44:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0BIDoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 22:44:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B1C497E07;
	Mon,  8 Feb 2010 22:44:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FucX/sOrfavQawydZMjvMbwI9eM=; b=wROXL+
	CvtvfG5qiTd4VjFNvBggXD0pfK4P7nbrnfrTzh90F4OolGO15qXqoPwRuj0XYM3o
	wiWZ05FKqWfPXl7/GTwQ3KDHTIifiooXJ7SZqkHo5nGgwrOXt775aEiCoaHdoiDF
	C8EWYjgzOtjuRCFp3dozwGEZm2K/0e8WdUUOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JenDZqOptqqA7+pbaR0OcPng13uBh+7x
	Xk74h5kHfSNuQXGBgHPND5Y62NIlCAG+pvxZH9m3iO6h6aHEg/unD0sbeerT/YZR
	VzEjfabaW9tAHNK8+8bD1m6r6VxLSAoU7L1t1zskq97HMef7hSd6ieg2528mw8HO
	9HcOyMBWIOI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26D4797E06;
	Mon,  8 Feb 2010 22:44:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FBE997E05; Mon,  8 Feb
 2010 22:44:13 -0500 (EST)
In-Reply-To: <C417EBAD-9254-448C-9FD1-2D2FABB8CF32@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Mon\, 8 Feb 2010 22\:38\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 65466F94-152D-11DF-A4B3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139354>

How about using $FN as the directory name instead?
