From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird problem with long $PATH and alternates (bisected)
Date: Sun, 26 Oct 2008 22:30:29 -0700
Message-ID: <7vskqiiozu.fsf@gitster.siamese.dyndns.org>
References: <237967ef0810260746w10e930c1sf36a2674f49afbe1@mail.gmail.com>
 <7vljwb5o4p.fsf@gitster.siamese.dyndns.org> <4904AE8D.9090706@lsrfire.ath.cx>
 <7v63nf5iy1.fsf@gitster.siamese.dyndns.org>
 <237967ef0810261129y58898019m503a1f1593a95591@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 06:32:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuKhu-0001LJ-Fq
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 06:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbYJ0Fat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 01:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYJ0Fat
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 01:30:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYJ0Fas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 01:30:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D07174982;
	Mon, 27 Oct 2008 01:30:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9BBA67497E; Mon, 27 Oct 2008 01:30:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69013A22-A3E8-11DD-8D24-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99204>

"Mikael Magnusson" <mikachu@gmail.com> writes:

> 2008/10/26 Junio C Hamano <gitster@pobox.com>:
> ...
>> I think the previous patch to sha1_file.c, while it may fix the issue, is
>> not quite nice.  Here is a replacement that should work.
>
> It does.

Thanks.
