From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mixing and matching multiple projects
Date: Sun, 19 Feb 2012 16:36:57 -0800
Message-ID: <7vy5rynxw6.fsf@alter.siamese.dyndns.org>
References: <7vhayptght.fsf@alter.siamese.dyndns.org>
 <7v39a9tf45.fsf@alter.siamese.dyndns.org>
 <A5E8E180685CEF45AB9E737A010799802D972E@cdnz-ex1.corp.cubic.cub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Holding\, Lawrence" <Lawrence.Holding@cubic.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 01:37:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzHFb-0007CN-7C
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 01:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab2BTAhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 19:37:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2BTAhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 19:37:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10B4C6881;
	Sun, 19 Feb 2012 19:36:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sf2hcwxHILlCzMpyH865a4D3QRw=; b=t0x+Z7
	9f4XOmd/R61p4KWco4HxGzgpUDsrhIwMXo0a1TBO77K5PVlG0mnG46OPIy0w+SbH
	yz0gnVrzrD2rToNiTyYPr637ntB2ckKBBJivVflPRjSbKNRPIEFbzFZyTGemni5y
	VFTnONWvI5Vw3LULG99sLCiRanrw+xQmj5bsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uUDKFG4rKsItIUWUpKhtquUfe0R++Q/e
	e9GOARXThxd/tqG5ufkNr043+qDuM2Koevgi+bDE0Bpi1i/il4Y9MepZ+LsLfGPk
	8FgR7XnVZAAGewy15gm11Xtt5Wk9+m3yZG7iTw7MRolZAjVjOippohoc0X1uwRNi
	EsFgSDqQcAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0870C6880;
	Sun, 19 Feb 2012 19:36:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 977B7687F; Sun, 19 Feb 2012
 19:36:58 -0500 (EST)
In-Reply-To: <A5E8E180685CEF45AB9E737A010799802D972E@cdnz-ex1.corp.cubic.cub>
 (Lawrence Holding's message of "Mon, 20 Feb 2012 13:17:23 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF4DEF8E-5B5A-11E1-A791-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191033>

"Holding, Lawrence" <Lawrence.Holding@cubic.com> writes:

> How about 
> - creating a "driver" project in the superproject, 
> - add a .gitignore or .git/exclude entry for the
> /s/xyzzy/os/drivers/frotz folder into the os project
> - symlinking the /s/xyzzy/os/drivers/frotz folder to the
> /s/xyzzy/driver/frotz folder

Thanks.

I think that is essentially the same as what I wrote with "symlink" in my
last paragraph as a known-to-work workaround.  The real location of the
frotz driver, whether it is in a directory directly in the superproject,
or a separate submodule that is bound to the superproject outside the "os"
submodule, does not make an essential difference, as long as it is outside
"os".

I was asking if people who have used submodules have better solutions than
that "symlink" solution.
