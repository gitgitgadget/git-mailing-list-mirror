From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitweb: false base href sent when integrated via reverse proxy
 and path_info is active
Date: Tue, 30 Nov 2010 19:25:10 -0800
Message-ID: <7v8w0aw4x5.fsf@alter.siamese.dyndns.org>
References: <20101128081048.13668.67286.reportbug@sb74.startrek>
 <201011281847.40233.jnareb@gmail.com> <20101128181215.GB19545@burratino>
 <201011301922.11695.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, Daniel Reichelt <debian@nachtgeist.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 04:25:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNdK0-00068t-5k
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 04:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab0LADZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 22:25:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab0LADZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 22:25:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB86A358A;
	Tue, 30 Nov 2010 22:25:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RMX3+a+xLBlas+CdyLAY85bua3g=; b=VvUs3Y
	whREX4vhKRiHesx2XxIXeE1WCc5kgMiVgJcZpCAkLr2r4wDytXu4wQTitNqKhoS3
	4L8quMmtCSlHI5u8g+Z8fw0oZ4oauTWMBfVVmygW/HwxQoudDByM2NlKxVqIk5pX
	BUc1Rps062XxuVFGZ8azFz0aYNyTVzY2cLdPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bmFcvzy5l9es0onDlKLoNlF+Kgbhu2h8
	w0gMCKXWpcOxA4GY1oAbN5ixRh9kWTILGE4g3TJXYukHt01QKpbP+okWx3CTimX1
	2TRN2iblN7fOvdKOS9ifu9mqSt/gyEdO1TmupNVwcG4vukDGz1jEWDfGSezlXJKa
	/JNaflP8qyQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D2073589;
	Tue, 30 Nov 2010 22:25:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16FCD3588; Tue, 30 Nov 2010
 22:25:30 -0500 (EST)
In-Reply-To: <201011301922.11695.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue\, 30 Nov 2010 19\:22\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA686626-FCFA-11DF-A886-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162495>

Jakub Narebski <jnareb@gmail.com> writes:

> Well, both git-gui and gitk have their documentation in Documentation/
> (in AsciiDoc format), so perhaps it is time to add Documentation/gitweb.txt
> and possibly also Documentation/gitweb_config.txt (or gitweb.conf.txt).

That indeed sounds like a good idea to me.
