From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: load refnames before calling describe()
Date: Mon, 19 Oct 2009 01:05:51 -0700
Message-ID: <7vy6n74xls.fsf@alter.siamese.dyndns.org>
References: <4AD9F138.3080405@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:06:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MznFt-0006Tr-T7
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765AbZJSIF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 04:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755754AbZJSIF5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:05:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733AbZJSIF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:05:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0BBDE7DABA;
	Mon, 19 Oct 2009 04:06:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=44zXNQSDctEP6RwxaD6gxidinTs=; b=PVNZr3ADV5VgT2Kii95rIy0
	YbzlKcRp7m4llSkwzzOH/XJrlMUzso2oL7rFZsu5UhhC0zrZgK4E3jvSyEjRaA4x
	QRrQT2NhPQvTBSWSxpPhGYQIapdoe1MTZCV9MgvrHyDeMv9jdG1s/ppNNZrOvTmX
	Cn24Mb0vFkKzvI34W5RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lku+pS0TdL9SIOGZF2y+TWgs5T44eYmeHMwRg8GuxhEH/es9h
	msvh1TQvc9xCQLRC1wx0yF8lPhYLUfffp7HdSMBRUMWFCrspPK/jMBZxW4/fkgmP
	rq01oWVSmc6zbNmfSicNJh17DRlUr9XTRbWd4uGmKTnKQKYtjGYQggNEr8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6A7D7DAB5;
	Mon, 19 Oct 2009 04:05:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7523B7DAAC; Mon, 19 Oct 2009
 04:05:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B8AB340-BC86-11DE-9864-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130675>

Thanks, applied.
