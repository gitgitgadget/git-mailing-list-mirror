From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diffcore-rename: support rename cache
Date: Fri, 07 Nov 2008 15:17:54 -0800
Message-ID: <7vy6zvdt25.fsf@gitster.siamese.dyndns.org>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com>
 <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguy???n =?utf-8?Q?Th=C3=A1i?= Ng???c Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 00:19:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyabv-00062M-Ej
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 00:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbYKGXSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 18:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYKGXSK
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 18:18:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYKGXSJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2008 18:18:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A34094229;
	Fri,  7 Nov 2008 18:18:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9BE7094226; Fri, 
 7 Nov 2008 18:17:56 -0500 (EST)
In-Reply-To: <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net>
 (Yann Dirson's message of "Fri, 7 Nov 2008 23:21:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 565B796C-AD22-11DD-8A75-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100361>

Yann Dirson <ydirson@altern.org> writes:

> On Fri, Nov 07, 2008 at 09:35:32PM +0700, Nguy???n Th=C3=A1i Ng???c D=
uy wrote:
>> This patch teaches diffcore_rename() to look into
>> $GIT_DIR/rename-cache and make use of it to recreate diff_filepair.
>> With proper cache, there should be no available entry for estimation
>> after exact matching.
>
> This is something I have thought about in the past, good to see that
> implemented :)
>
>> Rename caching is per commit. I don't think abitrary tree-tree cachi=
ng
>> is worth it.
>
> That could be a nice complement to my directory-rename patch.

Has anybody thought about interaction between that caching and pathspec
limited operation?
